// ignore_for_file: unnecessary_this

import 'package:database_test/src/models/diary.dart';
import 'package:database_test/src/pages/home_page.dart';
import 'package:flutter/material.dart';

class FormLockPage extends StatefulWidget {
  List<Diary> diaries;

  FormLockPage(this.diaries, {Key? key}) : super(key: key);

  // const LockPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FormLockPageState(this.diaries);
}

class _FormLockPageState extends State<FormLockPage> {
  List<Diary> diaries;
  _FormLockPageState(this.diaries);
  bool isNewDiary = false;
  TextEditingController ctrlType = TextEditingController();
  TextEditingController ctrlCode = TextEditingController();
  Diary dropDownValue = Diary();

  @override
  void initState() {
    isNewDiary = diaries == null;
    // Seleccionamos el primer diario de la lista con [0] por default
    dropDownValue = (diaries != null) ? diaries[0] : Diary();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Visibility(visible: !isNewDiary, child: dropDownButton()),
        Visibility(
            visible: isNewDiary,
            child: TextFormField(
                decoration: InputDecoration(hintText: "Tipo de Diario"),
                keyboardType: TextInputType.text,
                controller: ctrlType)),
        TextFormField(
            obscureText: true,
            decoration: InputDecoration(hintText: "Código"),
            keyboardType: TextInputType.text,
            controller: ctrlCode),
        TextButton(
          style: TextButton.styleFrom(
              primary: Colors.white, backgroundColor: Colors.green),
          child: Text(isNewDiary ? "Guardar" : "Desbloquear"),
          onPressed: isNewDiary ? save : unlock,
        )
      ],
    );
  }

  dropDownButton() {
    return (diaries != null)
        ? DropdownButton<Diary>(
            onChanged: onChangedDiary,
            value: dropDownValue,
            icon: Icon(Icons.arrow_drop_down),
            items: diaries.map<DropdownMenuItem<Diary>>((Diary value) {
              return DropdownMenuItem<Diary>(
                  value: value, child: Text(value.type));
            }).toList())
        : SizedBox.shrink();
  }

  onChangedDiary(Diary? diary) {
    if (diary != null) {
      setState(() {
        this.dropDownValue = diary;
      });
    }
  }

  save() async {
    Diary diary =
        await Diary(type: ctrlType.text, enterCode: ctrlCode.text).save();
    if (diary != null) {
      goToHome(diary);
    }
  }

  unlock() async {
    Diary diary = await dropDownValue.checkEnterCode(ctrlCode.text);
    if (diary != null) {
      goToHome(diary);
    }
  }

  goToHome(Diary diary) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => HomePage(diary)));
  }
}
