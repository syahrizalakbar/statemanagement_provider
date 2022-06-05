import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:statemanagement_provider/constant.dart';
import 'package:statemanagement_provider/ui/home_page.dart';

class AuthProvider extends ChangeNotifier {

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool loadingLogin = false;

  Future<void> login(BuildContext context) async {
    if (email.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text("Email atau password belum diisi")));
      return;
    }

    loadingLogin = true;
    notifyListeners();

    http.Response res = await http.post(
        Uri.parse("${baseUrl}login"),
        body: {
          "email": email.text,
          "password": password.text
        },
    );

    loadingLogin = false;
    notifyListeners();

    if (res.statusCode == 200) {
      Map data = jsonDecode(res.body);
      if (data['token'] != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) {
            return HomePage();
          }),
        );
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Email atau password salah")));
      }
    }
  }

}