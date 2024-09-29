import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmin/common/widgets/backbutton/my_back_button.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});
  //current logged in user
  final User? currentUser = FirebaseAuth.instance.currentUser;

  //futre to fetch user details
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    //fetch user details
    return await FirebaseFirestore.instance
        .collection('Users')
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserDetails(),
          builder: (context, snapshot) {
            //loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              Map<String, dynamic>? user = snapshot.data!.data();

              return Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 50, left: 25),
                      child: Row(
                        children: [
                          MyBackButton(),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    //icon
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      padding: const EdgeInsets.all(25),
                      child: const Icon(Icons.person, size: 64),
                    ),
                    //username
                    Text(
                      user!['email'],
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),

                    //email
                    Text(user['username'],
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              );
            } else {
              return const Center(
                child: Text("No data found"),
              );
            }
          }),
    );
  }
}
