import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:news_app/features/domain/usecases/auth_usecases/sign_in_with_email_usecase.dart';
import 'package:news_app/features/domain/usecases/auth_usecases/sign_up_with_email_usecase.dart';


abstract class AuthRemoteDataSource {
  Future<User?> getCurrentUser();

  Future<UserCredential> signUp(SignUpParams params);

  Future<UserCredential> signIn(AuthParams params);

  Future<void> signOut();
}

class AuthRemoteDatasourceImpl implements AuthRemoteDataSource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firestore;

  AuthRemoteDatasourceImpl({
    required this.firestore,
    required this.firebaseAuth,
  });

  @override
  Future<User?> getCurrentUser() async {
    return firebaseAuth.currentUser;
  }

  @override
  Future<UserCredential> signIn(AuthParams params) async {
    UserCredential userCredential =
        await firebaseAuth.signInWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );

    return userCredential;
  }

  @override
  Future<UserCredential> signUp(SignUpParams params) async {
    UserCredential userCredential =
        await firebaseAuth.createUserWithEmailAndPassword(
      email: params.email,
      password: params.password,
    );

    firestore
        .collection('users')
        .doc(userCredential.user?.uid)
        .set(
        {
          'uid' : userCredential.user?.uid,
          'name': params.name,
          'surname': params.surname,
          'email': params.email,
          'password': params.password,
        }
      //  params.toMap()
    );

    return userCredential;
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }
}
