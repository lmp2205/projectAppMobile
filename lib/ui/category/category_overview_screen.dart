import 'package:flutter/material.dart';

import '../../models/category.dart';
import '../products/products_overview_screen.dart';
import 'Utils.dart';
import 'category_screen.dart';

class CategoryListPage extends StatelessWidget {
  List<Category> categories = Utils.getMockedCategories();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (ctx) => const categoryScreen(),
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      height: 130,
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                                'assets/imgs/${categories[index].imgName}.jpg',
                                fit: BoxFit.cover),
                          )),
                          Container(
                            height: 200,
                            width: 400,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  categories[index].title,
                                  style: const TextStyle(
                                      color: Colors.redAccent,
                                      fontSize: 30,
                                      fontFamily: "Roboto",
                                      fontWeight: FontWeight.w900,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black87,
                                            offset: Offset(2, 1),
                                            blurRadius: 10)
                                      ]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
