import 'package:flutter/material.dart';
import 'package:flutter3/apis/apis.dart';
import 'package:flutter3/firebase/service.dart';
import 'package:flutter3/models/product.dart';
import 'package:flutter3/pages/cart.dart';
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
  List<Product> products = [];
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
    searchFirebaseDocument(
            collectionName: 'products', query: categoryId, where: "categoryId")
        .then((value) {
      print(value);
      setState(() {
        for (var i = 0; i < value.length; i++) {
          products.add(Product(
            id: value[i]['data']['id'].toString(),
            image: value[i]['data']['image'],
            name: value[i]['data']['name'],
            price: double.parse(value[i]['data']['price']) + 0.0,
          ));
        }
      });
    });
    /* apis.getCategoryProducts(categoryId: categoryId).then((value) {
      print(value);
      setState(() {
        for (var i = 0; i < value['data']['data'].length; i++) {
          products.add(Product(
            id: value['data']['data'][i]['id'].toString(),
            image: value['data']['data'][i]['image'],
            name: value['data']['data'][i]['name'],
            price: value['data']['data'][i]['price'] + 0.0,
          ));
        }
      });
      print(products.length);
    }); */
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Products List"),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const CartPage(),
                    ),
                  );
                },
                icon: Icon(Icons.shopping_cart_sharp))
          ],
        ),
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
                    Image.network(products[i].image.toString()),
                    Text(products[i].name.toString()),
                    Text("${products[i].price} JOD"),
                    MaterialButton(
                      onPressed: () {
                        Map<String, dynamic> cartData = {
                          'userId': userData['data']['id'],
                          'productId': products[i].id,
                          'qty': '1'
                        };
                        setFirebaseDocumentData(
                            collectionName: 'cart', data: cartData);
                        /*    apis
                            .postAddToCart(
                                productId: products[i].id, quantity: '1')
                            .then((value) {
                          print(value);
                        }); */
                      },
                      child: Text("Add To Cart"),
                    )
                  ],
                ),
              ),
            );
          },
        ));
  }

/*   */
}
