import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_fetch_json_data/model/user.dart';

class FromData extends StatelessWidget {
  FromData({Key? key}) : super(key: key);

  List<User> users = getUsers();
  
  static List<User> getUsers() {
    const data = [
      {
        "id": 1389,
        "post_id": 1366,
        "name": "Deenabandhu Kaniyar",
        "email": "kaniyar_deenabandhu@kuhlman-zulauf.biz",
        "body": "Et labore ex. Autem eaque dolores."
      },
      {
        "id": 1388,
        "post_id": 1364,
        "name": "Goswamee Nair",
        "email": "nair_goswamee@hand.com",
        "body": "Ut officiis quisquam."
      },
      {
        "id": 1387,
        "post_id": 1362,
        "name": "Suman Jain",
        "email": "suman_jain@kerluke.org",
        "body": "Labore sunt sed. Eligendi corrupti iusto."
      },
    ];

    return data.map<User>(User.fromJson).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('api call json'),
        centerTitle: true,
      ),
      body: Center(
        child: buildUsers(users),        
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
