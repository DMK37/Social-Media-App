import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/data/models/comment_model.dart';

class PostModel {
  final String? postId;
  final String userId;
  final String imageUrl;
  final String description;
  final List<CommentModel> comments;
  final List<String> likes;
  final List<String> tags;
  final DateTime timestamp;
  PostModel({
    this.postId,
    required this.userId,
    required this.imageUrl,
    required this.description,
    required this.comments,
    required this.likes,
    required this.tags,
    required this.timestamp,
  });

  toJson() => {
        'userId': userId,
        'imageUrl': imageUrl,
        'description': description,
        'likes': likes,
        'comments': comments.map((e) => e.toJson()).toList(),
        'tags': tags,
        'timestamp': timestamp,
      };

  factory PostModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return PostModel(
      postId: document.id,
      userId: data['userId'],
      imageUrl: data['imageUrl'],
      description: data['description'],
      comments: List<CommentModel>.from(data['comments'].map((e) => CommentModel.fromMap(e))),
      likes: List<String>.from(data['likes']),
      tags: List<String>.from(data['tags']),
      timestamp: data['timestamp'].toDate(),
    );
  }

  factory PostModel.fromMap(Map<String, dynamic> data) {
    return PostModel(
      userId: data['userId'],
      imageUrl: data['imageUrl'],
      description: data['description'],
      comments: List<CommentModel>.from(data['comments'].map((e) => CommentModel.fromMap(e))),
      likes: List<String>.from(data['likes']),
      tags: List<String>.from(data['tags']),
      timestamp: data['timestamp'].toDate(),
    );
  }
}
