import 'package:database_test/src/models/page_diary.dart';
import 'package:database_test/src/pages/form_page.dart';
import 'package:flutter/material.dart';

class CardItem extends StatelessWidget {
  PageDiary page;
  VoidCallbackParam voidCallbackParam;
  CardItem(this.voidCallbackParam, this.page, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onPressPage(context),
        child: Card(
            elevation: 5,
            child: Row(children: <Widget>[
              SizedBox(
                child: Icon(Icons.calendar_today),
                height: 100,
                width: 100,
              ),
              Flexible(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                    Text(page.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 15)),
                    Row(children: <Widget>[
                      Icon(Icons.access_time, color: Colors.green),
                      Text(page.date, style: TextStyle(fontSize: 11)),
                    ])
                  ]))
            ])));
  }

  onPressPage(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => FormPage(voidCallbackParam, page)));
  }
}
