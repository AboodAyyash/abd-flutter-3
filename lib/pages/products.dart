import 'package:flutter/material.dart';
import 'package:flutter3/apis/apis.dart';
import 'package:flutter3/shared/shared.dart';

class ProductsPage extends StatefulWidget {
  final String categoryId;
  const ProductsPage({super.key, required this.categoryId});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  String categoryId = "";
  Apis apis = Apis();
  List products = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      categoryId = widget.categoryId;
    });
    getProducts();
  }

  getProducts() {
    apis.getCategoryProducts(categoryId: categoryId).then((value) {
      print(value);
      setState(() {
        products = value['data']['data'];
      });
      print(products.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Products List")),
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int i) {
            return InkWell(
              onTap: () {
                print(products[i]);
              },
              child: Card(
                child: Column(
                  children: [
                    Image.network(baseURL + products[i]['image']),
                    Text(products[i]['name'].toString()),
                    Text("${products[i]['price']} JOD"),
                  ],
                ),
              ),
            );
          },
        ));
  }

/*   */
}
