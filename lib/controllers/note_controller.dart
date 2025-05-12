import 'package:get/get.dart';
import 'package:note_app1/models/note.dart';
import 'package:note_app1/services/database_service.dart';

class NoteController extends GetxController {
  var notes = <Note>[].obs;
  final DatabaseService _databaseService = DatabaseService();

  @override
  void onInit() {
    super.onInit();
    loadNotes();
  }

  Future<void> loadNotes() async {
    notes.value = await _databaseService.getNotes();
  }

  Future<void> addNote(String content) async {
    if (content.isNotEmpty) {
      final note = Note(id: DateTime.now().toString(), content: content);
      await _databaseService.insertNote(note);
      await loadNotes();
    }
  }

  Future<void> updateNote(String id, String newContent) async {
    if (newContent.isNotEmpty) {
      final note = Note(id: id, content: newContent);
      await _databaseService.updateNote(note);
      await loadNotes();
    }
  }

  Future<void> deleteNote(String id) async {
    await _databaseService.deleteNote(id);
    await loadNotes();
  }
}
