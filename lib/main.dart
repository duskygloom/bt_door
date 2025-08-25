import 'package:bt_door/main_theme.dart';
import 'package:bt_door/model/nearby_devices.dart';
import 'package:bt_door/providers/bt_status_provider.dart';
import 'package:bt_door/providers/refresh_provider.dart';
import 'package:bt_door/view/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => RefreshProvider()),
        ChangeNotifierProvider(create: (context) => NearbyDevices()),
        ChangeNotifierProvider(create: (context) => BTStatusProvider()),
      ],
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: MainTheme.lightTheme,
      darkTheme: MainTheme.darkTheme,
      themeMode: ThemeMode.system,
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
