import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:weifangbus/generated/l10n/app_localizations.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

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
    final bodyTextStyle = textTheme.bodyLarge;

    final name = AppLocalizations.of(context)!.softWare;
    final legalese = '© 2019-2025 imhansai';
    final seeSourceFirst = AppLocalizations.of(context)!.seeSource;
    final repoText = 'weifangbus GitHub ' + AppLocalizations.of(context)!.repo;
    final seeSourceSecond = '。';
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      content: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(
              future: getVersionNumber(),
              builder: (context, snapshot) => Text(
                snapshot.hasData ? '$name ${snapshot.data}' : '$name',
                style: textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppLocalizations.of(context)!.appDesc,
              style: bodyTextStyle,
            ),
            const SizedBox(height: 10),
            Text(
              AppLocalizations.of(context)!.specialInstructions,
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
                    style: bodyTextStyle?.copyWith(
                      color: colorScheme.primary,
                    ),
                    text: repoText,
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        final url = 'https://github.com/imhansai/weifangbus';
                        if (await canLaunchUrlString(url)) {
                          await launchUrlString(url);
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
        OutlinedButton(
          child: Text(
            AppLocalizations.of(context)!.viewLicenses,
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
        OutlinedButton(
          child: Text(AppLocalizations.of(context)!.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
