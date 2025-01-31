
import 'package:brainly/Pages/home_page.dart';
import 'package:brainly/providers/controller.dart';
import 'package:brainly/providers/theme_provider.dart';
import 'package:brainly/themes/theme_preferences.dart';
import 'package:brainly/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => Controller()),
    ChangeNotifierProvider(create: (_) => ThemeProvider()),
  ],
  child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      initialData: false,
      future: ThemePreferences.getTheme(),
      builder: (context, snapshot) {
        if(snapshot.hasData){
          WidgetsBinding.instance?.addPostFrameCallback((timestamp){
          Provider.of<ThemeProvider>(context, listen: false).setTheme(turnOn: snapshot.data as bool);
          });
        }
        return Consumer<ThemeProvider>(
        builder: (_, notifier, __) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Brainly',
          theme: notifier.isDark? darkTheme: lightTheme,
         home: const HomePage(),
        ),
      );
      },
    );
  }
}
