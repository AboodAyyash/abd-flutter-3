import 'package:flutter3/apis/helper.dart';

class Apis {
  Future<Map> getCategories() async {
    Map data = {};
    await apiHelper(
            apiMethod: ApiMethod.get, apiPath: "/api/customer/categories")
        .then((value) {
      data = value;
    });
    return data;
  }

  ///api/customer/category-products/
  ///
  ///
  Future<Map> getCategoryProducts({categoryId}) async {
    Map data = {};
    await apiHelper(
            apiMethod: ApiMethod.get,
            apiPath: "/api/customer/category-products/$categoryId")
        .then((value) {
      data = value;
    });
    return data;
  }

  Future<Map> postAddToCart({productId, quantity, isDelete = 0}) async {
    Map data = {};

    var body = {
      "id": "$productId",
      "uuid": "ttest",
      "quantity": "$quantity",
      "delete": isDelete.toString(),
    };
    await apiHelper(
      apiMethod: ApiMethod.post,
      apiPath: "/api/customer/cart",
      bodyApi: body,
    ).then((value) {
      data = value;
    });
    return data;
  }

  Future<Map> getCart() async {
    Map data = {};
    await apiHelper(
            apiMethod: ApiMethod.get,
            apiPath: "/api/customer/cart?uuid=ttest")
        .then((value) {
      data = value;
    });
    return data;
  }
}
