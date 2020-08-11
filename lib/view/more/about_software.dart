import 'package:flutter/material.dart';

void showAboutSoftWareDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('潍坊公交'),
        content: Text('这个app是个人工作之余通过flutter技术制作。相信更加现代一点吧😜。\n\n特别说明:接口由【潍坊掌上公交】提供，如有侵权，请联系我。'),
        actions: <Widget>[
          FlatButton(
            child: Text('确定'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
