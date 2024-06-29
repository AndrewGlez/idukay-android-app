import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:myappflutter/fetchTasks.dart';
import 'package:myappflutter/taskpage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences prefs = await SharedPreferences.getInstance();

  String auth = await postLogin(prefs);


  String? authorization = prefs.getString("Authorization");

  Map<String, String> reqHeaders = {
    "Authorization": authorization ?? auth,
    "User-Agent": "PostmanRuntime/7.32.1",
    "selectedstudent": "5ea75880a58cd80010de21e9",
    "workingyear": "64d4f945782ad59eefd5d92a",
    "workingschool": "59aebf00f9bc648c2118cc35",
    "workingprofile": "59b306e6b8432e5340b394b2",
    "clientversion": "0.9.68"
  };
  initializeDateFormatting('es_ES', null).then((_) => runApp(MyApp(prefs: prefs, reqHeaders: reqHeaders,)));


}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final Map<String, String> reqHeaders;

  const MyApp({super.key, required this.prefs, required this.reqHeaders});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IdukayApp',
      themeMode: ThemeMode.system,
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.lightBlueAccent, // Your desired seed color for dark theme
          brightness: Brightness.dark, // Ensuring it's a dark theme
        ),
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: TaskPage(
        prefs: prefs,
        reqHeaders: reqHeaders,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
