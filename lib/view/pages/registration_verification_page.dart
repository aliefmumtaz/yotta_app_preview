part of 'pages.dart';

class RegistrationVerificationPage extends StatefulWidget {
  final String uid;
  final String? email;
  final String? idMember;

  RegistrationVerificationPage({
    required this.uid,
    required this.email,
    required this.idMember,
  });

  @override
  _RegistrationVerificationPageState createState() =>
      _RegistrationVerificationPageState();
}

class _RegistrationVerificationPageState
    extends State<RegistrationVerificationPage> {
  bool isButtonClicked = false;
  late Timer _timer;
  auth.User? user;
  auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;

  bool isTimeout = false;

  Future<void> checkEmailVerified() async {
    user = _auth.currentUser;
    await user!.reload();
    if (user!.emailVerified) {
      _timer.cancel();
      await AuthServices.changeStatusToVerifiedEmail(widget.uid);
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            child: Image.asset(
              'assets/illustration_verification_bg.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          SafeArea(
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      SizedBox(height: height * (verticalMargin * 2)),
                      Container(
                        width: width * .7,
                        child: Image.asset(
                          'assets/illustration_verification.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                      SizedBox(height: height * verticalMargin),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultMargin,
                        ),
                        child: AutoSizeText(
                          (!isButtonClicked)
                              ? 'Emailmu belum diverifikasi'
                              : 'Silakan cek emailmu, ya!',
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          style: mainFontBlackBold.copyWith(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      SizedBox(height: height * verticalMarginHalf),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: defaultMargin,
                        ),
                        child: AutoSizeText(
                          'Verifikasi akun email diperlukan\nuntuk mengonfirmasi data kamu',
                          textAlign: TextAlign.center,
                          minFontSize: 6,
                          maxLines: 2,
                          style: accentFontBlackRegular.copyWith(
                            fontSize: 16,
                            color: ThemeColor.accentColor4,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultMargin,
                    ),
                    child: Column(
                      children: [
                        AutoSizeText(
                          (!isButtonClicked)
                              ? 'Link verifikasi akan dikirim ke:'
                              : 'Link verifikasi telah dikirim ke:',
                          minFontSize: 6,
                          maxLines: 3,
                          style: accentFontBlackRegular.copyWith(
                            fontSize: 12,
                            color: ThemeColor.accentColor4,
                          ),
                        ),
                        SizedBox(height: height * (verticalMarginHalf / 2)),
                        AutoSizeText(
                          widget.email!,
                          minFontSize: 6,
                          maxLines: 3,
                          style: accentFontBlackBold.copyWith(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      _buildCustomButton(
                        onTap: (!isButtonClicked)
                            ? () async {
                                setState(() {
                                  isButtonClicked = true;
                                });

                                user = _auth.currentUser;
                                user!.sendEmailVerification();
                                _timer = Timer.periodic(Duration(seconds: 5),
                                    (timer) {
                                  print('executed');
                                  checkEmailVerified();
                                });
                              }
                            : () {},
                      ),
                      SizedBox(height: height * verticalMargin),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            'Tidak menerima email? ',
                            minFontSize: 6,
                            maxLines: 1,
                            style: accentFontBlackRegular.copyWith(
                              fontSize: 14,
                              color: ThemeColor.accentColor4,
                            ),
                          ),
                          _buildTextButtonReSend(),
                        ],
                      ),
                      SizedBox(height: height * verticalMarginHalf),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            'Salah email? ',
                            minFontSize: 6,
                            maxLines: 1,
                            style: accentFontBlackRegular.copyWith(
                              fontSize: 14,
                              color: ThemeColor.accentColor4,
                            ),
                          ),
                          _buildTextButtonReRegis(),
                        ],
                      ),
                      SizedBox(height: height * (verticalMargin * 2)),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextButtonReRegis() {
    return BlocBuilder<PasswordTempBloc, PasswordTempState>(
      builder: (_, passwordState) => GestureDetector(
        onTap: () {
          _onPressedReRegis(
            idMember: widget.idMember,
            password: (passwordState is LoadPasswordTemp)
                ? passwordState.password
                : '',
          );
        },
        child: AutoSizeText(
          'Registrasi ulang',
          minFontSize: 6,
          maxLines: 1,
          style: accentFontBlackRegular.copyWith(
            fontSize: 14,
            color: ThemeColor.mainColor,
          ),
        ),
      ),
    );
  }

  Widget _buildTextButtonReSend() {
    return BlocBuilder<PasswordTempBloc, PasswordTempState>(
      builder: (_, passwordState) => GestureDetector(
        onTap: () => _onPressedReSend(),
        child: AutoSizeText(
          'Kirim ulang',
          minFontSize: 6,
          maxLines: 1,
          style: accentFontBlackRegular.copyWith(
            fontSize: 14,
            color: ThemeColor.mainColor,
          ),
        ),
      ),
    );
  }

  Widget _buildCustomButton({
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: onTap as void Function()?,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        width: (!isButtonClicked)
            ? MediaQuery.of(context).size.width * (1 - horizontalMargin * 4)
            : MediaQuery.of(context).size.height * .06,
        height: MediaQuery.of(context).size.height * .06,
        decoration: BoxDecoration(
          color: (!isButtonClicked)
              ? ThemeColor.mainColor
              : ThemeColor.accentColor4,
          borderRadius: BorderRadius.circular(12),
          gradient: (!isButtonClicked)
              ? LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [ThemeColor.mainColor, ThemeColor.mainColor],
                )
              : null,
          boxShadow: [
            (!isButtonClicked)
                ? BoxShadow(
                    color: ThemeColor.mainColor.withOpacity(0.4),
                    offset: Offset(0, 10),
                    blurRadius: 12,
                  )
                : BoxShadow(
                    color: ThemeColor.mainColor.withOpacity(0.0),
                    offset: Offset(0, 0),
                    blurRadius: 0,
                  ),
          ],
        ),
        child: Center(
          child: (!isButtonClicked)
              ? AutoSizeText(
                  'Verifikasi Sekarang',
                  style: mainFontWhiteBold.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                )
              : Icon(Icons.check, color: Colors.white, size: 30),
        ),
      ),
    );
  }

  void _onPressedReSend() {
    showDialog(
      context: context,
      builder: (_) => AlertBoxWidget(
        boxTitle: 'Kirim ulang email verifikasi?',
        isRightCTA: true,
        onTapBottomButton: () {
          Navigator.pop(context);
        },
        onTapTopButton: () async {
          Navigator.pop(context);

          Flushbar(
            duration: Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: ThemeColor.mainColor,
            animationDuration: Duration(milliseconds: flushAnimationDuration),
            message: 'Email verifikasi telah dikirim ulang',
          )..show(context);

          user = _auth.currentUser;
          user!.sendEmailVerification();
          _timer = Timer.periodic(Duration(seconds: 5), (timer) {
            print('re-send executed');
            checkEmailVerified();
          });
        },
      ),
    );
  }

  void _onPressedReRegis({
    required String? idMember,
    required String password,
  }) {
    showDialog(
      context: context,
      builder: (_) => AlertBoxWidget(
        boxTitle: 'Yakin ingin registrasi ulang?',
        isRightCTA: true,
        onTapBottomButton: () {
          Navigator.pop(context);
        },
        onTapTopButton: () async {
          Navigator.pop(context);

          context.read<PageBloc>().add(
                GoToSplashPage(),
              );

          await AuthServices.deleteCurrentUser(
            email: widget.email!,
            password: password,
            userId: widget.uid,
            idMember: idMember,
          );

          context.read<UserBloc>().add(SignOut());
          context.read<PasswordTempBloc>().add(PassowrdToinitial());
        },
      ),
    );
  }
}
