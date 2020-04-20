import 'package:json_annotation/json_annotation.dart';

part 'search_model.g.dart';

@JsonSerializable()
class Search {
  @JsonKey(name: 'Title')
  String title;
  @JsonKey(name: 'Year')
  String year;
  @JsonKey(name: 'imdbID')
  String imdbID;
  @JsonKey(name: 'Type')
  String type;
  @JsonKey(name: 'Poster')
  String poster;

  Search(this.title, this.year, this.imdbID, this.type, this.poster);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Search.fromJson(Map<String, dynamic> json) => _$SearchFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SearchToJson(this);
}
