import 'package:flutter/material.dart';
import 'package:flutter3/apis/apis.dart';
import 'package:flutter3/models/product.dart';
import 'package:flutter3/shared/shared.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Apis apis = Apis();
  List<Product> products = [];
  double total = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCart();
  }

  void getCart() {
    apis.getCart().then((value) {
      print(value);

      for (var i = 0; i < value['data']['data'].length; i++) {
        setState(() {
          products.add(Product(
            id: value['data']['data'][i]['id'].toString(),
            image: value['data']['data'][i]['image'],
            name: value['data']['data'][i]['name'],
            quantity: value['data']['data'][i]['quantity'].toString(),
            price: value['data']['data'][i]['price'] + 0.0,
          ));
        });
      }
      calculateCartTotal();
    });
  }

  calculateCartTotal() {
    setState(() {
      for (var i = 0; i < products.length; i++) {
        total += double.parse(products[i].quantity) * double.parse(products[i].price.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
          actions: [Text(total.toString())],
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
                    Image.network(baseURL + products[i].image.toString()),
                    Text(products[i].name.toString()),
                    Text("${products[i].price} JOD"),
                    MaterialButton(
                      onPressed: () {
                        apis
                            .postAddToCart(
                                productId: products[i].id, quantity: '1')
                            .then((value) {
                          print(value);
                        });
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
}
