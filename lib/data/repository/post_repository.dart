import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/data/models/post_model.dart';

class PostRepository {
  final _db = FirebaseFirestore.instance;

  Future<PostModel> createPost(PostModel post) async {
    final doc = await _db.collection('posts').add(post.toJson());
    return PostModel.fromSnapshot(await doc.get());
  }

  Future<PostModel?> getPost(String postId) async {
    final post = await _db.collection('posts').doc(postId).get();
    if (post.exists) {
      return PostModel.fromSnapshot(post);
    }
    return null;
  }

  Future<List<PostModel>> getPosts(String userId) async {
    final posts = await _db
        .collection('posts')
        .where('userId', isEqualTo: userId)
        .orderBy('timestamp', descending: true)
        .get();
    return posts.docs.map((e) => PostModel.fromSnapshot(e)).toList();
  }
}
