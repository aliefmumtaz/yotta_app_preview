part of 'pages.dart';

class ResetPasswordPage extends StatefulWidget {
  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  var emailController = TextEditingController();
  bool isEmailValid = true;
  bool isButtonLoading = false;
  bool isEmailAvailable = true;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);

        return false;
      },
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackButtonWidget(
                    name: 'Reset Kata Sandi',
                    onTapFunc: () async {
                      Navigator.pop(context);
                    },
                  ),
                  SizedBox(height: height * (verticalMargin * 2)),
                  Container(
                    height: height * 0.2,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/3d_logo.png',
                        ),
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  SizedBox(height: height * (verticalMargin * 2)),
                  GlobalTextField(
                    controller: emailController,
                    isAutofillHints: true,
                    hintText: 'Email',
                    inputColor: (!isEmailValid || !isEmailAvailable)
                        ? ThemeColor.errorColor
                        : ThemeColor.mainColor,
                    borderColor: (!isEmailValid || !isEmailAvailable)
                        ? ThemeColor.errorColor
                        : ThemeColor.mainColor,
                  ),
                  if (!isEmailValid)
                    SizedBox(height: height * (verticalMarginHalf / 2)),
                  if (!isEmailValid)
                    AutoSizeText(
                      'Email tidak valid',
                      maxLines: 3,
                      minFontSize: 6,
                      style: accentFontBlackRegular.copyWith(
                        fontSize: 12,
                        color: ThemeColor.errorColor,
                      ),
                    ),
                  if (!isEmailAvailable)
                    SizedBox(height: height * (verticalMarginHalf / 2)),
                  if (!isEmailAvailable)
                    AutoSizeText(
                      'Email belum terdaftar sebagai member',
                      maxLines: 3,
                      minFontSize: 6,
                      style: accentFontBlackRegular.copyWith(
                        fontSize: 12,
                        color: ThemeColor.errorColor,
                      ),
                    ),
                  SizedBox(height: height * verticalMargin),
                  AutoSizeText(
                    'Masukkan email kamu untuk mendapatkan link perubahan kata sandi baru.\nJangan sampai lupa lagi ya',
                    maxLines: 3,
                    minFontSize: 6,
                    style: accentFontBlackRegular.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  Spacer(),
                  GlobalButton(
                    isButtonLoading: isButtonLoading,
                    title: 'Kirim Tautan',
                    onTapFunc: () async {
                      onPressedSendLink();
                    },
                  ),
                  SizedBox(height: height * buttonBottomMargin),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onPressedSendLink() async {
    bool emailValid = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(
      emailController.text,
    );

    setState(() {
      isEmailValid = true;
      isEmailAvailable = true;
    });

    if (emailController.text != '') {
      if (!emailValid) {
        setState(() {
          isEmailValid = false;
        });
      } else {
        setState(() {
          isButtonLoading = true;
        });
        await AuthServices.resetPassowrd(emailController.text.trim()).then(
          (String value) {
            if (value == 'Sukses') {
              Navigator.pop(context);
            } else {
              setState(() {
                isEmailAvailable = false;
                isButtonLoading = false;
              });
            }
          },
        );
      }
    }
  }
}
