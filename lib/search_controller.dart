import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model.dart';

List<Model> list = [];

getApiData({String? url}) async {
  var response = await http.get(Uri.parse(url!));
  Map json = jsonDecode(response.body);
  json['hits'].forEach((e) {
    Model model = Model(
        url: e['recipe']['url'],
        image: e['recipe']['image'],
        label: e['recipe']['label'],
        source: e['recipe']['source']);

    list.add(model);
  });
}
