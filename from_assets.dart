import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_fetch_json_data/model/user.dart';

class FromAssets extends StatefulWidget {
  const FromAssets({Key? key}) : super(key: key);

  @override
  State<FromAssets> createState() => _FromAssetsState();
}

class _FromAssetsState extends State<FromAssets> {
  
  late Future<List<User>> usersFuture;

  @override
  void initState() {
    super.initState();
    
    usersFuture = getUsers(context);
  }

  static Future<List<User>> getUsers(BuildContext context) async {
    final assetBundle = DefaultAssetBundle.of(context);
    final data = await assetBundle.loadString('assets/users.json');

    final body = json.decode(data);
    return body.map<User>(User.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('api call json'),
        centerTitle: true,
      ),
      body: Center(
        child: FutureBuilder<List<User>>(
          future: usersFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('😞 ${snapshot.error}');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              return buildUsers(users);
            } else {
              return const Text('No user data.');
            }
          },
        ),
      ),
    );
  }

  Widget buildUsers(List<User> users) => ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return Card(
            child: ListTile(
              leading: const CircleAvatar(
                radius: 28,
                backgroundImage: AssetImage(
                  'assets/user.jpg',
                ),
              ),
              title: Text(user.name),
              subtitle: Text(user.email),
            ),
          );
        },
      );
}
