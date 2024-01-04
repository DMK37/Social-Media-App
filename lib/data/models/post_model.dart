import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  final String? postId;
  final String userId;
  final String imageUrl;
  final String description;
  //final List<String> likedBy;
  final List<String> tags;
  final DateTime timestamp;
  PostModel({
    this.postId,
    required this.userId,
    required this.imageUrl,
    required this.description,
    //required this.likedBy,
    required this.tags,
    required this.timestamp,
  });

  toJson() => {
        'userId': userId,
        'imageUrl': imageUrl,
        'description': description,
        //'likedBy': likedBy,
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
      //likedBy: data['likedBy'],
      tags: data['tags'],
      timestamp: data['timestamp'].toDate(),
    );
  }
}
