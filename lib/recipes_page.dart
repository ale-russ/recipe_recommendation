import 'dart:developer';

import 'package:flutter/material.dart';

import 'details_page.dart';
import 'model.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({
    super.key,
    required this.list,
    required this.height,
  });

  final List<Model> list;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      height: height,
      child: GridView.builder(
          itemCount: list.length,
          shrinkWrap: true,
          primary: true,
          physics: const ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
          ),
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                log('Url: ${list[index].url}');
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailsPage(
                      url: list[index].url,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(
                      list[index].image.toString(),
                    ),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      height: 40,
                      child: Text(
                        list[index].label!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      color: Colors.black.withOpacity(0.5),
                      height: 40,
                      child: Center(
                        child: Text(
                          list[index].source!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
