import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              DrawerHeader(
                child: Icon(
                  Icons.favorite,
                  color: Theme.of(context).colorScheme.inversePrimary,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('H O M E'),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('P R O F I L E'),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.pushNamed(context, '/profile_page');
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text('U S E R S'),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.pushNamed(context, '/users_page');
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              leading: const Icon(Icons.home),
              title: const Text('L O G O U T '),
              onTap: () {
                Navigator.pop(context);
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
