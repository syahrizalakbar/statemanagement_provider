

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:statemanagement_provider/constant.dart';

class HomePageProvider extends ChangeNotifier {

  List users = [];
  bool loading = false;

  HomePageProvider(context) {
    getListUser(context);
  }
  
  Future<void> getListUser(context) async {
    loading = true;
    notifyListeners();
    
    http.Response res = await http
        .get(Uri.parse("${baseUrl}users?page=2"));

    loading = false;
    notifyListeners();

    if (res.statusCode == 200) {
      var dataUser = jsonDecode(res.body);
      users = dataUser['data'];
      notifyListeners();
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error")));
    }

  }

  // List<String> users = [];
  //
  // /// Method-method Logic
  // Future<void> getListUser() async {
  //   /// dari Api
  //   /// Proses panjang buat get data dari server
  //   await Future.delayed(Duration(seconds: 5));
  //   /// udah dapet dari server
  //
  //   // setState(() {
  //   //   users = ['User A', 'User B', 'User C'];
  //   // });
  //   users = ['User A', 'User B', 'User C'];
  //   notifyListeners();
  // }
}