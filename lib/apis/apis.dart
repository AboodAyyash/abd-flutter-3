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
}
