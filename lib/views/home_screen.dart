import 'package:flutter/material.dart';
import 'package:melodex/theme/app_theme.dart';
import 'package:melodex/widgets/custom_app_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.bg,
      appBar: AppBar(backgroundColor: AppTheme.bg, title: CustomAppBar()),
      body: SafeArea(child: Column(children: [
        
      ])),
    );
  }
}
