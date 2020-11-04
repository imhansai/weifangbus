import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weifangbus/generated/l10n.dart';

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

    final name = S.of(context).SoftWare;
    final legalese = '© 2019 hanandjun';
    final seeSourceFirst = S.of(context).SeeSource;
    final repoText = 'weifangbus GitHub ' + S.of(context).Repo;
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
              S.of(context).AppDesc,
              style: bodyTextStyle,
            ),
            const SizedBox(height: 10),
            Text(
              S.of(context).SpecialInstructions,
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
            S.of(context).ViewLicenses,
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
          child: Text(S.of(context).Close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
