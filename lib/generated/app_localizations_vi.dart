// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'Ứng dụng Ghi chú';

  @override
  String get addNote => 'Thêm Ghi chú';

  @override
  String get editNote => 'Sửa Ghi chú';

  @override
  String get noteHint => 'Nhập ghi chú của bạn';

  @override
  String get save => 'Lưu';

  @override
  String get delete => 'Xóa';

  @override
  String get language => 'Ngôn ngữ';

  @override
  String get english => 'Tiếng Anh';

  @override
  String get vietnamese => 'Tiếng Việt';

  @override
  String get japanese => 'Tiếng Nhật';

  @override
  String get noNotes => 'Không có ghi chú nào';
}
