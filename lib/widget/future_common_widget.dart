import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weifangbus/generated/l10n.dart';

Widget noneWidget(BuildContext context) {
  return Text(S.of(context).NonWidgetLabel);
}

Widget activeOrWaitingWidget() {
  return SpinKitWave(
    color: Colors.blue,
    type: SpinKitWaveType.center,
  );
}

class RetryWidget extends StatefulWidget {
  final VoidCallback onPressed;

  const RetryWidget({Key? key, required this.onPressed}) : super(key: key);

  @override
  _RetryWidgetState createState() => _RetryWidgetState();
}

class _RetryWidgetState extends State<RetryWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RaisedButton(
        color: Colors.blue,
        highlightColor: Colors.blue[700],
        colorBrightness: Brightness.dark,
        splashColor: Colors.grey,
        child: AutoSizeText(
          S.of(context).RequestDataFailure,
          maxLines: 2,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.w),
        ),
        onPressed: widget.onPressed,
      ),
    );
  }
}
