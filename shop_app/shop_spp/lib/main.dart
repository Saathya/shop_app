import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shop_spp/Provider/review_cart_provider.dart';
import 'package:shop_spp/Screens/login_scren.dart';
import 'Provider/product_vendor.dart';
import 'Provider/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Provider.debugCheckInvalidValueType = null;

   runApp(
    MultiProvider(
      providers: [
        Provider<UserProvider>(create: (_) => UserProvider()),
         Provider<ProductProvider>(create: (_) => ProductProvider()),
                Provider<ReviewCartProvider>(create: (_) => ReviewCartProvider()),
      ],
      child:  const MyApp(),
    ),);
}

class MyApp extends StatelessWidget {
  static const String id = "splash-screen";
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.deepPurple,
        ),
          builder: EasyLoading.init(),
        initialRoute: SplashScreen.id,
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          // HomeWidget.id: (context) => const HomeWidget(),
          LoginScreen.id: (context) => const LoginScreen(),
          // HomeScreen.id: (context) => const HomeScreen(),
          // MainScreen.id: (context) => const MainScreen(),
          // ShopsScreen.id: (context) => const ShopsScreen(),
          // CartScreen.id: (context) => const CartScreen(),
          // AccountScreen.id: (context) => const AccountScreen(),
          // OnboardingScreen.id: (context) => const OnboardingScreen()
        });
  }
}

class SplashScreen extends StatefulWidget {
  static const String id = "splash-screen";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(context, LoginScreen.id),
    );


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);
    return const Scaffold(
      body: Center(
          child: Text(
        "Multi Shop App",
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, letterSpacing: 2),
      )),
    );
  }
}
