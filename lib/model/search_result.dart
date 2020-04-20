import 'package:json_annotation/json_annotation.dart';
import 'package:tradexaassignment/model/search_model.dart';

part 'search_result.g.dart';

@JsonSerializable()
class SearchResult {
  @JsonKey(name: 'Search')
  List<Search> searchList;

  @JsonKey(name: 'totalResults')
  String totalResults;

  @JsonKey(name: 'Response')
  String response;

  SearchResult(this.searchList, this.totalResults, this.response);

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory SearchResult.fromJson(Map<String, dynamic> json) =>
      _$SearchResultFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$SearchResultToJson(this);
}
