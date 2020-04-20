// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchResult _$SearchResultFromJson(Map<String, dynamic> json) {
  return SearchResult(
    (json['Search'] as List)
        ?.map((e) =>
            e == null ? null : Search.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['totalResults'] as String,
    json['Response'] as String,
  );
}

Map<String, dynamic> _$SearchResultToJson(SearchResult instance) =>
    <String, dynamic>{
      'Search': instance.searchList,
      'totalResults': instance.totalResults,
      'Response': instance.response,
    };
