import 'package:flutter/material.dart';
import 'package:flutter_final_project/screens/Seller_screen.dart';
import 'package:flutter_final_project/screens/ShoppingCartPage.dart';
import 'package:flutter_final_project/screens/Update_product_screen.dart';
import 'package:flutter_final_project/screens/create_product_screen.dart';
import 'package:flutter_final_project/screens/home_screen.dart';
import 'package:flutter_final_project/screens/login_screen.dart';
import 'package:flutter_final_project/screens/signup_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: "AIzaSyBUwhRTblZ0viHFv1Kam2pBlwelCOYfXu4",
      authDomain: "gestionx-90768.firebaseapp.com",
      projectId: "gestionx-90768",
      storageBucket: "gestionx-90768.appspot.com",
      messagingSenderId: "682907348640",
      appId: "1:682907348640:web:21b84b340c8974edb3a3c5",
      measurementId: "G-RGVL0412FG",
    ),
  );

  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GX',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/home': (context) => HomeScreen(userId: ''),
        '/signup': (context) => SignupPage(),
        '/sellerhome': (context) => SellerScreen(sellerName: ''),
        '/cart': (context) => ShoppingCartPage(cartItems: []),
        '/createproduct': (context) => CreateProductScreen(),
        '/updateproduct': (context) => UpdateProductScreen(),
      },

    );
  }
}
