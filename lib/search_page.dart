import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe_recommendation/recipes_page.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

// ignore: must_be_immutable
class SearchPage extends StatefulWidget {
  SearchPage({super.key, required this.search});
  String? search;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Model> list = [];
  bool hasList = false;

  getApiData({String? search}) async {
    var url =
        "https://api.edamam.com/search?q=$search&app_id=be3353b4&app_key=2bf5acbfc6f59e90920704e6d64a2a8c&from=0&to=30&calories=591-722&health=alcohol-free";
    var response = await http.get(Uri.parse(url));
    Map json = jsonDecode(response.body);

    log('Json: ${json["more"]}');

    json['hits'].forEach((item) {
      Model model = Model(
          url: item['recipe']['url'],
          image: item['recipe']['image'],
          label: item['recipe']['label'],
          source: item['recipe']['source']);
      setState(() {
        list.add(model);
      });
    });
  }

  // @override
  // void initState() {
  //   getApiData(search: widget.search);
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getApiData(search: widget.search),
        builder: (context, snapshot) {
          log('snapshot: ${snapshot.connectionState}');
          if (list.isEmpty) {
            return Container(
              color: Colors.black,
              child: Center(
                child: Text(
                  'No Recipe of ${widget.search} found',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            );
          }
          // if (snapshot.connectionState == ConnectionState.done &&
          //     snapshot.hasData &&
          //     snapshot.data != null) {
          return RecipesPage(
              list: list, height: MediaQuery.of(context).size.height);
          // }

          // return const Center(
          //     child: CircularProgressIndicator(
          //   color: Colors.blue,
          // ));
        },
      ),
    );
  }
}
