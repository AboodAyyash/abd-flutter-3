import 'package:dio/dio.dart';
import 'package:flutter3/shared/shared.dart';

final dio = Dio();

enum ApiMethod { get, post, put, delete }

Future apiHelper(
    {required apiMethod, bodyApi, hasBody = false, required apiPath}) async {
  Map data = {};
  try {
    final response = apiMethod == ApiMethod.get
        ? await dio.get(baseURL + apiPath)
        : await dio.post(
            baseURL + apiPath,
            queryParameters: hasBody ? bodyApi : {},
          );
    data = {"data": response.data, 'status': response.statusCode.toString()};
  } catch (e) {
    print(e);
    data = {"data": {}, 'status': "900"};
  }

  return data;
}
