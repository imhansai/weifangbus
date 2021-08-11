import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weifangbus/generated/l10n.dart';

/// 关于软件
void showAboutSoftWareDialog(BuildContext context, Orientation orientation) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  final bodyTextStyle = textTheme.bodyText1;

  final softwareName = S.of(context).SoftWare;
  final seeSourceFirst = S.of(context).SeeSource;
  final repoText = 'weifangbus GitHub ' + S.of(context).Repo;
  final seeSourceSecond = '。';
  final legalese = '© 2019 hanandjun';
  showAboutDialog(
    context: context,
    applicationIcon: ClipOval(
      child: Image.asset(
        'assets/images/logo.png',
        width: orientation == Orientation.portrait ? 200.w : 100.w,
      ),
    ),
    applicationName: softwareName,
    applicationVersion: '1.0.0+5',
    applicationLegalese: '© 2019 hanandjun',
    children: <Widget>[
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
              style: bodyTextStyle!.copyWith(
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
  );
}
