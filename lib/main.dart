import 'package:flutter/material.dart';
import 'package:bill1/globals.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bill App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {},
        ),
        title: Text("Bill Splitter"),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.menu),
          ),
          SizedBox(
            width: 5,
          ),
        ],
        elevation: 30,
      ),
      body: MyHome(),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);

  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 20,
          ),
          ElevatedButton(
            child: Text(
              "Add new contact",
              style: Globals.st,
            ),
            onPressed: () {},
            style: Globals.btnst,
          ),
        ],
      ),
    );
  }
}
