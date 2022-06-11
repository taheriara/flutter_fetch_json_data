import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_fetch_json_data/model/user.dart';

class FromSerer extends StatelessWidget {
  FromSerer({Key? key}) : super(key: key);

  Future<List<User>> usersFuture = getUsersFuture();
  
  static Future<List<User>> getUsersFuture() async {
    const url = "https://gorest.co.in/public/v2/comments";
    final response = await http.get(Uri.parse(url));
    
    final body = json.decode(response.body);
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
        //child: buildUsers(users),  // for getUsers()
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
                backgroundImage: AssetImage(  // or NetworkImage(...)
                  'assets/images/user.jpg',
                ),
              ),
              title: Text(user.name),
              subtitle: Text(user.email),
            ),
          );
        },
      );
}
