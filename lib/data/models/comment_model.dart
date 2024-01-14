class CommentModel {
  final String userId;
  final String comment;
  final DateTime timestamp;

  CommentModel({
    required this.userId,
    required this.comment,
    required this.timestamp,
  });

  toJson() => {
        'userId': userId,
        'comment': comment,
        'timestamp': timestamp,
      };

  factory CommentModel.fromSnapshot(Map<String, dynamic> document) {
    final data = document;
    return CommentModel(
      userId: data['userId'],
      comment: data['comment'],
      timestamp: data['timestamp'].toDate(),
    );
  }

  factory CommentModel.fromMap(Map<String, dynamic> data) {
    return CommentModel(
      userId: data['userId'],
      comment: data['comment'],
      timestamp: data['timestamp'].toDate(),
    );
  }
}
