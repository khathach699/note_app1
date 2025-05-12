import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note_app1/controllers/language_controller.dart';
import 'package:note_app1/controllers/note_controller.dart';
import 'package:note_app1/generated/app_localizations.dart';
import 'package:note_app1/screens/note_edit_screen.dart';

class NoteScreens extends StatelessWidget {
  final NoteController noteController = Get.put(NoteController());
  final LanguageController languageController = Get.find<LanguageController>();

  NoteScreens({super.key}) {
    // Ensure controllers are initialized
    if (!Get.isRegistered<LanguageController>()) {
      Get.put(LanguageController());
    }
  }

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(loc.appTitle)),
      body: Column(
        children: [
          // Nút chọn ngôn ngữ
          Padding(
            padding: EdgeInsets.all(8.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => languageController.changeLanguage('en'),
                  child: Text(loc.english, style: TextStyle(fontSize: 14.sp)),
                ),
                SizedBox(width: 8.w),
                ElevatedButton(
                  onPressed: () => languageController.changeLanguage('vi'),
                  child: Text(
                    loc.vietnamese,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
                SizedBox(width: 8.w),
                ElevatedButton(
                  onPressed: () => languageController.changeLanguage('ja'),
                  child: Text(loc.japanese, style: TextStyle(fontSize: 14.sp)),
                ),
              ],
            ),
          ),
          // Danh sách ghi chú
          Expanded(
            child: Obx(
              () =>
                  noteController.notes.isEmpty
                      ? Center(child: Text(loc.noNotes))
                      : ListView.builder(
                        itemCount: noteController.notes.length,
                        itemBuilder: (context, index) {
                          final note = noteController.notes[index];
                          return ListTile(
                            title: Text(
                              note.content,
                              style: TextStyle(fontSize: 16.sp),
                            ),
                            onTap: () {
                              Get.to(() => NoteEditScreen(note: note));
                            },
                            trailing: IconButton(
                              icon: Icon(Icons.delete),
                              onPressed:
                                  () => noteController.deleteNote(note.id),
                              tooltip: loc.delete,
                            ),
                          );
                        },
                      ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => NoteEditScreen());
        },
        tooltip: loc.addNote,
        child: Icon(Icons.add),
      ),
    );
  }
}
