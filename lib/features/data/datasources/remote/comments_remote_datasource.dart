import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/core/utils/time_format.dart';
import 'package:news_app/core/utils/uuid_provider.dart';
import 'package:news_app/features/data/models/comment_model.dart';
import 'package:news_app/features/domain/usecases/comments/add_comment_usecase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:news_app/locator.dart';

abstract class CommentsRemoteDatasource {
  Future<CommentModel?> addComment(CommentParams params);

  Stream<List<CommentModel>> getComments(String articleId);

  Future<int> getCommentsCount(String articleId);

  Future<Map<String, int>> getCommentsCountForArticles(List<String> articleIds);
}

class CommentsRemoteDataSourceImpl extends CommentsRemoteDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  CommentsRemoteDataSourceImpl(
      {required this.firebaseAuth, required this.firestore});

  @override
  Future<CommentModel?> addComment(CommentParams params) async {
    try {
      final String? currentUserId = firebaseAuth.currentUser?.uid;
      final String? currentUserEmail = firebaseAuth.currentUser?.email;

      if (currentUserId == null || currentUserEmail == null) {
        return null;
      }
      final docId = locator<UuidProvider>().generate();

      final Timestamp timestamp = Timestamp.now();

      final time = timeStampToString(timestamp);

      final commentData = CommentModel(
        docId: docId,
        articleId: params.articleId,
        comment: params.comment,
        author: currentUserEmail,
        time: time,
      );

      await firestore
          .collection("articles")
          .doc(params.articleId)
          .collection('comments')
          .doc(docId) //yokdy
          .set(commentData.toMap()); //add

      return commentData;
    } catch (e) {
      return null;
    }
  }

  @override
  Stream<List<CommentModel>> getComments(String articleId) {
    final commentsStream = _getCommentsStream(articleId).map((comment) =>
        comment.docs
            .map((doc) =>
                CommentModel.fromMap(doc.data() as Map<String, dynamic>))
            .toList());
    return commentsStream;
  }

  Stream<QuerySnapshot> _getCommentsStream(String articleId) {
    return firestore
        .collection("articles")
        .doc(articleId)
        .collection('comments')
        .snapshots();
  }

  @override
  Future<int> getCommentsCount(String articleId) async {
    final query =
        firestore.collection('articles').doc(articleId).collection('comments');

    final allComments = await query.get();
    return allComments.docs.length;
  }

  @override
  Future<Map<String, int>> getCommentsCountForArticles(
      List<String> articleIds) async {
    Map<String, int> results = {};

    for (final id in articleIds) {
      final query =
          firestore.collection('articles').doc(id).collection('comments');

      final commentSnapshot = await query.get();
      results[id] = commentSnapshot.docs.length;
    }

    return results;
  }
}
