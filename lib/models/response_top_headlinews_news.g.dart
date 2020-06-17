// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'response_top_headlinews_news.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

News _$ResponseTopHeadlinesNewsFromJson(
    Map<String, dynamic> json) {
  return News(
    int.parse(json['id']),
    json['title'] as String,
    json['content'] as String,
    json['author'] as String,
    int.parse(json['newsType']),
    DateTime.parse(json['newsTime']),
    json['newsStatus'] as String,
    json['newsImage'] as String,
    null,
  );
}

Map<String, dynamic> _$ResponseTopHeadlinesNewsToJson(
        News instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'author': instance.author,
      'newsType': instance.newsType,
      'newsTime': instance.newsTime,
      'newsStatus': instance.newsStatus,
      'newsImage': instance.newsImage,
    };

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return Article(
    json['source'] == null
        ? null
        : Source.fromJson(json['source'] as Map<String, dynamic>),
    json['author'] as String,
    json['title'] as String,
    json['description'] as String,
    json['url'] as String,
    json['urlToImage'] as String,
    json['publishedAt'] as String,
    json['content'] as String,
  );
}

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'source': instance.source,
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
    };

Source _$SourceFromJson(Map<String, dynamic> json) {
  return Source(
    json['name'] as String,
  );
}

Map<String, dynamic> _$SourceToJson(Source instance) => <String, dynamic>{
      'name': instance.name,
    };
