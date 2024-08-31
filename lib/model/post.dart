class Post {
  int? albumId;
  int? id;
  String? title;
  String? url;
  String? thumbnailUrl;
  String? body;

  Post({this.albumId, this.id, this.title, this.body, this.url, this.thumbnailUrl});

  Post.fromJson(Map<String, dynamic> json)
      : albumId = json['albumId'],
        id = json['id'],
        title = json['title'],
        url = json['url'],
        thumbnailUrl = json['thumbnailUrl'],
        body = json['body'];

  Map<String, dynamic> toJson() => {
    'albumId': albumId,
    'id': id,
    'title': title,
    'url': url,
    'thumbnailUrl': thumbnailUrl,
    'body': body,
      };
}

