// ignore_for_file: avoid_print, prefer_const_constructors, use_key_in_widget_constructors, empty_constructor_bodies, use_function_type_syntax_for_parameters, unused_element

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  
FirebaseMessaging.onBackgroundMessage(_handleMessage);

  runApp(MyApp());
}

Future<void> _handleMessage(RemoteMessage message) async {
  await Firebase.initializeApp();

  if(message.notification != null){
    print(message.notification!.body);
  }
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  // MyApp({Key? key}) : super(key: key);

  // late FirebaseMessaging messaging;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late FirebaseMessaging messaging;

  @override
  void initState() {
    super.initState();

    messaging = FirebaseMessaging.instance;

    //getting token to send message to flutter application
    messaging.getToken().then((value) {
      print('token is : $value');
    });

  FirebaseMessaging.onMessage.listen((RemoteMessage event){
    print('message received');
    print('message is: ${event.notification!.body}');

  showDialog(
        context: context, 
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Notification from Firebase!'),
            content: Text(event.notification!.body!),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                )
            ],
          );
        });
    });

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
  
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
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
