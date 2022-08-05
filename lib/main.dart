import 'package:firstapp/routes/route_manager.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteManager.onGenerateRoute,
      initialRoute: RouteManager.loadingPage,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      
    );
  }
}


