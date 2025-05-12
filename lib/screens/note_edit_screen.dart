import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:note_app1/controllers/note_controller.dart';
import 'package:note_app1/generated/app_localizations.dart';
import 'package:note_app1/models/note.dart';

class NoteEditScreen extends StatelessWidget {
  final Note? note;
  NoteEditScreen({super.key, this.note});
  final NoteController noteController = Get.find();
  final TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var loc = AppLocalizations.of(context);
    if (note != null) {
      textController.text = note!.content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          note == null ? loc.addNote : loc.editNote,
          style: TextStyle(fontSize: 20.sp),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          children: [
            TextField(
              controller: textController,
              decoration: InputDecoration(
                hintText: loc.noteHint,
                border: OutlineInputBorder(),
              ),
              maxLines: 5,
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () async {
                if (textController.text.isNotEmpty) {
                  if (note == null) {
                    await noteController.addNote(textController.text);
                  } else {
                    await noteController.updateNote(
                      note!.id,
                      textController.text,
                    );
                  }
                  Get.back();
                }
              },
              child: Text(loc.save, style: TextStyle(fontSize: 16.sp)),
            ),
          ],
        ),
      ),
    );
  }
}
