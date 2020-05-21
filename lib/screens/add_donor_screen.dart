import 'package:blood_donation_nss/models/donor.dart';
import 'package:blood_donation_nss/screens/view_number.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:blood_donation_nss/models/admin_model.dart';

class AddDonorScreen extends StatefulWidget {
  @override
  _AddDonorScreenState createState() => _AddDonorScreenState();
}

class _AddDonorScreenState extends State<AddDonorScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController contactController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController illnessController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<DropdownMenuItem> dropDownMenuItem = [];
  List<String> bloodGroups = [
    "-",
    "A+",
    "O+",
    "B+",
    "AB+",
    "A-",
    "O-",
    "B-",
    "AB-"
  ];
  String donatedBlood = 'N', bloodGroup = "-", gender = 'M';
  Donor donor;
  Map<String, dynamic> _donorMap = {
    'category': "",
    'name': "",
    'contact': "",
    'age': "",
    'location': "",
    'illness': "",
    'donated': "",
    'group': "",
    "timestamp": DateTime.now().millisecondsSinceEpoch
  };

  Widget _buildDropDownItem({String group}) {
    return DropdownMenuItem(
      child: Text(group),
      value: group.toUpperCase(),
    );
  }

  @override
  void initState() {
    super.initState();
    dropDownMenuItem = List.generate(bloodGroups.length, (i) {
      return _buildDropDownItem(group: bloodGroups[i]);
    });
  }

  Widget _buildSubmitButton(AdminModel model) {
    if (model.isLoading) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(child: CircularProgressIndicator()),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: FlatButton(
          color: Theme.of(context).primaryColor,
          onPressed: () async {
            //print(_formKey.currentState.validate());
            if (_formKey.currentState.validate()) {
              _formKey.currentState.save();
              model.submitDonor(donorMap: _donorMap).then((value) {
                Navigator.of(context)
                    .pushReplacement(MaterialPageRoute(builder: (context) {
                  return ViewRegPage(value);
                }));
              });
            }
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            child: Text(
              'Submit',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.button.fontSize * 1.5,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AdminModel>(
      builder: (context, child, model) {
        _donorMap['category'] = model.donorCategory;
        return Scaffold(
          appBar: AppBar(
            title: model.donorCategory != ''
                ? Text(model.donorCategory)
                : Text('Blood Donation'),
            elevation: .0,
          ),
          body: Form(
            key: _formKey,
            child: ListView(
              scrollDirection: Axis.vertical,
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.display1.fontSize,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (String value) {
                      setState(() {
                        _donorMap['name'] = value;
                      });
                    },
                    textCapitalization: TextCapitalization.words,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Field Required";
                      }
                    },
                    controller: nameController,
                    decoration: InputDecoration(labelText: "Name"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (String value) {
                      setState(() {
                        _donorMap['contact'] = value;
                      });
                    },
                    keyboardType: TextInputType.numberWithOptions(),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Field Required";
                      }
                    },
                    controller: contactController,
                    decoration: InputDecoration(labelText: "Contact"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (String value) {
                      setState(() {
                        _donorMap['age'] = value;
                      });
                    },
                    keyboardType: TextInputType.numberWithOptions(),
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Field Required";
                      }
                    },
                    controller: ageController,
                    decoration: InputDecoration(labelText: "Age"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (String value) {
                      setState(() {
                        _donorMap['location'] = value;
                      });
                    },
                    textCapitalization: TextCapitalization.words,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Field Required";
                      }
                    },
                    controller: locationController,
                    decoration: InputDecoration(labelText: "Location"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    onSaved: (String value) {
                      setState(() {
                        _donorMap['illness'] = value;
                      });
                    },
                    textCapitalization: TextCapitalization.words,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Field Required";
                      }
                    },
                    controller: illnessController,
                    decoration: InputDecoration(labelText: "Chronic Illnesses"),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: DropdownButtonFormField(
                    hint: Text('Donated Blood Previously ?'),
                    decoration: InputDecoration(
                        hasFloatingPlaceholder: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        labelText: 'Donated Blood Previously ?'),
                    value: donatedBlood,
                    onChanged: (value) {
                      setState(() {
                        donatedBlood = value;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        donatedBlood = value;
                        _donorMap['donated'] = donatedBlood;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text('Yes'),
                        value: 'Y',
                      ),
                      DropdownMenuItem(
                        child: Text('No'),
                        value: 'N',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        hasFloatingPlaceholder: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        labelText: 'Gender'),
                    value: gender,
                    onChanged: (value) {
                      setState(() {
                        gender = value;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        gender = value;
                        _donorMap['gender'] = gender;
                      });
                    },
                    items: [
                      DropdownMenuItem(
                        child: Text('Male'),
                        value: 'M',
                      ),
                      DropdownMenuItem(
                        child: Text('Female'),
                        value: 'F',
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 8.0),
                  child: DropdownButtonFormField(
                    decoration: InputDecoration(
                        hasFloatingPlaceholder: true,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                        labelText: 'Blood Group'),
                    value: bloodGroup,
                    onChanged: (value) {
                      setState(() {
                        bloodGroup = value;
                      });
                    },
                    onSaved: (value) {
                      setState(() {
                        bloodGroup = value;
                        _donorMap['group'] = value;
                      });
                    },
                    items: dropDownMenuItem,
                  ),
                ),
                _buildSubmitButton(model)
              ],
            ),
          ),
        );
      },
    );
  }
}
