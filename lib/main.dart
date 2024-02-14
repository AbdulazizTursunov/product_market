import 'view.dart';


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
  runApp(const MyPrintApp());
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


  
