import 'package:database_test/src/components/form_lock_page.dart';
import 'package:database_test/src/models/diary.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: SafeArea(
            child: Scaffold(
                body: Center(
                    child: (FutureBuilder<List<Diary>>(
          future: Diary().getDiaries(),
          initialData: const [],
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            return (snapshot.connectionState == ConnectionState.done)
                ? FormLockPage(snapshot.data)
                : CircularProgressIndicator();
          },
        ))))));
  }
}
