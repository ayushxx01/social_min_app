//Stores user published posts in the firebase firestore 'posts
//post contents: message,mail and tiemstamp

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  //current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  //collection of posts
  final CollectionReference posts =
      FirebaseFirestore.instance.collection('posts');

  //post a message
  Future<void> addPost(String message) {
    //post message
    return posts.add({
      'PostMessage': message,
      'UserEmail': user!.email,
      'TimeStamp': Timestamp.now(),
    });
  }

  // read posts
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('posts')
        .orderBy('TimeStamp', descending: true)
        .snapshots();

    return postsStream;
  }
}
