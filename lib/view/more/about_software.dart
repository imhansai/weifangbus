import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class _LinkTextSpan extends TextSpan {
  _LinkTextSpan({TextStyle style, String url, String text})
      : super(
          style: style,
          text: text ?? url,
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              launch(url, forceSafariVC: false);
            },
        );
}

void showAboutSoftWareDialog(BuildContext context) {
  final ThemeData themeData = Theme.of(context);
  final TextStyle aboutTextStyle = themeData.textTheme.bodyText1;
  final TextStyle linkStyle = themeData.textTheme.bodyText1.copyWith(color: themeData.accentColor);

  showAboutDialog(
    context: context,
    applicationVersion: '2019年3月',
    applicationIcon: const FlutterLogo(),
    applicationLegalese: '© 2019 hanandjun',
    children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: RichText(
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                style: aboutTextStyle,
                text: '这个app是个人工作之余通过flutter技术制作。相信更加现代一点吧😜。\n\n特别说明:接口由【潍坊掌上公交】提供，如有侵权，请联系我。\n\n',
              ),
              TextSpan(
                  style: aboutTextStyle,
                  text:
                      'Flutter是谷歌的移动UI框架，可以快速在iOS和Android上构建高质量的原生用户界面。 Flutter可以与现有的代码一起工作。在全世界，Flutter正在被越来越多的开发者和组织使用，并且Flutter是完全免费、开源的。\n更多详情请访问:'),
              _LinkTextSpan(
                style: linkStyle,
                url: 'https://flutter.io',
              ),
              TextSpan(
                style: aboutTextStyle,
                text: '.',
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
