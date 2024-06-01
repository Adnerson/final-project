import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:project1/services/constant.dart';
import 'package:project1/services/httpService.dart';

mixin Func {
  HttpService httpService = HttpService();
  Future<Response<dynamic>> sendRequest(
      {required String endpoint,
      required Method method,
      Map<String, dynamic>? params,
      String? authorizationHeader}) async {
    httpService.init(BaseOptions(
        baseUrl: baseUrl,
        contentType: "application/json",
        headers: {"Authorization": authorizationHeader}));
    final response = await httpService.request(
        endpoint: endpoint, method: method, params: params);
    return response;
  }

  Future<List<dynamic>> getUsersPostgresql(BuildContext context) async {
    List<dynamic> lists = [];
    try {
      final response =
          await sendRequest(endpoint: postgresqlUsers, method: Method.GET);
      lists = response.data as List<dynamic>;
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Failed to fetch lists: $e")));
    }
    return lists;
  }

  Future<List<dynamic>> getUserbyEmail(
      String email, BuildContext context) async {
    List<dynamic> user = [];
    await sendRequest(endpoint: postgresqlUsers + email, method: Method.GET)
        .then((itms) {
      user = itms.data as List<dynamic>;
    }).catchError((err) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Failed to fetch items")));
    });
    return user;
  }

  Future<bool> validatePassword(
      String email, String password, BuildContext context) async {
    List<dynamic> user = await getUserbyEmail(email, context);
    return (user[0]['password'] == password);
  }
}
