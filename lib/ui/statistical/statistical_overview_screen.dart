

import 'package:flutter/material.dart';
import 'package:myshop/models/product.dart';
import 'package:myshop/ui/statistical/pro_fit_screen.dart';
import 'package:myshop/ui/statistical/user_products_screen.dart';

import 'kyhan_screen.dart';
import 'quakyhan_screen.dart';



class StatisticalOverviewScreen extends StatefulWidget {
  static const routeName = '/statistical';
  const StatisticalOverviewScreen({super.key});
  @override
  State<StatisticalOverviewScreen> createState() => _StatisticalOverviewScreen();
}

class _StatisticalOverviewScreen extends State<StatisticalOverviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Thống kê',style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.amber,
          centerTitle: true,
          
        ),
        // drawer: const AppDrawer(),
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
                   Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => const ProFitScreen(),
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
                          Icons.attach_money_rounded,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Doanh thu",
                          style: TextStyle(color: Colors.white, fontSize: 20)
                          ,
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
                        builder: (ctx) => const UserProductsScreen(),
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
                          Icons.format_list_bulleted_rounded,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Tổng ký gửi",
                          style: TextStyle(color: Colors.white, fontSize: 20)
                          ,
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
                        builder: (ctx) => const KyHanScreen(
                          
                        ),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.deepOrangeAccent),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.priority_high_outlined,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Đến kỳ hạn",
                          style: TextStyle(color: Colors.white, fontSize: 20)
                          ,
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
                        builder: (ctx) => const QuaKyHanScreen(),
                      ),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.redAccent),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.warning_amber_outlined,
                          size: 50,
                          color: Colors.white,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Quá kỳ hạn",
                          style: TextStyle(color: Colors.white, fontSize: 20)
                          ,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  // Widget buildShoppingCartIcon() {
  //   return Consumer<CartManager>(
  //     builder: (ctx, cartManager, child) {
  //       return TopRightBadge(
  //         data: cartManager.productCount,
  //         child: IconButton(
  //           icon: const Icon(
  //             Icons.shopping_cart,
  //           ),
  //           onPressed: () {
  //             Navigator.of(ctx).pushNamed(CartScreen.routeName);
  //           },
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget buildProductFilterMenu() {
  //   return PopupMenuButton(
  //       onSelected: (FilterOptions selectedValue) {
  //         if (selectedValue == FilterOptions.favorites) {
  //           _showOnlyFavorites.value = true;
  //         } else {
  //           _showOnlyFavorites.value = false;
  //         }
  //       },
  //       icon: const Icon(
  //         Icons.more_vert,
  //       ),
  //       itemBuilder: (ctx) => [
  //             const PopupMenuItem(
  //               value: FilterOptions.favorites,
  //               child: Text("Only favorites"),
  //             ),
  //             const PopupMenuItem(
  //               value: FilterOptions.all,
  //               child: Text('Show All'),
  //             )
  //           ]);
  // }
}
