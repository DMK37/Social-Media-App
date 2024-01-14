class CommentModel {
  final String avatar;
  final String username;
  final String comment;
  final DateTime timestamp;

  CommentModel({
    required this.avatar,
    required this.username,
    required this.comment,
    required this.timestamp,
  });

  toJson() => {
        'avatar': avatar,
        'username': username,
        'comment': comment,
        'timestamp': timestamp,
      };

  factory CommentModel.fromSnapshot(
      Map<String, dynamic> document) {
    final data = document;
    return CommentModel(
      avatar: data['avatar'],
      username: data['username'],
      comment: data['comment'],
      timestamp: data['timestamp'].toDate(),
    );
  }

  factory CommentModel.fromMap(Map<String, dynamic> data) {
    return CommentModel(
      avatar: data['avatar'],
      username: data['username'],
      comment: data['comment'],
      timestamp: data['timestamp'].toDate(),
    );
  }

}
