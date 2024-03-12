import 'package:flutter/material.dart';
import 'package:flutter3/apis/apis.dart';
import 'package:flutter3/apis/helper.dart';
import 'package:flutter3/models/category.dart';
import 'package:flutter3/pages/sub-category.dart';
import 'package:flutter3/shared/shared.dart';
import 'package:flutter3/widgets/category.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Category> categories = [];
  Apis apis = Apis();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       
      ),
      body: Center(
        child: categories.isNotEmpty
            ? ListView(
                children: <Widget>[
                  for (int i = 0; i < categories.length; i++)
                    category(category: categories[i])
                ],
              )
            : const Text("Please Press Add Button"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          apis.getCategories().then((value) {
            categories = [];
            setState(() {
              for (var i = 0; i < value['data']['data'].length; i++) {
                categories.add(
                  Category(
                    id: value['data']['data'][i]['id'].toString(),
                    image: value['data']['data'][i]['image'].toString(),
                    name: value['data']['data'][i]['name'].toString(),
                    subCategories: value['data']['data'][i]['sub_category'],
                  
                  ),
                );
              }
            });
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
