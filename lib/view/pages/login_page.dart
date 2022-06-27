part of 'pages.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  CollectionReference emailCheck =
      FirebaseFirestore.instance.collection('user');
  String? emailChecked;

  bool isEmailValid = true;
  bool isPasswordCorrect = true;
  bool isButtonLoading = false;
  bool shouldPop = true;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToSplashPage());

        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              ListView(
                children: [
                  SafeArea(
                    child: Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: defaultMargin),
                      child: Column(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              BackButtonWidget(
                                name: 'Masuk',
                                onTapFunc: () async {
                                  context
                                      .read<PageBloc>()
                                      .add(GoToSplashPage());
                                },
                              ),
                              SizedBox(height: height * verticalMargin),
                              Container(
                                height: height * 0.2,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(
                                      'assets/login_page.png',
                                    ),
                                    fit: BoxFit.fitHeight,
                                  ),
                                ),
                              ),
                              SizedBox(height: height * verticalMargin),
                              Column(
                                children: [
                                  GlobalTextField(
                                    controller: emailController,
                                    isAutofillHints: true,
                                    hintText: 'Email',
                                    inputColor: (!isEmailValid)
                                        ? ThemeColor.errorColor
                                        : ThemeColor.mainColor,
                                    borderColor: (!isEmailValid)
                                        ? ThemeColor.errorColor
                                        : ThemeColor.mainColor,
                                  ),
                                  SizedBox(height: height * verticalMargin),
                                  GlobalTextField(
                                    controller: passwordController,
                                    hintText: 'Password',
                                    obsecureText: true,
                                    isSuffixIcon: true,
                                    suffixIconColor: (!isPasswordCorrect)
                                        ? ThemeColor.errorColor
                                        : ThemeColor.mainColor,
                                    inputColor: (!isPasswordCorrect)
                                        ? ThemeColor.errorColor
                                        : ThemeColor.mainColor,
                                    borderColor: (!isPasswordCorrect)
                                        ? ThemeColor.errorColor
                                        : ThemeColor.mainColor,
                                  ),
                                ],
                              ),
                              SizedBox(height: height * verticalMargin),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ResetPasswordPage(),
                                    ),
                                  );
                                },
                                child: AutoSizeText(
                                  'Lupa sandi',
                                  style: accentFontBlackRegular.copyWith(
                                    color: ThemeColor.mainColor,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              SizedBox(height: height * verticalMarginHalf),
                              Row(
                                children: [
                                  AutoSizeText(
                                    'Belum punya akun? ',
                                    style: accentFontBlackRegular.copyWith(
                                      color: ThemeColor.accentColor4,
                                      fontSize: 14,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<ListCityForRegistrationBloc>()
                                          .add(GetCityList());

                                      context.read<PageBloc>().add(
                                            GoToRegistrationPage(
                                              RegistrationData(),
                                              DataForRegisteredIdMember(),
                                              false,
                                            ),
                                          );
                                    },
                                    child: AutoSizeText(
                                      'Daftar sekarang',
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
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: defaultMargin,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Spacer(),
                      Column(
                        children: [
                          _buildButtonConfimation(),
                          SizedBox(height: height * buttonBottomMargin),
                        ],
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

  Widget _buildButtonConfimation() {
    return GlobalButton(
      isButtonLoading: isButtonLoading,
      title: 'Masuk',
      onTapFunc: () async {
        context.read<GuestModeBloc>().add(SetGuestModeToInitial());

        setState(() {
          isEmailValid = true;
          isPasswordCorrect = true;
          isButtonLoading = true;
        });

        bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        ).hasMatch(
          emailController.text.trim(),
        );

        if (emailController.text.trim() != '') {
          if (!emailValid) {
            setState(() {
              isEmailValid = false;
            });

            Flushbar(
              duration: Duration(seconds: 2),
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: flushColor,
              message: 'Email tidak valid',
              animationDuration: Duration(milliseconds: flushAnimationDuration),
            )..show(context).then((value) {
                setState(() {
                  isButtonLoading = false;
                });
              });
          } else if (passwordController.text.length < 8) {
            setState(() {
              isPasswordCorrect = false;
            });

            Flushbar(
              duration: Duration(seconds: 2),
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: flushColor,
              message: 'Pastikan passwordmu 8 digit',
              animationDuration: Duration(milliseconds: flushAnimationDuration),
            )..show(context).then((value) {
                setState(() {
                  isButtonLoading = false;
                });
              });
          } else {
            setState(() {
              isEmailValid = true;
              isPasswordCorrect = true;
              isButtonLoading = true;
            });

            QuerySnapshot snapshot = await emailCheck
                .where('email', isEqualTo: emailController.text.trim())
                .get();

            var document = snapshot.docs;

            List<String?> listEmail = [];

            for (var doc in document) {
              listEmail.add(doc['email']);
            }

            setState(() {
              emailChecked = listEmail.join().trim();
            });

            print("--${emailController.text.trim()}--");
            print(emailChecked);

            if ('${emailController.text.trim()}' != emailChecked ||
                emailChecked == null) {
              setState(() {
                isEmailValid = false;
              });

              Flushbar(
                duration: Duration(seconds: 2),
                flushbarPosition: FlushbarPosition.TOP,
                backgroundColor: flushColor,
                animationDuration: Duration(
                  milliseconds: flushAnimationDuration,
                ),
                message:
                    'Email belum terdaftar, silahkan daftar terlebih dahulu',
              )..show(context).then((value) {
                  setState(() {
                    isButtonLoading = false;
                  });
                });
            } else {
              await AuthServices.signInWithEmail(
                email: emailController.text.trim(),
                password: passwordController.text,
              ).then((SignInSignUpResult result) {
                print('erornya: ${result.message}');

                if ('${result.message}' ==
                    '[firebase_auth/wrong-password] The password is invalid or the user does not have a password.') {
                  setState(() {
                    isPasswordCorrect = false;
                  });

                  Flushbar(
                    duration: Duration(seconds: 2),
                    flushbarPosition: FlushbarPosition.TOP,
                    backgroundColor: flushColor,
                    animationDuration: Duration(
                      milliseconds: flushAnimationDuration,
                    ),
                    message: 'Password yang kamu masukkan salah',
                  )..show(context).then((value) {
                      setState(() {
                        isButtonLoading = false;
                      });
                    });
                } else if (result.message == 'terjadi kesalahan') {
                  Flushbar(
                    duration: Duration(seconds: 2),
                    flushbarPosition: FlushbarPosition.TOP,
                    backgroundColor: flushColor,
                    animationDuration: Duration(
                      milliseconds: flushAnimationDuration,
                    ),
                    message: 'Terjadi kesalahan, silakan coba lagi',
                  )..show(context).then((value) {
                      setState(() {
                        isButtonLoading = false;
                      });
                    });
                }
              });
            }
          }
        } else {
          Flushbar(
            duration: Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: flushColor,
            message: 'Isi email dan password terlebih dahulu',
            animationDuration: Duration(
              milliseconds: flushAnimationDuration,
            ),
          )..show(context).then((value) {
              setState(() {
                isButtonLoading = false;
              });
            });
        }
      },
    );
  }
}
