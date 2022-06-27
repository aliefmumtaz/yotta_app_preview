part of 'pages.dart';

class VerificationPage extends StatefulWidget {
  final String phoneNumber;

  VerificationPage(this.phoneNumber);

  @override
  _VerificationPageState createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  BoxDecoration pinputDecoration = BoxDecoration(
    color: ThemeColor.whiteBackColor,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        blurRadius: 5,
        offset: Offset(0, 4),
        color: Colors.black.withOpacity(0.1),
      ),
    ],
  );

  var _smsCodeController = TextEditingController();

  bool isButtonClicked = false;
  bool isButtonAvailable = true;

  void _backButtonPressed() async {
    showDialog(
      context: context,
      builder: (_) => AlertBoxWidget(
        boxTitle: 'Kamu yakin ingin membatalkan verifikasi?',
        isRightCTA: true,
        onTapTopButton: () async {
          Navigator.pop(context);
          BlocProvider.of<PageBloc>(context).add(GoToLoginPage());
        },
        onTapBottomButton: () {
          Navigator.pop(context);
        },
      ),
    );
  }

  @override
  void initState() {
    if (this.mounted) {
      Future.delayed(Duration(seconds: 118), () {
        setState(() {
          isButtonAvailable = false;
        });
      });
    }
    super.initState();
  }

  @override
  void dispose() {
    _smsCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        _backButtonPressed();

        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              Container(color: ThemeColor.whiteBackColor),
              Container(height: 100, color: Colors.white),
              ListView(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 10),
                          blurRadius: 12,
                          color: Colors.black.withOpacity(0.05),
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(24),
                        bottomRight: Radius.circular(24),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: defaultMargin),
                          child: BackButtonWidget(
                            name: 'Verifikasi Nomor Telepon',
                            title: false,
                            onTapFunc: () async {
                              _backButtonPressed();
                            },
                          ),
                        ),
                        Container(
                          height: MediaQuery.of(context).size.height * .25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              AutoSizeText(
                                'Kode akan dikirim ke +62${widget.phoneNumber}',
                                style: accentFontBlackRegular.copyWith(
                                  color: ThemeColor.accentColor4,
                                  fontSize: 14,
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: defaultMargin,
                                ),
                                child: pinPut(),
                              ),
                              CountdownVerification(isClicked: true),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    'Tidak menerima kode?',
                                    style: accentFontBlackRegular.copyWith(
                                      color: ThemeColor.accentColor4,
                                      fontSize: 14,
                                    ),
                                  ),
                                  AutoSizeText(' '),
                                  GestureDetector(
                                    onTap: () {
                                      context.read<PageBloc>().add(
                                            GoToLoginPage(),
                                          );
                                    },
                                    child: AutoSizeText(
                                      'Kirim ulang',
                                      style: accentFontBlackRegular.copyWith(
                                        color: ThemeColor.mainColor,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(),
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Column(
                    children: [
                      _buildButtonConfirmation(),
                      SizedBox(
                        height: height * buttonBottomMargin,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isOTPCodeCheck = false;

  Widget _buildButtonConfirmation() {
    if (isButtonAvailable) {
      return GlobalButton(
        isButtonLoading: isButtonClicked,
        title: 'Konfirmasi Kode',
        onTapFunc: () async {
          if (_smsCodeController.text == '') {
            Flushbar(
              duration: Duration(seconds: 2),
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: flushColor,
              animationDuration: Duration(milliseconds: flushAnimationDuration),
              message: 'Silahkan mengisi kode verifikasi terlebih dahulu',
            )..show(context);
          } else {
            setState(() {
              isButtonClicked = true;
            });

            // await AuthServices.verifyForLogin(
            //   _smsCodeController.text,
            // );

            // Future.delayed(Duration(seconds: 10), () {
            //   setState(() {
            //     isButtonClicked = false;
            //   });
            // });

          }
        },
      );
    } else {
      return GlobalButton(
        isButtonSolidColor: true,
        isBorder: (!isButtonAvailable) ? false : true,
        borderColor: Colors.transparent,
        buttonSolidColor: (!isButtonAvailable) ? ThemeColor.accentColor4 : null,
        textColor: Colors.white,
        title: 'Kirim Ulang Kode',
        onTapFunc: () async {
          BlocProvider.of<PageBloc>(context).add(GoToLoginPage());
        },
      );
    }
  }

  Widget pinPut() {
    return PinPut(
      controller: _smsCodeController,
      autofocus: true,
      fieldsCount: 6,
      textStyle: mainFontBlackBold.copyWith(
        fontSize: 24,
        color: ThemeColor.mainColor,
      ),
      eachFieldHeight: MediaQuery.of(context).size.height * 0.07,
      eachFieldWidth: MediaQuery.of(context).size.width * 0.135,
      followingFieldDecoration: pinputDecoration,
      submittedFieldDecoration: pinputDecoration,
      selectedFieldDecoration: pinputDecoration,
      pinAnimationType: PinAnimationType.fade,
    );
  }
}
