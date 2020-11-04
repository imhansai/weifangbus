import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

/// 关于软件
void showAboutSoftWareDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (context) {
      return _AboutDialog();
    },
  );
}

/// 获取版本号
Future<String> getVersionNumber() async {
  final packageInfo = await PackageInfo.fromPlatform();
  return packageInfo.version;
}

class _AboutDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final bodyTextStyle = textTheme.bodyText1;

    final name = '潍坊公交';
    final legalese = '© 2019 hanandjun';
    final seeSourceFirst = '要查看此应用的源代码，请访问';
    final repoText = 'weifangbus GitHub 代码库';
    final seeSourceSecond = '。';
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        constraints: BoxConstraints(maxWidth: 1.sw),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(
              future: getVersionNumber(),
              builder: (context, snapshot) => Text(
                snapshot.hasData ? '$name ${snapshot.data}' : '$name',
                style: textTheme.headline5,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              '此 App 是个人工作之余通过 Flutter 技术制作。目的是奔着现代一点去的,希望大家喜欢😜。',
              style: bodyTextStyle,
            ),
            const SizedBox(height: 10),
            Text(
              '特别说明: 接口由【潍坊掌上公交】提供，如有侵权，请联系我。',
              style: bodyTextStyle,
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    style: bodyTextStyle,
                    text: seeSourceFirst,
                  ),
                  TextSpan(
                    style: bodyTextStyle.copyWith(
                      color: colorScheme.primary,
                    ),
                    text: repoText,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final url = 'https://github.com/hanandjun/weifangbus';
                        if (await canLaunch(url)) {
                          await launch(
                            url,
                            forceSafariVC: false,
                          );
                        }
                      },
                  ),
                  TextSpan(
                    style: bodyTextStyle,
                    text: seeSourceSecond,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Text(
              legalese,
              style: bodyTextStyle,
            ),
          ],
        ),
      ),
      actions: [
        FlatButton(
          textColor: colorScheme.primary,
          child: Text(
            '查看许可',
          ),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute<void>(
              builder: (context) => LicensePage(
                applicationName: name,
                applicationLegalese: legalese,
              ),
            ));
          },
        ),
        FlatButton(
          textColor: colorScheme.primary,
          child: Text('关闭'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
