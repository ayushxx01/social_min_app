import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmin/common/widgets/drawer/drawer.dart';
import 'package:socialmin/common/widgets/listtile/my_list_tile.dart';
import 'package:socialmin/common/widgets/postbutton/my_post_button.dart';
import 'package:socialmin/common/widgets/textfield/my_textfield.dart';
import 'package:socialmin/core/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FirestoreDatabase database = FirestoreDatabase();

  final TextEditingController newPostController = TextEditingController();

  void postMessage() {
    // Post the new post ; only when text is there
    if (newPostController.text.isNotEmpty) {
      String message = newPostController.text;
      database.addPost(message);
      // Post the message
    }
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text(
          'P I N G',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          // TextField
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Row(
              children: [
                Expanded(
                  child: MyTextfield(
                    hintText: 'Say Something',
                    controller: newPostController,
                    obscureText: false,
                  ),
                ),
                MyPostButton(onTap: postMessage),
              ],
            ),
          ),
          // Posts
          Expanded(
            child: StreamBuilder(
              stream: database.getPostsStream(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final posts = snapshot.data!.docs;

                if (snapshot.data == null || posts.isEmpty) {
                  return const Center(
                    child: Text("No posts found"),
                  );
                }

                return Expanded(
                  child: ListView.builder(
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      // Get each post
                      final post = posts[index];

                      // Get data
                      String message = post['PostMessage'];
                      String username = post['UserEmail'];
                      Timestamp timestamp = post['TimeStamp'];

                      // Return the post

                      return MyListTile(title: message, subtitle: username);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
