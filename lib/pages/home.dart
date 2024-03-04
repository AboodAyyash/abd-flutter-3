import 'package:flutter/material.dart';
import 'package:flutter3/apis/apis.dart';
import 'package:flutter3/apis/helper.dart';
import 'package:flutter3/pages/sub-category.dart';
import 'package:flutter3/shared/shared.dart';
import 'package:flutter3/widgets/category.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List categories = [];
  Apis apis = Apis();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
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
            print(value['data']['data'][0]);
            setState(() {
              categories = value['data']['data'];
            });
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

}
