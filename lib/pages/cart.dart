import 'package:flutter/material.dart';
import 'package:flutter3/apis/apis.dart';
import 'package:flutter3/firebase/service.dart';
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

  String cartId = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCart();
  }

  void getCart() {
    searchFirebaseDocument(
            collectionName: 'cart',
            query: userData['data']['id'],
            where: "userId")
        .then((value) {
      print(value);

      if (value.length > 0) {
        cartId = value[0]['id'];
        List productsFire = value[0]['data']['products'];
        for (var i = 0; i < productsFire.length; i++) {
          searchFirebaseDocument(
                  collectionName: 'products',
                  query: productsFire[i]['id'],
                  where: 'id')
              .then((product) {
            print(product);
            setState(() {
              products.add(Product(
                id: product[i]['data']['id'].toString(),
                image: product[i]['data']['image'],
                name: product[i]['data']['name'],
                quantity: productsFire[i]['qty'].toString(),
                price:
                    double.parse(product[i]['data']['price'].toString()) + 0.0,
              ));
            });
            calculateCartTotal();
          });
        }
      }
    });
    /*  apis.getCart().then((value) {
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
    }); */
  }

  calculateCartTotal() {
    setState(() {
      print(products);
      for (var i = 0; i < products.length; i++) {
        total += double.parse(products[i].quantity) *
            double.parse(products[i].price.toString());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),
          actions: [
            Text(total.toString()),
            IconButton(
              onPressed: () {
                List orderProducts = [];
                for (var i = 0; i < products.length; i++) {
                  orderProducts.add({
                    "name": products[i].name,
                    "id": products[i].id,
                    "image": products[i].image,
                    "price": products[i].price,
                    "qty": products[i].quantity,
                  });
                }
                Map<String, dynamic> orderData = {
                  'total': total.toString(),
                  'userId': userData['id'],
                  'id': DateTime.now().millisecondsSinceEpoch.toString(),
                  'products': orderProducts,
                };
                setFirebaseDocumentData(
                    collectionName: 'orders', data: orderData);
                deleteFirebaseDocumentData(collectionName: 'cart', id: cartId);
              },
              icon: Icon(Icons.attach_money_rounded),
            ),
          ],
        ),
        body: ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int i) {
            return Card(
              child: Column(
                children: [
                  Image.network(products[i].image.toString()),
                  Text(products[i].name.toString()),
                  Text("${products[i].price} JOD"),
                  MaterialButton(
                    onPressed: () {
                      /*  apis
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
            );
          },
        ));
  }
}
