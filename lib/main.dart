
import 'package:flutter/material.dart';
import 'package:stedaplivematches/homepage.dart';


void main() {
  runApp(MyApp());
}

// class ThemeModeManager extends StatefulWidget {
//   final Widget Function(ThemeMode themeMode) builder;
//   final ThemeMode defaultThemeMode;

//   const ThemeModeManager({required this.builder, required this.defaultThemeMode});
     

//   @override
//   _ThemeModeManagerState createState() =>
//       _ThemeModeManagerState(themeMode: defaultThemeMode);

//   static _ThemeModeManagerState? of(BuildContext context) {
//     return context.findAncestorStateOfType<_ThemeModeManagerState>();
//   }
// }

// class _ThemeModeManagerState extends State<ThemeModeManager> {
//   ThemeMode _themeMode;

//   _ThemeModeManagerState({required ThemeMode themeMode}) : _themeMode = themeMode;

//   set themeMode(ThemeMode mode) {
//     if (_themeMode != mode) {
//       setState(() {
//         _themeMode = mode;
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return widget.builder(_themeMode);
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var themeModeManager = ThemeModeManager(
//       defaultThemeMode: ThemeMode.light,
//       builder: (themeMode) {
//         return MaterialApp(
//           title: 'Stedap Live Matches',
//           debugShowCheckedModeBanner: false,
//           // theme: ThemeData(

//           //   primarySwatch: Colors.blue,
//           // ),
//           home: MyHomePage(),
//           // title: 'ThemeMode Selector',
//           // themeMode: themeMode,
//           theme: ThemeData.light(),
//           darkTheme: ThemeData.dark(),
//           // home: MyApp(),
//         );
//       }, 
//     );
//     return themeModeManager;
//   }
// }

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stedap Live Matches',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}
