import 'dart:io';
import 'dart:convert';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:blood_donation_nss/models/donor.dart';
import 'package:blood_donation_nss/models/database.dart';

class AdminModel extends Model {
  FirebaseUser admin;
  final databaseReference = FirebaseDatabase.instance.reference();
  DataBase dataBase;
  Donor donor;
  bool isLoading = false;
  List<Donor> donors = [];

  List<String> categories = [
    'General (GN)',
    'STAFF',
    'FACULTY',
    'FE',
    'SE MECH A',
    'SE MECH B',
    'SE MTRX',
    'SE CIVIL',
    'SE COMP A',
    'SE COMP B',
    'SE COMP C',
    'SE IT',
    'SE EXTC A',
    'SE EXTC B',
    'SE ELEX',
    'TE MECH',
    'TE MTRX',
    'TE COMP A',
    'TE COMP B',
    'TE COMP C',
    'TE IT',
    'TE EXTC A',
    'TE EXTC B',
    'TE ELEX',
    'BE',
  ];
  String donorCategory = '';

  Future<int> submitDonor({Map<String, dynamic> donorMap}) async {
    isLoading = true;
    notifyListeners();
    try {
      DataSnapshot snapshot = await databaseReference
          .child('registrations')
          .child(donorCategory)
          .orderByChild('timestamp')
          .limitToLast(1)
          .once();
      String lastKey;
      try {
        Map<dynamic, dynamic> lastReg = snapshot.value;
        if (lastReg == null) {
          donorMap['id'] = 1;
        } else {
          lastKey = lastReg.keys.first;
          donorMap['id'] = int.parse(lastKey) + 1;
        }
        databaseReference
            .child('registrations')
            .child(donorCategory)
            .child(donorMap['id'].toString())
            .set(donorMap);
        isLoading = false;
        notifyListeners();
        return donorMap['id'];
      } catch (err) {
        print(err);
        var lastReg = snapshot.value[1];
        print(lastReg);
        lastKey = lastReg['id'].toString();
        donorMap['id'] = int.parse(lastKey) + 1;
      }
      databaseReference
          .child('registrations')
          .child(donorCategory)
          .child(donorMap['id'].toString())
          .set(donorMap);
      isLoading = false;
      notifyListeners();
      return donorMap['id'];
    } catch (err) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<Null> getDonors() async {
    for (final cat in categories) {
      DataSnapshot snapshot =
          await databaseReference.child('registrations').child(cat).once();
      //print(snapshot.value);

      var logFile = File(cat.toString() + '.json');
      var sink = logFile.openWrite(mode: FileMode.append);
      sink.write(snapshot.value[1]);
      await sink.flush();
      await sink.close();
    }
  }

  Future<bool> login() async {
    isLoading = true;
    notifyListeners();
    // DataBase _dataBase = DataBase();
    this.dataBase = DataBase();
    try {
      FirebaseUser user = await dataBase.signIn();
      this.admin = user;
      String email = user.providerData[1].email.trim().toLowerCase();
      if (email == "nssternabd@gmail.com") {
        isLoading = false;
        notifyListeners();
        return true;
      }
    } catch (err) {}
    isLoading = false;
    notifyListeners();
    return false;
  }
