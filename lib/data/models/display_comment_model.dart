class DisplayCommentModel {
  final String avatar;
  final String username;
  final String comment;
  final DateTime timestamp;

  DisplayCommentModel({
    required this.avatar,
    required this.username,
    required this.comment,
    required this.timestamp,
  });

  factory DisplayCommentModel.fromJson(Map<String, dynamic> json) {
    return DisplayCommentModel(
      avatar: json['avatar'],
      username: json['username'],
      comment: json['comment'],
      timestamp: json['timestamp'].toDate(),
    );
  }

  Map<String, dynamic> toJson() => {
        'avatar': avatar,
        'username': username,
        'comment': comment,
        'timestamp': timestamp,
      };
}