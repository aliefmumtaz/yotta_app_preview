part of 'pages.dart';

class EditProfilePage extends StatefulWidget {
  final String? name;
  final String? nickName;
  final String? email;
  final String? city;
  final String? selectedDate;
  final String? phoneNumber;

  EditProfilePage({
    this.city,
    this.email,
    this.name,
    this.nickName,
    this.selectedDate,
    this.phoneNumber,
  });

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  void _backPrevPage() async {
    // context.read<PageBloc>().add(GoToHomePage(2));
    context.read<PageBloc>().add(GoToAccountPage());
  }

  String? selectedCity = '';
  String? selectedDate = '';
  DateTime selectDate = DateTime.now();
  var _nameController = TextEditingController();
  var _nickNameController = TextEditingController();
  var _emailController = TextEditingController();
  var _phoneNumberController = TextEditingController();

  bool isfullNameMaxChar = false;
  bool isNicknameMaxChar = false;
  bool isPhoneNumberMax = false;
  bool isButtonClicked = false;

  @override
  void initState() {
    _nameController.text = widget.name!;
    _nickNameController.text = widget.nickName!;
    _emailController.text = widget.email!;
    _phoneNumberController.text = widget.phoneNumber!;
    selectedCity = widget.city;
    selectedDate = widget.selectedDate;
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nickNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: WillPopScope(
        onWillPop: () async {
          _backPrevPage();

          return false;
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: defaultMargin),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BackButtonWidget(
                    title: true,
                    onTapFunc: () async => _backPrevPage(),
                  ),
                  SizedBox(height: height * verticalMargin),
                  AutoSizeText(
                    'Edit Profil',
                    style: mainFontBlackBold.copyWith(
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: height * verticalMarginHalf),
                  _buildButtonTitle('Nama Lengkap'),
                  GlobalTextField(
                    controller: _nameController,
                    hintText: 'Nama Lengkap',
                    isWordCapitalization: true,
                    inputColor: (isfullNameMaxChar)
                        ? ThemeColor.errorColor
                        : ThemeColor.mainColor,
                    borderColor: (isfullNameMaxChar)
                        ? ThemeColor.errorColor
                        : ThemeColor.mainColor,
                    maxChar: 40,
                    onChange: (text) {
                      if (text.length == 40) {
                        setState(() {
                          isfullNameMaxChar = true;
                        });
                      } else {
                        setState(() {
                          isfullNameMaxChar = false;
                        });
                      }
                    },
                  ),
                  if (isfullNameMaxChar)
                    SizedBox(height: height * (verticalMarginHalf / 2)),
                  if (isfullNameMaxChar)
                    AutoSizeText(
                      'Nama lengkap maksimal terdiri dari 40 karakter',
                      maxLines: 3,
                      minFontSize: 6,
                      style: accentFontBlackRegular.copyWith(
                        fontSize: 12,
                        color: ThemeColor.errorColor,
                      ),
                    ),
                  SizedBox(height: height * verticalMarginHalf),
                  _buildButtonTitle('Nama Panggilan'),
                  GlobalTextField(
                    controller: _nickNameController,
                    hintText: 'Nama Panggilan',
                    isWordCapitalization: true,
                    inputColor: (isNicknameMaxChar)
                        ? ThemeColor.errorColor
                        : ThemeColor.mainColor,
                    borderColor: (isNicknameMaxChar)
                        ? ThemeColor.errorColor
                        : ThemeColor.mainColor,
                    maxChar: 12,
                    onChange: (text) {
                      if (text.length == 12) {
                        setState(() {
                          isNicknameMaxChar = true;
                        });
                      } else {
                        setState(() {
                          isNicknameMaxChar = false;
                        });
                      }
                    },
                  ),
                  SizedBox(height: height * verticalMarginHalf),
                  _buildButtonTitle('Nomor Telepon'),
                  GlobalTextField(
                    controller: _phoneNumberController,
                    hintText: 'Nomor Telepon',
                    textInputType: TextInputType.number,
                    isWordCapitalization: true,
                    inputColor: (isPhoneNumberMax)
                        ? ThemeColor.errorColor
                        : ThemeColor.mainColor,
                    borderColor: (isPhoneNumberMax)
                        ? ThemeColor.errorColor
                        : ThemeColor.mainColor,
                    maxChar: 15,
                    onChange: (text) {
                      if (text.length == 15) {
                        setState(() {
                          isPhoneNumberMax = true;
                        });
                      } else {
                        setState(() {
                          isPhoneNumberMax = false;
                        });
                      }
                    },
                  ),
                  if (isNicknameMaxChar)
                    SizedBox(height: height * (verticalMarginHalf / 2)),
                  if (isNicknameMaxChar)
                    AutoSizeText(
                      'Nama panggilan maksimal terdiri dari 12 karakter',
                      maxLines: 3,
                      minFontSize: 6,
                      style: accentFontBlackRegular.copyWith(
                        fontSize: 12,
                        color: ThemeColor.errorColor,
                      ),
                    ),
                  SizedBox(height: height * verticalMarginHalf),
                  // _buildButtonTitle('Email'),
                  // GlobalTextField(
                  //   controller: _emailController,
                  //   hintText: 'Email',
                  // ),
                  // SizedBox(height: height * verticalMarginHalf),
                  _buildButtonTitle('Kota'),
                  _buildSelectCity(),
                  // FIXME: hapus saat mau deploy, ini hanya testing
                  // _buildSelectDate(context),
                  SizedBox(height: height * verticalMarginHalf),
                  _buildButtonTitle('Tanggal Lahir'),
                  AutoSizeText(
                    widget.selectedDate!,
                    style: mainFontBlackBold.copyWith(
                      fontSize: 18,
                      color: ThemeColor.accentColor4,
                    ),
                  ),
                  SizedBox(height: height * verticalMarginHalf),
                  _buildButtonTitle('Email'),
                  AutoSizeText(
                    widget.email!,
                    style: mainFontBlackBold.copyWith(
                      fontSize: 18,
                      color: ThemeColor.accentColor4,
                    ),
                  ),
                  Spacer(),
                  _buildButtonConfirmation(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonTitle(String name) {
    var height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        AutoSizeText(
          name,
          style: accentFontBlackRegular.copyWith(
            fontSize: 12,
            color: ThemeColor.accentColor4,
          ),
        ),
        SizedBox(height: height * verticalMarginHalf / 2),
      ],
    );
  }

  Widget _buildSelectCity() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ThemeColor.accentColor2,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height * verticalMarginHalf,
                  ),
                  Icon(
                    Icons.arrow_drop_up,
                    color: ThemeColor.blackTextColor,
                  ),
                  _buildListCity(),
                  Icon(
                    Icons.arrow_drop_down,
                    color: ThemeColor.blackTextColor,
                  ),
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height * verticalMarginHalf,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.only(left: defaultMargin / 2),
        height: MediaQuery.of(context).size.height * .07,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: ThemeColor.mainColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            (selectedCity == '') ? 'Pilih Kota' : selectedCity!,
            style: mainFontBlackBold.copyWith(
              fontSize: 18,
              color: (selectedCity == '')
                  ? ThemeColor.accentColor4
                  : ThemeColor.mainColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildListCity() {
    return BlocBuilder<ListCityForRegistrationBloc,
        ListCityForRegistrationState>(
      builder: (context, cityState) => Container(
        height: MediaQuery.of(context).size.height * .25,
        child: Stack(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: cityState.cityForRegistration.toList().length,
              itemBuilder: (_, index) {
                var cityList = cityState.cityForRegistration.toList()[index];
                var cityListLength =
                    cityState.cityForRegistration.toList().length;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedCity = cityList.name;
                    });

                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        margin:
                            EdgeInsets.symmetric(horizontal: defaultMargin * 2),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: (index == cityListLength - 1)
                              ? null
                              : Border(
                                  bottom: BorderSide(
                                    color: ThemeColor.blackTextColor,
                                    width: 0.4,
                                  ),
                                ),
                        ),
                        child: Center(
                          child: Text(
                            cityList.name!,
                            style: mainFontBlackBold.copyWith(
                              fontSize: 18,
                              color: ThemeColor.blackTextColor,
                            ),
                          ),
                        ),
                      ),
                      (index == cityListLength - 1)
                          ? SizedBox()
                          : SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  verticalMarginHalf /
                                  2,
                            ),
                    ],
                  ),
                );
              },
            ),
            Container(
              height: MediaQuery.of(context).size.height * .015,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    ThemeColor.accentColor2.withOpacity(0),
                    ThemeColor.accentColor2,
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * .015,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      ThemeColor.accentColor2,
                      ThemeColor.accentColor2.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectDate(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => _selectBirthdayDate(),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12),
        height: MediaQuery.of(context).size.height * textFieldHeight,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ThemeColor.mainColor),
        ),
        // child: Text(selectDate.toString().split(' ')[0]),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            (selectedDate == '') ? 'Pilih Tanggal Lahir' : selectedDate!,
            style: mainFontBlackBold.copyWith(
              fontSize: 18,
              color: (selectedDate == '')
                  ? ThemeColor.accentColor4
                  : ThemeColor.mainColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _selectBirthdayDate() {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: ThemeColor.accentColor2,
        ),
        child: ListView(
          shrinkWrap: true,
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .35,
                  child: CupertinoDatePicker(
                    initialDateTime: selectDate,
                    maximumYear: 2025,
                    minimumYear: 1950,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (dateTime) {
                      // print(dateTime);
                      setState(() {
                        selectDate = dateTime;
                      });
                    },
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDate = selectDate.dateTime;
                    });

                    Navigator.pop(context);
                  },
                  child: Container(
                    height: MediaQuery.of(context).size.height * .05,
                    decoration: BoxDecoration(
                      border: Border.all(color: ThemeColor.mainColor),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    margin: EdgeInsets.fromLTRB(
                      defaultMargin,
                      0,
                      defaultMargin,
                      defaultMargin,
                    ),
                    child: Center(
                      child: Text(
                        'Pilih Tanggal Lahir',
                        style: mainFontBlackBold.copyWith(
                          fontSize: 18,
                          color: ThemeColor.mainColor,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtonConfirmation() {
    var height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) {
            if (userState is UserLoaded) {
              var user = userState.user;

              return GlobalButton(
                isButtonLoading: isButtonClicked,
                title: 'Simpan',
                onTapFunc: () async {
                  bool emailValid = RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
                  ).hasMatch(
                    _emailController.text,
                  );

                  if (!(_nameController.text.trim() != '' &&
                      _nickNameController.text.trim() != '' &&
                      _emailController.text.trim() != '' &&
                      selectedCity != '' &&
                      _phoneNumberController.text.trim() != '' &&
                      selectedDate != '')) {
                    Flushbar(
                      duration: Duration(seconds: 2),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: flushColor,
                      animationDuration:
                          Duration(milliseconds: flushAnimationDuration),
                      message: 'Isi semua form terlebih dahulu',
                    )..show(context);
                  } else if (_nameController.text.length == 40) {
                    Flushbar(
                      duration: Duration(seconds: 2),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: flushColor,
                      animationDuration:
                          Duration(milliseconds: flushAnimationDuration),
                      message: 'Nama lengkap maksimal terdiri dari 40 karakter',
                    )..show(context);
                  } else if (_nickNameController.text.length == 12) {
                    Flushbar(
                      duration: Duration(seconds: 2),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: flushColor,
                      animationDuration:
                          Duration(milliseconds: flushAnimationDuration),
                      message:
                          'Nama panggilan maksimal terdiri dari 12 karakter',
                    )..show(context);
                  } else if (_phoneNumberController.text.length < 10) {
                    Flushbar(
                      duration: Duration(seconds: 2),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: flushColor,
                      animationDuration:
                          Duration(milliseconds: flushAnimationDuration),
                      message: 'Nomor telepon harus diatas 10 digit',
                    )..show(context);
                  } else if (!emailValid) {
                    Flushbar(
                      duration: Duration(seconds: 2),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: flushColor,
                      animationDuration:
                          Duration(milliseconds: flushAnimationDuration),
                      message: 'Masukkan email yang valid',
                    )..show(context);
                  } else if (user.name == _nameController.text &&
                      user.nickName == _nickNameController.text &&
                      user.email == _emailController.text &&
                      user.city == selectedCity &&
                      user.birthday == selectedDate &&
                      user.phoneNumber == _phoneNumberController.text) {
                    _backPrevPage();
                  } else {
                    showDialog(
                      context: context,
                      builder: (_) => AlertBoxWidget(
                        boxTitle: 'Simpan perubahan profil?',
                        isRightCTA: true,
                        onTapTopButton: () async {
                          setState(() {
                            isButtonClicked = true;
                          });

                          Navigator.pop(context);

                          await UserServices.editUserProfile(
                            userState.user.uid,
                            name: _nameController.text,
                            nickName: _nickNameController.text,
                            email: _emailController.text,
                            city: selectedCity,
                            date: selectedDate,
                            idMember: userState.user.idMember,
                            phoneNumber: _phoneNumberController.text.trim(),
                          );

                          context.read<UserBloc>().add(
                                LoadUser(user.uid),
                              );

                          _backPrevPage();
                        },
                        onTapBottomButton: () {
                          Navigator.pop(context);
                        },
                      ),
                    );
                  }
                },
              );
            } else {
              return SizedBox();
            }
          },
        ),
        SizedBox(height: height * buttonBottomMargin),
      ],
    );
  }
}
