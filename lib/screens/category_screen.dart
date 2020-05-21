import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:blood_donation_nss/models/admin_model.dart';

class CategoryScreen extends StatefulWidget {
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AdminModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Select Category'),
            elevation: .0,
          ),
          body: ListView.separated(
            itemCount: model.categories.length,
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: BouncingScrollPhysics(),
            separatorBuilder: (_, p) {
              return Divider(
                height: 2.0,
              );
            },
            itemBuilder: (context, pos) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: ListTile(
                  onTap: () {
                    model.donorCategory = model.categories[pos];
                    Navigator.of(context).pushNamed('/add_donor');
                  },
                  title: Text(
                    model.categories[pos],
                    style: TextStyle(
                      fontSize: Theme.of(context).textTheme.title.fontSize,
                      color: Colors.black87,
                    ),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
