import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:blood_donation_nss/models/admin_model.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AdminModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            elevation: .0,
            title: Text('Blood Donation'),
            leading: Icon(Icons.whatshot),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.exit_to_app),
                onPressed: () async {
                  await model.dataBase.signOut();
                  Navigator.of(context).pushReplacementNamed('/login_screen');
                },
              )
            ],
          ),
          body: Center(
            child: RaisedButton(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Add Donor',
                  textScaleFactor: 2.0,
                  style: TextStyle(color: Colors.white),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              onPressed: () {                
                Navigator.of(context).pushNamed('/category');
                model.getDonors();
              },
            ),
          ),
        );
      },
    );
  }
}
