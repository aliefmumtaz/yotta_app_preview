part of 'pages.dart';

class InputMemberIdPage extends StatefulWidget {
  final DataForRegisteredIdMember dataForRegisteredIdMember;

  InputMemberIdPage(this.dataForRegisteredIdMember);

  @override
  _InputMemberIdPageState createState() => _InputMemberIdPageState();
}

class _InputMemberIdPageState extends State<InputMemberIdPage> {
  var _inputMemberIdController = TextEditingController();

  @override
  void dispose() {
    _inputMemberIdController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToChooseMemberStatusPage());

        context.read<IdMemberDataBloc>().add(InitialDataEvent());

        return false;
      },
      child: GestureDetector(
        onTap: () async {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildIdMemberGeneratorWidget(),
                  Spacer(),
                  SizedBox(height: height * verticalMargin * 2),
                  BlocBuilder<IdMemberDataBloc, IdMemberDataState>(
                    builder: (_, memberState) {
                      if (memberState is DataLoaded) {
                        if (memberState.idMemberData.name != '') {
                          return Column(
                            children: [
                              _buildButtonConfirmation(),
                              SizedBox(
                                height: height * buttonBottomMargin,
                              ),
                            ],
                          );
                        } else {
                          return SizedBox();
                        }
                      } else {
                        return SizedBox();
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonSearch() {
    return BlocBuilder<IdMemberDataBloc, IdMemberDataState>(
      builder: (_, memberState) => GestureDetector(
        onTap: () async {
          if (_inputMemberIdController.text == '') {
            Flushbar(
              duration: Duration(seconds: 2),
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: flushColor,
              message: 'Maaf ID member yang kamu input tidak valid',
              animationDuration: Duration(milliseconds: flushAnimationDuration),
            )..show(context);
          } else if (_inputMemberIdController.text.length < 3) {
            Flushbar(
              duration: Duration(seconds: 2),
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: flushColor,
              message: 'Maaf ID member yang kamu input tidak valid',
              animationDuration: Duration(milliseconds: flushAnimationDuration),
            )..show(context);
          } else if (_inputMemberIdController.text.length > 6) {
            Flushbar(
              duration: Duration(seconds: 2),
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: flushColor,
              message: 'Maaf ID member yang kamu input tidak valid',
              animationDuration: Duration(milliseconds: flushAnimationDuration),
            )..show(context);
          } else {
            context.read<IdMemberDataBloc>().add(InitialDataEvent());

            context
                .read<IdMemberDataBloc>()
                .add(GetIdMemberData(_inputMemberIdController.text));
          }
        },
        child: Container(
          margin: EdgeInsets.all(8),
          width: MediaQuery.of(context).size.width * .2,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [ThemeColor.mainColor, ThemeColor.mainColor],
            ),
          ),
          child: Center(
            child: AutoSizeText(
              'Cari',
              style: mainFontWhiteBold.copyWith(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonConfirmation() {
    return BlocBuilder<IdMemberDataBloc, IdMemberDataState>(
      builder: (_, memberState) => GlobalButton(
        title: 'Lanjutkan',
        onTapFunc: () async {
          if (memberState is DataLoaded) {
            if (memberState.idMemberData.name != '') {
              var dataRegis = widget.dataForRegisteredIdMember;
              var dataState = memberState.idMemberData;

              dataRegis.name = dataState.name;
              dataRegis.phoneNumber =
                  (dataState.phoneNumber == '') ? '' : dataState.phoneNumber;
              dataRegis.email = dataState.email;
              dataRegis.city = dataState.city;
              dataRegis.gender = dataState.gender;
              dataRegis.birthday = dataState.birthday;
              dataRegis.yPoin = dataState.yPoin;
              dataRegis.idMember = dataState.idMember;

              context.read<PageBloc>().add(
                    GoToRegistrationPage(
                      RegistrationData(),
                      widget.dataForRegisteredIdMember,
                      true,
                    ),
                  );
            }
          }
        },
      ),
    );
  }

  Widget _buildTextField() {
    return Container(
      height: MediaQuery.of(context).size.height * .07,
      decoration: BoxDecoration(
        border: Border.all(color: ThemeColor.mainColor),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * horizontalMarginHalf,
          ),
          Text(
            'YM-',
            style: mainFontBlackBold.copyWith(fontSize: 18, color: ThemeColor.mainColor),
          ),
          Flexible(
            child: TextField(
              controller: _inputMemberIdController,
              keyboardType: TextInputType.number,
              style: mainFontBlackBold.copyWith(fontSize: 18, color: ThemeColor.mainColor),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintStyle: mainFontBlackBold.copyWith(
                  fontSize: 18,
                  color: ThemeColor.accentColor4,
                ),
                hintText: 'ID Member',
              ),
            ),
          ),
          _buildButtonSearch(),
        ],
      ),
    );
  }

  Widget _buildIdMemberGeneratorWidget() {
    var height = MediaQuery.of(context).size.height;

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BackButtonWidget(
            name: 'Input ID Member',
            onTapFunc: () {
              context.read<PageBloc>().add(GoToChooseMemberStatusPage());

              context.read<IdMemberDataBloc>().add(InitialDataEvent());
            },
          ),
          SizedBox(height: height * verticalMargin * 2),
          Container(
            height: height * .2,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/3d_logo.png'),
                fit: BoxFit.contain,
              ),
            ),
          ),
          SizedBox(height: height * verticalMargin * 2),
          Row(
            children: [
              AutoSizeText(
                'Belum punya akun?',
                style: accentFontBlackRegular.copyWith(
                  color: ThemeColor.accentColor4,
                  fontSize: 14,
                ),
              ),
              Text(' '),
              GestureDetector(
                onTap: () {
                  context.read<PageBloc>().add(
                        GoToRegistrationPage(
                          RegistrationData(),
                          widget.dataForRegisteredIdMember,
                          false,
                        ),
                      );
                },
                child: AutoSizeText(
                  'Daftar Sekarang',
                  style: accentFontBlackRegular.copyWith(
                    color: ThemeColor.mainColor,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: height * verticalMargin),
          Column(
            children: [
              _buildTextField(),
              SizedBox(height: 24),
              BlocBuilder<IdMemberDataBloc, IdMemberDataState>(
                builder: (_, memberState) {
                  if (memberState is DataLoaded) {
                    var idMember = memberState.idMemberData.idMember;
                    var name = memberState.idMemberData.name;
                    var phoneNumber = memberState.idMemberData.phoneNumber;
                    var yPoin = memberState.idMemberData.yPoin;

                    if (name == '') {
                      return Padding(
                        padding: EdgeInsets.only(right: 12),
                        child: AutoSizeText(
                          'Maaf kamu belum jadi member Yotta, daftar dulu, yuk!',
                          maxLines: 2,
                          style: accentFontBlackRegular.copyWith(
                            color: ThemeColor.errorColor,
                            fontSize: 14,
                          ),
                        ),
                      );
                    } else {
                      return CardMember(
                        idMember: (idMember == '') ? '-' : idMember,
                        name: (name == '') ? '-' : name,
                        phoneNumber: (phoneNumber == '') ? '-' : phoneNumber,
                        yPoin: yPoin,
                      );
                    }
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
