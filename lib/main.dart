import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'homepage_overview_screen.dart';
import 'ui/screen.dart';


Future<void> main() async {
  await dotenv.load();
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => AuthManager(),
        ),
        ChangeNotifierProxyProvider<AuthManager, ProductsManager>(
          create: (ctx) => ProductsManager(),
          update: (ctx, authManager, productsManager) {
            productsManager!.authToken = authManager.authToken;
            return productsManager;
          }
        ),
       
      ],
      child: Consumer<AuthManager>(
        builder: (ctx, authManager, child) {
          return MaterialApp(
            title: 'QLCamDo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: 'Lato',
              colorScheme: ColorScheme.fromSwatch(
                primarySwatch: Colors.blue,
              ).copyWith(
                secondary: Colors.deepOrange,
              )
            ),
            home: authManager.isAuth
                ? const HomepageOverviewScreen()
                : FutureBuilder(
                  future: authManager.tryAutoLogin(),
                  builder: ((context, snapshot) {
                    return snapshot.connectionState == ConnectionState.waiting
                        ? const SplashScreen()
                        : const AuthScreen();
                  })
                ),
           
            onGenerateRoute:(settings) {
              if(settings.name == ProductDetailScreen.routeName){
                final productId = settings.arguments as String;

                return MaterialPageRoute(
                  builder: (ctx) {
                    return ProductDetailScreen(
                      ctx.read<ProductsManager>().findById(productId),
                
                    );
                  }
                );
              }
             
              if (settings.name == EditProductScreen.routeName) {
                final productId = settings.arguments as String? ;
                return MaterialPageRoute(
                  builder: (ctx) {
                    return EditProductScreen(
                      productId != null
                      ? ctx.read<ProductsManager>().findById(productId)
                      : null,
                    );
                  }
                );
              }
              return null;
            },
          );
        }
      )
    );
  }
}


