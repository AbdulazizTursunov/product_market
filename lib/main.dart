import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:product_market/ui/market_main_screen.dart';
import 'data/data/db_initialize.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();


  Directory? directory;
  if (Platform.isWindows) {
    directory = await getApplicationSupportDirectory();
  } else {
    directory = await getApplicationDocumentsDirectory();
  }

  if (!await directory.exists()) {
  directory.create(recursive: true);
  }
  DbInitialize().initDb(directory.path);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Product for   ',
      theme: ThemeData(
            useMaterial3: true,
      ),
      home:const  MainMarket(),
    );
  }
}


  
