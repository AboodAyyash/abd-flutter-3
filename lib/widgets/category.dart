import 'package:flutter/material.dart';
import 'package:flutter3/pages/products.dart';
import 'package:flutter3/pages/sub-category.dart';
import 'package:flutter3/shared/shared.dart';

void goToProductPage(category) {
  Navigator.push<void>(
    navigatorKey.currentState!.context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => ProductsPage(
        categoryId: category['id'].toString(),
      ),
    ),
  );
}

Widget category({category}) {
  return InkWell(
    onTap: () {
      if (category['sub_category'] != null) {
        if (category['sub_category'].isNotEmpty) {
          Navigator.push<void>(
            navigatorKey.currentState!.context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => SubCatPage(
                  title: category['name'].toString(),
                  subCategories: category['sub_category']),
            ),
          );
        } else {
          goToProductPage(category);
        }
      } else {
        goToProductPage(category);
      }
    },
    child: Card(
      child: Container(
          child: Column(
        children: [
          Image.network(baseURL + category['image']),
          Text(category['name'].toString()),
        ],
      )),
    ),
  );
}
