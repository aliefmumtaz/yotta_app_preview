part of 'widgets.dart';

class CountdownVerification extends StatefulWidget {
  final bool isClicked;

  CountdownVerification({this.isClicked = false});

  @override
  _CountdownVerificationState createState() => _CountdownVerificationState();
}

class _CountdownVerificationState extends State<CountdownVerification> {
  late Timer _timer;
  int _start = 60;
  bool isTimeout = false;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    if (this.mounted) {
      if (widget.isClicked) {
        startTimer();
        Future.delayed(Duration(seconds: 60), () {
          setState(() {
            isTimeout = true;
          });
        });
      }
    }
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      'Verifikasi akan diproses dalam: $_start detik',
      minFontSize: 6,
      maxLines: 1,
      style: accentFontBlackRegular.copyWith(
        fontSize: 12,
        color: ThemeColor.accentColor4,
      ),
    );
  }
}
