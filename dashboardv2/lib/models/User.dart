// To parse this JSON data, do
//
//     final users = usersFromJson(jsonString);

import 'dart:convert';
import 'dart:developer';

import 'package:admin/main.dart';
import 'package:admin/provider/AnnouncesProvider.dart';
import 'package:admin/provider/AuthoritiesProvider.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users extends DataTableSource {
  Users({
    required this.user,
  });

  List<User> user;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        user: List<User>.from(json["collection"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "user": List<dynamic>.from(user.map((x) => x.toJson())),
      };

  @override
  DataRow? getRow(int index) {
    // TODO: implement getRow
    //log(pro!.authorities!.data!.authoritie!.length!.toString());

    try {
      if (index < rowCount) {
        return DataRow.byIndex(index: index, cells: [
          DataCell(
            //ImageIcon(NetworkImage(data.authoritie[index].logo)),
            Text(user[index].lastName!),
          ),
          DataCell(
            //ImageIcon(NetworkImage(data.authoritie[index].logo)),s
            Text(user[index].firstName!),
          ),
          DataCell(
              //ImageIcon(NetworkImage(data.authoritie[index].logo)),
              Builder(builder: (context) {
            return Consumer<AuthoritiesProvider>(
                builder: (_, AuthoritiesProvider provider, __) {
              return Text(provider.authorities.data
                  .firstWhere((element) =>
                      element.id == int.parse(user[index].wilayaId))
                  .name);
            });
          })
//Text(user[index].email!),
              ),
          DataCell(
            //ImageIcon(NetworkImage(data.authoritie[index].logo)),
            Text(user[index].email!),
          ),
          DataCell(
            //ImageIcon(NetworkImage(data.authoritie[index].logo)),
            Text(user[index].userName),
          ),
          DataCell(Row(
            children: [
              TextButton(
                child: Text("détailles"),
                onPressed: () {},
              ),
            ],
          )),
        ]);
      } else
        return null;
    } catch (e) {}
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => user.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}

class User {
  User({
    this.email,
    this.firstName,
    required this.id,
    this.lastName,
    required this.userName,
    required this.wilayaId,
  });

  String? email;
  String? firstName;
  String id;
  String? lastName;
  String userName;
  String wilayaId;

  factory User.fromJson(Map<String, dynamic> json) => User(
        email: (json.containsKey("email")) ? json["email"] : "",
        firstName: (json.containsKey("firstName")) ? json["firstName"] : "",
        id: json["id"],
        lastName: (json.containsKey("lastName")) ? json["lastName"] : "",
        userName: json["userName"],
        wilayaId: (json.containsKey("wilayaId"))
            ? json["wilayaId"]
            : (json.containsKey("authoritieId"))
                ? json["authoritieId"]
                : "",
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "firstName": firstName,
        "id": id,
        "lastName": lastName,
        "userName": userName,
        "wilayaId": wilayaId,
      };
}
