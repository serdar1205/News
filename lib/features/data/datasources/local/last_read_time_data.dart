import 'package:shared_preferences/shared_preferences.dart';

class LastReadTimeDataPref {
  final SharedPreferences _sharedPreferences;

  LastReadTimeDataPref(this._sharedPreferences);

  Future<void> setLastReadTime(String articleId) async {
    _sharedPreferences.setString(
        'last_read_$articleId', DateTime.now().toIso8601String());
  }

  Future<DateTime?> getLastReadTime(String articleId) async {
    final timeStr = _sharedPreferences.getString('last_read_$articleId');
    return timeStr != null ? DateTime.tryParse(timeStr) : null;
  }
}
