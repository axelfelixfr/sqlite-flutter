import 'package:database_test/src/components/card_item.dart';
import 'package:database_test/src/models/diary.dart';
import 'package:database_test/src/models/page_diary.dart';
import 'package:database_test/src/pages/form_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  Diary diary;

  HomePage(this.diary, {Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<PageDiary> pages;

  void goForm() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormPage(addPage {diary: widget.diary, page: null})));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Bienvenido a tu diario ${widget.diary.type}"),
          actions: <Widget>[
            IconButton(onPressed: addPages, icon: Icon(Icons.playlist_add))
          ]),
      body: Center(
          child: (FutureBuilder<List<PageDiary>>(
        future: PageDiary().getPages(widget.diary.id),
        initialData: const [],
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          pages = snapshot.data;
          return (snapshot.connectionState == ConnectionState.done)
              ? getListView()
              : CircularProgressIndicator();
        },
      ))),
      floatingActionButton: FloatingActionButton(
        onPressed: goForm,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  getListView() {
    return ListView.builder(
        itemCount: pages.length,
        itemBuilder: (BuildContext context, int index) {
          PageDiary page = pages[index];
          return Dismissible(
              key: ObjectKey(page),
              onDismissed: (direction) {
                int idPage = page.id ?? 0;
                if (idPage != 0) {
                  // Eliminamos en nuestra base de datos
                  page.delete(idPage);
                  setState(() {
                    pages.removeAt(index);
                  });
                }
              },
              child: CardItem(addPage, pages[index]));
        });
  }

  addPage(PageDiary page) {
    pages.add(page);
  }

  addPages() {
    List<PageDiary> pages = [
      PageDiary(
          id: 10,
          date: "01-12-2021",
          title: "Página 10",
          content: "Página 10",
          diaryId: 1),
      PageDiary(
          id: 11,
          date: "02-12-2021",
          title: "Página 11",
          content: "Página 11",
          diaryId: 1),
      PageDiary(
          id: 12,
          date: "03-12-2021",
          title: "Página 13",
          content: "Página 13",
          diaryId: 1),
      PageDiary(
          id: 13,
          date: "04-12-2021",
          title: "Página 14",
          content: "Página 14",
          diaryId: 1)
    ];
    PageDiary().insertPages(pages);
  }
}
