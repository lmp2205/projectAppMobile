import 'package:flutter/material.dart';
import 'package:myshop/ui/category/category_overview_screen.dart';
import 'package:myshop/ui/products/edit_product_screen.dart';
import 'package:myshop/ui/products/products_overview_screen.dart';
import 'package:myshop/ui/shared/app_drawer.dart';
import 'package:myshop/ui/statistical/statistical_overview_screen.dart';
import 'package:provider/provider.dart';

import 'ui/auth/auth_manager.dart';



class HomepageOverviewScreen extends StatefulWidget {
  static const routeName = '/home-page';
  const HomepageOverviewScreen({super.key});
  @override
  State<HomepageOverviewScreen> createState() => _HomepageOverviewScreenState();
}

class _HomepageOverviewScreenState extends State<HomepageOverviewScreen> {


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tiệm cầm đồ',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.amber,
        centerTitle: true,
      ),
      drawer: const AppDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView(
          padding: const EdgeInsets.only(top: 120),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1,
            crossAxisSpacing: 20,
            mainAxisSpacing: 10,
          ),
          children: [
            GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed(
                    EditProductScreen.routeName,
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.greenAccent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.add,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Thêm",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const ProductsOverviewScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.amberAccent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.dialpad_outlined,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Tài sản ký gửi",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GridTile(
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const StatisticalOverviewScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blueAccent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.border_color,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Thống kê",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            GridTile(
              child: GestureDetector(
                onTap: () {
                 Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (ctx) => const categoryviewScreen(),
                    ),
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.deepPurpleAccent),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.category_outlined,
                        size: 50,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Danh mục",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
