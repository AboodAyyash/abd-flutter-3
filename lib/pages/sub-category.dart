import 'package:flutter/material.dart';
import 'package:flutter3/models/category.dart';
import 'package:flutter3/shared/shared.dart';
import 'package:flutter3/widgets/category.dart';

class SubCatPage extends StatefulWidget {
  final List subCategories;
  final String title;
  const SubCatPage(
      {super.key, required this.subCategories, required this.title});

  @override
  State<SubCatPage> createState() => _SubCatPageState();
}

class _SubCatPageState extends State<SubCatPage> {
  List<Category> categories = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for (var i = 0; i < widget.subCategories.length; i++) {
      categories.add(Category(
          id: widget.subCategories[i]['id'].toString(),
          image: widget.subCategories[i]['image'].toString(),
          name: widget.subCategories[i]['name'].toString(),
          subCategories: []));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView(
        children: <Widget>[
          for (int i = 0; i < categories.length; i++)
            category(category: categories[i])
        ],
      ),
    );
  }
}
