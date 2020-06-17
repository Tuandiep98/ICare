import 'package:json_annotation/json_annotation.dart';
part 'response_top_headlinews_news.g.dart';

@JsonSerializable()
class News{
  int id;
  String title;
  String content;
  String author;
  int newsType;
  DateTime newsTime;
  String newsStatus;
  String newsImage;
  @JsonKey(ignore: true)
  String error;

  News(this.id,this.title,this.content,this.author,this.newsType,this.newsTime,this.newsStatus,this.newsImage,this.error);

  factory News.fromJson(Map<String, dynamic> json) =>
      _$ResponseTopHeadlinesNewsFromJson(json);

  News.withError(this.error);

  Map<String, dynamic> toJson() => _$ResponseTopHeadlinesNewsToJson(this);

  @override
  String toString() {
    return 'News{id: $id, title: $title, content: $content, author: $author, newsType: $newsType, newsTime: $newsTime, newsStatus: $newsStatus, newsImage: $newsImage, error: $error}';
  }


}

@JsonSerializable()
class Article {
  Source source;
  String author;
  String title;
  String description;
  String url;
  String urlToImage;
  String publishedAt;
  String content;

  Article(this.source, this.author, this.title, this.description, this.url,
      this.urlToImage, this.publishedAt, this.content);

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  @override
  String toString() {
    return 'Article{source: $source, author: $author, title: $title, description: $description, url: $url, urlToImage: $urlToImage, publishedAt: $publishedAt, content: $content}';
  }
}

@JsonSerializable()
class Source {
  String name;

  Source(this.name);

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);

  @override
  String toString() {
    return 'Source{name: $name}';
  }

}
