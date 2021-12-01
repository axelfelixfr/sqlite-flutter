// ignore_for_file: unnecessary_this

import 'package:database_test/src/models/diary.dart';
import 'package:database_test/src/models/page_diary.dart';
import 'package:flutter/material.dart';

typedef VoidCallbackParam = Function(PageDiary page);

class FormPage extends StatefulWidget {
  Diary diary;
  PageDiary page;
  VoidCallbackParam voidCallbackParam;
  FormPage(this.voidCallbackParam, this.diary, this.page, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormPageState(this.page);
}

class _FormPageState extends State<FormPage> {
  PageDiary page;
  TextEditingController ctrlDate = TextEditingController();
  TextEditingController ctrlTitle = TextEditingController();
  TextEditingController ctrlContent = TextEditingController();
  _FormPageState(this.page);

  @override
  void initState() {
    if (page != null) {
      ctrlDate.text = page.date;
      ctrlTitle.text = page.title;
      ctrlContent.text = page.content;
    } else {
      ctrlDate.text = DateTime.now().toString().substring(0, 11);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
                child: Column(children: <Widget>[
      TextFormField(
          keyboardType: TextInputType.text,
          controller: ctrlDate,
          enabled: false),
      TextFormField(
          decoration: InputDecoration(hintText: "Título"),
          keyboardType: TextInputType.text,
          controller: ctrlTitle),
      TextFormField(
          decoration: InputDecoration(hintText: "Contenido"),
          keyboardType: TextInputType.text,
          controller: ctrlContent),
      TextButton(
        style: TextButton.styleFrom(
            primary: Colors.white, backgroundColor: Colors.green),
        child: Text("Guardar"),
        onPressed: save,
      )
    ]))));
  }

  getTextBox() {
    if (widget != null) {
      int widgetDiaryId = widget.diary.id;
      if (widgetDiaryId != 0) {
        page = (page != null) ? page : PageDiary(diaryId: widgetDiaryId);
        page.title = ctrlTitle.text;
        page.content = ctrlContent.text;
        page.date = ctrlDate.text;
      }
    }
  }

  save() async {
    getTextBox();
    PageDiary page = await this.page.saveOrUpdate();
    if (page != null) {
      widget.voidCallbackParam(page);
      Navigator.pop(context);
    }
  }
}
