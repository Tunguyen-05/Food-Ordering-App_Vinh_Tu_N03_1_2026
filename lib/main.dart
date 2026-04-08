import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Ordering App',
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Food Ordering App'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Thành viên nhóm',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),

            Card(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: const ListTile(
                leading: Icon(Icons.person),
                title: Text('Vinh'),
                subtitle: Text('MSSV: 23010507 '),
              ),
            ),

            Card(
              margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              child: const ListTile(
                leading: Icon(Icons.person),
                title: Text('Tú'),
                subtitle: Text('MSSV: 23010645'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}