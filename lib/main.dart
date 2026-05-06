import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:melodex/providers/music_provider.dart';
import 'package:melodex/theme/app_theme.dart';
import 'package:melodex/views/main_view.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => MusicProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashFactory: NoSplash.splashFactory,
        textTheme: GoogleFonts.beVietnamProTextTheme(AppTheme.dark.textTheme),
        
      ),
      home: const MainView(),
    );
  }
}
