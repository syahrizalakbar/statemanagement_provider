import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanagement_provider/provider/home_page_provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // HomePageProvider homePageProvider = HomePageProvider();

  /// UI / View / UserInterface yang ditampilkan ke User
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)
          => HomePageProvider(context)),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text("List User"),
        ),
        body: Consumer<HomePageProvider>(
          builder: (BuildContext context, value, Widget? child) {
            return value.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: value.users.length,
                    itemBuilder: (context, index) {
                      var user = value.users[index];
                      return Card(
                        child: ListTile(
                          title: Text(user['email'] ?? '-'),
                          subtitle: Text(user['first_name'] ?? '-'),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
