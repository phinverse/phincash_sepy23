import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:phincash/repository/cached_data.dart';
import 'package:phincash/src/loan_transaction/transactions/transaction_views/home_screen.dart';
import 'constants/asset_path.dart';
import 'intro_screens/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{

  var _visible = true;
  late Widget _svg;
  late bool loggedIn;
  late AnimationController animationController;
  late Animation<double> animation;

  CachedData cachedData = CachedData();

  startTime() {
    var _duration = const Duration(seconds: 3);
    return Timer(_duration, navigationPage);
  }

  Future<void> navigationPage() async {
    loggedIn = await cachedData.getLoginStatus();
    if (loggedIn) {
     Get.off(() => const HomeScreen());
   } else {
      Get.off(() => const OnBoardingScreen());
   }
  }

  @override
  void initState() {
    _svg = Image.asset(AssetPath.pngSplash);
        //SvgPicture.asset(AssetPath.splash, theme: const SvgTheme(fontSize: 25),);
    animationController = AnimationController(vsync: this, duration: const Duration(seconds: 1));
    animation = CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    animation.addListener(() => setState(() {}));
    animationController.forward();
    setState(() {
      _visible = !_visible;
    });
    startTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(top: false, bottom: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Container(width: animation.value * 250,
            height: animation.value * 100,
            decoration: const BoxDecoration(shape: BoxShape.rectangle, color: Colors.transparent,),
            child: _svg,
          ),
        ),
      ),
    );
  }
}