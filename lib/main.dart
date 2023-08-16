import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:recipe_recommendation/search_page.dart';

import 'model.dart';

import 'recipes_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      color: Colors.grey,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      "https://api.edamam.com/search?q=chicken&app_id=be3353b4&app_key=2bf5acbfc6f59e90920704e6d64a2a8c&from=0&to=30&calories=591-722&health=alcohol-free";
  List<Model> list = [];

  String? searchText;

  getApiData() async {
    var response = await http.get(Uri.parse(url));
    Map json = jsonDecode(response.body);
    json['hits'].forEach((e) {
      Model model = Model(
          url: e['recipe']['url'],
          image: e['recipe']['image'],
          label: e['recipe']['label'],
          source: e['recipe']['source']);
      setState(() {
        list.add(model);
      });
    });
  }

  @override
  void initState() {
    getApiData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 0, 0, 0.298),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(211, 35, 35, 37),
        elevation: 0,
        title: const Text(
          'Food Recipe app',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                style: const TextStyle(color: Colors.white),
                onChanged: (value) {
                  searchText = value;
                },
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    color: Colors.grey,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (
                            context,
                          ) =>
                              SearchPage(search: searchText),
                        ),
                      );
                    },
                  ),
                  hintStyle: const TextStyle(color: Colors.grey),
                  hintText: 'Search For Recipes',
                  fillColor: Colors.green.withOpacity(0.04),
                  filled: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              RecipesPage(
                list: list,
                height: MediaQuery.of(context).size.height * 0.77,
              )
            ],
          ),
        ),
      ),
    );
  }
}
