import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_starter/localizations.dart';
import 'package:flutter_starter/services/models/models.dart';
import 'package:flutter_starter/ui/components/components.dart';

class HomeUI extends StatefulWidget {
  @override
  _HomeUIState createState() => _HomeUIState();
}

class _HomeUIState extends State<HomeUI> {
  Widget build(BuildContext context) {
    final labels = AppLocalizations.of(context);
    final UserModel user = Provider.of<UserModel>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(labels.home.title),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.of(context).pushNamed('/settings');
              }),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 120),
            Avatar(user),
            FormVerticalSpace(),
            Text('uid: ' + user?.uid, style: TextStyle(fontSize: 16)),
            FormVerticalSpace(),
            Text('Name: ' + user?.name, style: TextStyle(fontSize: 16)),
            FormVerticalSpace(),
            Text('Email: ' + user?.email, style: TextStyle(fontSize: 16)),
            FormVerticalSpace(),
            Text('Admin User: ' /*+ isAdmin(user)*/,
                style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
