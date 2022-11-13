import 'package:firstapp/routes/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'services/service_view_model.dart';
import 'services/user_view_model.dart';
// Future main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await UserPreferences.init();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserViewModel(),
        ),
        ChangeNotifierProvider(create: (context) => ServiceViewModel())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteManager.onGenerateRoute,
        initialRoute: RouteManager.loadingPage,
        theme: ThemeData(
          primaryColor: Colors.indigo.shade50,
          primarySwatch: Colors.indigo,
        ),
      ),
    );
  }
}
