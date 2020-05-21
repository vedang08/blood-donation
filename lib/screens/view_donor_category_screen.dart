import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:blood_donation_nss/models/admin_model.dart';

class ViewDonorCategoryScreen extends StatefulWidget {
  @override
  _ViewDonorCategoryScreenState createState() => _ViewDonorCategoryScreenState();
}

class _ViewDonorCategoryScreenState extends State<ViewDonorCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<AdminModel>(
      builder: (context, child, model) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Category'),
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
                    // await model.getDonorsByCategory();
                    Navigator.of(context).pushNamed('/view_donor_list');
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
