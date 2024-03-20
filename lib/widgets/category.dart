import 'package:flutter/material.dart';
import 'package:flutter3/firebase/service.dart';
import 'package:flutter3/models/category.dart';
import 'package:flutter3/pages/products.dart';
import 'package:flutter3/pages/sub-category.dart';
import 'package:flutter3/shared/shared.dart';

void goToProductPage(category) {
  Navigator.push<void>(
    navigatorKey.currentState!.context,
    MaterialPageRoute<void>(
      builder: (BuildContext context) => ProductsPage(
        categoryId: category.id,
      ),
    ),
  );
}

Widget category({required Category category}) {
  print("category.subCategories ${category.subCategories}");
  return InkWell(
    onTap: () {
      searchFirebaseDocument(
              collectionName: "categories",
              query: category.id,
              where: "perentId")
          .then((value) {
        print(value);
        if (value.length > 0) {
          Navigator.push<void>(
            navigatorKey.currentState!.context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => SubCatPage(
                title: category.name ?? "",
                subCategories: value,
              ),
            ),
          );
        } else {
          goToProductPage(category);
        }
      });
      /* if (category.subCategories != null) {
        if (category.subCategories!.isNotEmpty) {
          Navigator.push<void>(
            navigatorKey.currentState!.context,
            MaterialPageRoute<void>(
              builder: (BuildContext context) => SubCatPage(
                  title: category.name ?? "",
                  subCategories: category.subCategories ?? []),
            ),
          );
        } else {
          goToProductPage(category);
        }
      } else {
        goToProductPage(category);
      } */
    },
    child: Card(
      child: Container(
          child: Column(
        children: [
          Image.network(category.image.toString()),
          Text(category.name.toString()),
        ],
      )),
    ),
  );
}
