import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:perfect/models/post_model.dart';

class PostService {
  final _db = FirebaseFirestore.instance;

  // CREATE POST
  Future<void> createPost(
    String title,
    String content,
    String authorId,
    String author,
  ) async {
    await _db.collection('posts').add({
      'title': title,
      'content': content,
      'authorId': authorId,
      'author': author,
      'createdAt': DateTime.now().toIso8601String(),
      'likes': 0,
    });
  }

  // READ POSTS (REAL TIME)
  Stream<List<Post>> streamPosts() {
    return _db
        .collection('posts')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return Post.fromJson({...doc.data(), 'id': doc.id});
          }).toList();
        });
  }

  // DELETE POST
  Future<void> deletePost(String postId) async {
    await _db.collection('posts').doc(postId).delete();
  }

  // LIKE POST
  Future<void> likePost(String postId) async {
    await _db.collection('posts').doc(postId).update({
      'likes': FieldValue.increment(1),
    });
  }
}
