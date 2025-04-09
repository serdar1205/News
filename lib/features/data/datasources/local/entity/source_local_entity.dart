import 'package:news_app/features/domain/entities/top_news_entity.dart';
import 'package:floor/floor.dart';


@entity
class SourceLocalEntity {
  @primaryKey
  final String? id;
  final String name;

  SourceLocalEntity({
    required this.id,
    required this.name,
  });

  SourceEntity toEntity(){
    return SourceEntity(id: id, name: name);
  }
}
