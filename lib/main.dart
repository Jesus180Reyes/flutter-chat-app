import 'package:chat_app/pages/pages.dart';
import 'package:chat_app/services/socket_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SocketService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        initialRoute: "home",
        routes: {
          "home": (context) => const HomePage(),
          "user": (context) => const UserPage(),
        },
      ),
    );
  }
}
