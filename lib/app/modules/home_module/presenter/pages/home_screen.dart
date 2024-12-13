import 'package:flutter/material.dart';
import 'package:flutter_leap_v2/app/modules/home_module/presenter/pages/animations/animated_form_screen.dart';
import 'package:flutter_leap_v2/app/modules/home_module/presenter/pages/animations/animated_shimmer_list_screen.dart';
import 'package:flutter_leap_v2/app/modules/home_module/presenter/pages/animations/mood_splash_screen.dart';
import 'package:flutter_leap_v2/app/modules/home_module/presenter/pages/animations/pensea_splash.dart';
import 'package:flutter_leap_v2/app/modules/home_module/presenter/pages/custom_page_view.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = "/homeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> minhasPaginas = [
   const AnimatedShimmerListScreen(),
   const AnimatedFormScreen(),
   const MoodSplashScreen(),
   const PenseaSplash(),
  ];

  @override
  Widget build(BuildContext context) {
    return CustomPageView(
      pages: minhasPaginas,
    );
  }
}
