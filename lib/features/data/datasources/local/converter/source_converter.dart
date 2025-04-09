import 'dart:convert';
import 'package:floor/floor.dart';
import 'package:news_app/features/data/models/top_news_model.dart';

class SourceConverter extends TypeConverter<SourceModel, String> {
  @override
  SourceModel decode(String databaseValue) {
    final Map<String, dynamic> json = jsonDecode(databaseValue);
    return SourceModel.fromMap(json);
  }

  @override
  String encode(SourceModel value) {
    return jsonEncode(value.toMap());
  }
}
