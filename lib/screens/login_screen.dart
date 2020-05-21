import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:blood_donation_nss/models/admin_model.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AdminModel>(
      rebuildOnChange: false,
      builder: (context, child, model) {
        return Scaffold(
          body: Container(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'icons/038-transfusion.png',
                    height: MediaQuery.of(context).size.height * 0.35,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    child: Text(
                      "\"There is no great joy than saving a soul.\"",
                      style: TextStyle(
                        fontSize: Theme.of(context).textTheme.title.fontSize,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  FlatButton(
                    color: Theme.of(context).primaryColor,
                    onPressed: () async {
                      bool loggedIn = await model.login();
                      if (loggedIn) {
                        Navigator.of(context).pushReplacementNamed('/home');
                      } else {
                        model.dataBase.signOut();
                        showDialog(
                            context: context,
                            barrierDismissible: true,
                            builder: (context) {
                              return AlertDialog(
                                title: Text("Unauthorized Access"),
                                content: Text("You aren't authorized!"),
                                actions: <Widget>[
                                  FlatButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text("Close"),
                                  )
                                ],
                              );
                            });
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                      ),
                      child: Text(
                        'Google Login',
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.button.fontSize * 1.5,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
