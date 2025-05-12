import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import '../models/note.dart';
import '../services/database_service.dart';

class NoteController extends GetxController {
  var notes = <Note>[].obs;
  final DatabaseService _databaseService = DatabaseService();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    loadNotes();
    Connectivity().onConnectivityChanged.listen((result) {
      if (result != ConnectivityResult.none) {
        syncNotes();
      }
    });
  }

  Future<bool> isConnected() async {
    var result = await Connectivity().checkConnectivity();
    return result != ConnectivityResult.none;
  }

  Future<void> loadNotes() async {
    notes.value = await _databaseService.getNotes();
    if (await isConnected()) {
      await syncNotes();
    }
  }

  Future<void> addNote(String content) async {
    if (content.isNotEmpty) {
      final note = Note(id: DateTime.now().toString(), content: content);
      await _databaseService.insertNote(note);
      bool isOnline = await isConnected();
      if (isOnline) {
        await _firestore
            .collection('notes')
            .doc(note.id)
            .set(note.toFirestore());
        await _databaseService.updateNote(
          Note(
            id: note.id,
            content: note.content,
            isSynced: true,
            updatedAt: note.updatedAt,
          ),
        );
      }
      await loadNotes();

      if (isOnline) {
        Get.snackbar(
          'Success',
          'Note synced to cloud',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
      } else {
        Get.snackbar(
          'Info',
          'Note saved locally. Will sync when online',
          snackPosition: SnackPosition.TOP,
          duration: const Duration(seconds: 2),
        );
      }
    }
  }

  Future<void> updateNote(String id, String newContent) async {
    if (newContent.isNotEmpty) {
      final note = Note(
        id: id,
        content: newContent,
        updatedAt: DateTime.now(), // Cập nhật thời gian
      );
      await _databaseService.updateNote(note);
      if (await isConnected()) {
        await _firestore.collection('notes').doc(id).update(note.toFirestore());
        await _databaseService.updateNote(
          Note(
            id: id,
            content: newContent,
            isSynced: true,
            updatedAt: note.updatedAt,
          ),
        );

        Get.snackbar('Success', 'Note updated and synced');
      } else {
        Get.snackbar('Info', 'Note updated locally. Will sync when online');
      }
      await loadNotes();
    }
  }

  Future<void> deleteNote(String id) async {
    await _databaseService.deleteNote(id);
    if (await isConnected()) {
      await _firestore.collection('notes').doc(id).delete();
      Get.snackbar('Success', 'Note deleted and synced');
    } else {
      Get.snackbar('Info', 'Note deleted locally. Will sync when online');
    }
    await loadNotes();
  }

  Future<void> syncNotes() async {
    final unsyncedNotes = await _databaseService.getUnsyncedNotes();
    if (unsyncedNotes.isNotEmpty) {
      for (var note in unsyncedNotes) {
        await _firestore
            .collection('notes')
            .doc(note.id)
            .set(note.toFirestore());
        await _databaseService.updateNote(
          Note(
            id: note.id,
            content: note.content,
            isSynced: true,
            updatedAt: note.updatedAt,
          ),
        );
      }
    }

    // Đồng bộ từ Firestore về SQLite, xử lý xung đột
    final firestoreNotes = await _firestore.collection('notes').get();
    for (var doc in firestoreNotes.docs) {
      final firestoreNote = Note.fromFirestore(doc.data(), doc.id);
      final localNotes = await _databaseService.getNotes();
      final localNote = localNotes.firstWhere(
        (note) => note.id == firestoreNote.id,
        orElse: () => Note(id: '', content: ''),
      );

      if (localNote.id.isEmpty) {
        // Ghi chú không tồn tại cục bộ, thêm mới
        await _databaseService.insertNote(firestoreNote);
      } else if (firestoreNote.updatedAt.isAfter(localNote.updatedAt)) {
        // Firestore mới hơn, cập nhật cục bộ
        await _databaseService.updateNote(firestoreNote);
      } else if (localNote.updatedAt.isAfter(firestoreNote.updatedAt) &&
          !localNote.isSynced) {
        // Cục bộ mới hơn và chưa đồng bộ, cập nhật Firestore
        await _firestore
            .collection('notes')
            .doc(localNote.id)
            .set(localNote.toFirestore());
        await _databaseService.updateNote(
          Note(
            id: localNote.id,
            content: localNote.content,
            isSynced: true,
            updatedAt: localNote.updatedAt,
          ),
        );
      }
    }
    await loadNotes();
  }
}
