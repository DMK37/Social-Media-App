import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_media/data/models/comment_model.dart';
import 'package:social_media/data/models/post_model.dart';
import 'package:social_media/data/models/user_model.dart';

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
        .get();
    return posts.docs.map((e) => PostModel.fromSnapshot(e)).toList()..sort((a,b) => b.timestamp.compareTo(a.timestamp));
  }

  Future<List<CommentModel>> addComment(String postId, String comment, UserModel user) async {
    final post = await getPost(postId);
    if (post == null) {
      throw Exception("Post not found");
    }
    final newComment = CommentModel(
      comment: comment,
      userId: user.userId!,
      timestamp: DateTime.now(),
    );
    post.comments.add(newComment);
    await _db.collection('posts').doc(postId).update(post.toJson());
    return post.comments;
  }
}
