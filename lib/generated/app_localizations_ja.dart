// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'ノートアプリ';

  @override
  String get addNote => 'ノートを追加';

  @override
  String get editNote => 'ノートを編集';

  @override
  String get noteHint => 'ノートを入力';

  @override
  String get save => '保存';

  @override
  String get delete => '削除';

  @override
  String get language => '言語';

  @override
  String get english => '英語';

  @override
  String get vietnamese => 'ベトナム語';

  @override
  String get japanese => '日本語';

  @override
  String get noNotes => 'ノートがありません';
}
