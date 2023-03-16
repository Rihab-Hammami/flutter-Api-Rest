import 'package:flutter/material.dart';
import 'package:flutter_crud_rest_api/services/api_service.dart';

import 'adddatawidget.dart';
import 'caseslist.dart';
import 'models/cases.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ApiService api = ApiService();
  late List<Cases> casesList;

  @override
  Widget build(BuildContext context) {
    casesList = [];
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 167, 139, 214),
        
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        
      ),
      body: Container(
  child: Center(
    child: FutureBuilder(
      future: loadList(),
      builder: (context, snapshot) {
  if (snapshot.hasData && casesList.isNotEmpty) {
    print(casesList);
    return CasesList(cases: casesList);
  } else {
    return Center(
      child: Text(
        'No data found, tap plus button to add!',
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }
 
},
    ),
  ),
),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToAddScreen(context);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), 
    );
  }

  Future loadList() {
    Future<List<Cases>> futureCases = api.getCases();
    futureCases.then((casesList) {
      setState(() {
        print(casesList);
        this.casesList = casesList;
      });
    });
    return futureCases;
  }

  _navigateToAddScreen (BuildContext context) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddDataWidget()),
    );
  }
}