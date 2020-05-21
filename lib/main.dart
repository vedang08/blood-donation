import 'package:blood_donation_nss/screens/category_screen.dart';
import 'package:blood_donation_nss/screens/add_donor_screen.dart';
import 'package:blood_donation_nss/screens/home_screen.dart';
//import 'package:blood_donation_nss/screens/view_donor_category_screen.dart';
//import 'package:blood_donation_nss/screens/view_donor_list.dart';
import 'package:flutter/material.dart';
import 'package:blood_donation_nss/models/admin_model.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:blood_donation_nss/screens/login_screen.dart';

void main() async {
  AdminModel model = AdminModel();
  runApp(
    BloodDonation(
      model: model,
    ),
  );
}

class BloodDonation extends StatelessWidget {
  final AdminModel model;

  const BloodDonation({Key key, this.model}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScopedModel<AdminModel>(
      model: this.model,
      child: MaterialApp(        
        title: 'Blood Donation',
        debugShowCheckedModeBanner: false,        
        theme: ThemeData(          
          fontFamily: 'Montserrat',
          primaryColor: const Color(0xFFFF3B5F),
          buttonTheme: ButtonThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.0),            
            ),
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),  
            buttonColor: const Color(0xFFFF3B5F),    
            splashColor: Colors.white54,                              
          ),
        ),
        home: LoginScreen(),
        routes: {
          '/login_screen': (_) => LoginScreen(),
          '/add_donor': (_) => AddDonorScreen(),
          '/category': (_) => CategoryScreen(),
          '/home': (_) => HomeScreen(),
        },
      ),
    );
  }
}
