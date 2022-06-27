part of 'pages.dart';

class RegistrationPage extends StatefulWidget {
  final List<String> genderList = ['Laki-laki', 'Perempuan'];
  final RegistrationData registrationData;
  final DataForRegisteredIdMember registeredMemberData;
  final bool isIdRegistered;

  RegistrationPage(
    this.registrationData,
    this.registeredMemberData,
    this.isIdRegistered,
  );

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  String? selectedGender = 'kosong';
  String? selectedCity;
  bool isPasswordCorrect = true;
  bool isPasswordSame = true;
  bool isEmailValid = true;
  bool isPhoneNumberValid = true;
  bool isButtonLoading = false;
  bool isPhoneNumberRegistered = false;
  bool isEmailRegistered = false;
  bool isfullNameMaxChar = false;
  bool isNicknameMaxChar = false;

  DateTime selectDate = DateTime.now();
  String? selectedDate = '';

  List<Widget> _generateChooseGender() {
    return widget.genderList
        .map(
          (e) => GlobalButton(
            isBorder: selectedGender == e,
            title: e,
            width: 1 / 2 - 0.085,
            onTapFunc: () {
              setState(() {
                selectedGender = e;
              });
            },
          ),
        )
        .toList();
  }

  CollectionReference _userEmailCheck =
      FirebaseFirestore.instance.collection('user');
  String? _emailChecked;
  String? _phoneNumberChecked;
  String? _idMemberChecked;

  bool isDateSelected = false;

  @override
  void initState() {
    phoneNumberController.text = widget.registeredMemberData.phoneNumber;
    nameController.text = widget.registeredMemberData.name;
    emailController.text = widget.registeredMemberData.email.trim();
    selectedDate = widget.registeredMemberData.birthday;
    selectedGender = widget.registeredMemberData.gender;
    selectedCity = widget.registeredMemberData.city;
    super.initState();
  }

  var phoneNumberController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var nickNameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  void dispose() {
    phoneNumberController.dispose();
    nameController.dispose();
    emailController.dispose();
    nickNameController.dispose();
    passwordController.dispose();
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
          context.read<PageBloc>().add(GoToSplashPage());

          context.read<IdMemberDataBloc>().add(InitialDataEvent());

          return false;
        },
        child: Scaffold(
          // resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BackButtonWidget(
                        name: 'Daftar',
                        onTapFunc: () async {
                          context.read<PageBloc>().add(GoToSplashPage());

                          context.read<IdMemberDataBloc>().add(
                                InitialDataEvent(),
                              );
                        },
                      ),
                      SizedBox(height: height * verticalMargin),
                      AutoSizeText(
                        'Registrasi Member Yotta',
                        style: mainFontBlackBold.copyWith(fontSize: 24),
                      ),
                      SizedBox(height: height * verticalMargin),
                      GlobalTextField(
                        controller: nameController,
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
                      GlobalTextField(
                        controller: nickNameController,
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
                      GlobalTextField(
                        controller: emailController,
                        hintText: 'Email',
                        inputColor: (!isEmailValid)
                            ? ThemeColor.errorColor
                            : ThemeColor.mainColor,
                        borderColor: (!isEmailValid)
                            ? ThemeColor.errorColor
                            : ThemeColor.mainColor,
                      ),
                      if (isEmailRegistered)
                        SizedBox(height: height * (verticalMarginHalf / 2)),
                      if (isEmailRegistered)
                        AutoSizeText(
                          'Email sudah terdaftar sebagai member',
                          maxLines: 3,
                          minFontSize: 6,
                          style: accentFontBlackRegular.copyWith(
                            fontSize: 12,
                            color: ThemeColor.errorColor,
                          ),
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
                      SizedBox(height: height * (verticalMarginHalf / 2)),
                      AutoSizeText(
                        'Masukkan email aktif untuk verifikasi selanjutnya',
                        maxLines: 3,
                        minFontSize: 6,
                        style: accentFontBlackRegular.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: height * verticalMarginHalf),
                      GlobalTextField(
                        controller: passwordController,
                        hintText: 'Masukkan Kata Sandi',
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
                        obsecureText: true,
                        onChange: (text) {
                          if (text.length < 8) {
                            setState(() {
                              isPasswordCorrect = false;
                            });
                          } else {
                            setState(() {
                              isPasswordCorrect = true;
                            });
                          }
                        },
                      ),
                      if (!isPasswordCorrect)
                        SizedBox(height: height * (verticalMarginHalf / 2)),
                      if (!isPasswordCorrect)
                        AutoSizeText(
                          'Kata sandi minimal terdiri dari 8 karakter',
                          maxLines: 3,
                          minFontSize: 6,
                          style: accentFontBlackRegular.copyWith(
                            fontSize: 12,
                            color: ThemeColor.errorColor,
                          ),
                        ),
                      SizedBox(height: height * verticalMarginHalf),
                      GlobalTextField(
                        controller: phoneNumberController,
                        textInputType: TextInputType.number,
                        hintText: 'Nomor Handphone',
                        inputColor: (!isPhoneNumberValid)
                            ? ThemeColor.errorColor
                            : ThemeColor.mainColor,
                        borderColor: (!isPhoneNumberValid)
                            ? ThemeColor.errorColor
                            : ThemeColor.mainColor,
                      ),
                      if (isPhoneNumberRegistered)
                        SizedBox(height: height * (verticalMarginHalf / 2)),
                      if (isPhoneNumberRegistered)
                        AutoSizeText(
                          'Nomor handphone sudah terdaftar sebagai member',
                          maxLines: 3,
                          minFontSize: 6,
                          style: accentFontBlackRegular.copyWith(
                            fontSize: 12,
                            color: ThemeColor.errorColor,
                          ),
                        ),
                      if (!isPhoneNumberRegistered)
                        SizedBox(height: height * (verticalMarginHalf / 2)),
                      if (!isPhoneNumberValid)
                        AutoSizeText(
                          'Nomor handphone tidak valid',
                          maxLines: 3,
                          minFontSize: 6,
                          style: accentFontBlackRegular.copyWith(
                            fontSize: 12,
                            color: ThemeColor.errorColor,
                          ),
                        ),
                      SizedBox(height: height * (verticalMarginHalf / 2)),
                      AutoSizeText(
                        'Masukkan nomor handphone aktif untuk kemudahan pemesanan',
                        maxLines: 3,
                        minFontSize: 6,
                        style: accentFontBlackRegular.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: height * verticalMarginHalf),
                      _buildSelectCity(),
                      SizedBox(height: height * verticalMarginHalf),
                      Text(
                        'Gender - optional',
                        style: accentFontBlackRegular.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      SizedBox(height: height * verticalMarginHalf),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _generateChooseGender(),
                      ),
                      SizedBox(height: height * verticalMarginHalf),
                      _buildSelectDate(context),
                      SizedBox(height: height * verticalMargin),
                      _buildButtonConfirmation(),
                      SizedBox(height: height * buttonBottomMargin),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonConfirmation() {
    return GlobalButton(
      isButtonLoading: isButtonLoading,
      title: 'Lanjutkan',
      onTapFunc: () async {
        print("--${emailController.text.trim()}--");

        context.read<GuestModeBloc>().add(SetGuestModeToInitial());

        bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
        ).hasMatch(
          emailController.text.trim(),
        );

        if (!(nameController.text.trim() != '' &&
            emailController.text.trim() != '' &&
            phoneNumberController.text.trim() != '' &&
            passwordController.text != '' &&
            nickNameController.text != '')) {
          Flushbar(
            duration: Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: flushColor,
            animationDuration: Duration(milliseconds: flushAnimationDuration),
            message: 'Isi semua form terlebih dahulu',
          )..show(context);
        } else if (nameController.text.length == 40) {
          Flushbar(
            duration: Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: flushColor,
            animationDuration: Duration(milliseconds: flushAnimationDuration),
            message: 'Nama lengkap maksimal terdiri dari 40 karakter',
          )..show(context);
        } else if (nickNameController.text.length == 12) {
          Flushbar(
            duration: Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: flushColor,
            animationDuration: Duration(milliseconds: flushAnimationDuration),
            message: 'Nama panggilan maksimal terdiri dari 12 karakter',
          )..show(context);
        } else if (!emailValid &&
            (phoneNumberController.text.length < 10 ||
                phoneNumberController.text.length > 20)) {
          setState(() {
            isEmailValid = false;
            isPhoneNumberValid = false;
          });
        } else if (passwordController.text.length < 8) {
          setState(() {
            isPhoneNumberValid = false;
            isEmailValid = true;
          });
          Flushbar(
            duration: Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: flushColor,
            animationDuration: Duration(milliseconds: flushAnimationDuration),
            message: 'Password minimal harus 8 karakter',
          )..show(context);
        } else if (!emailValid) {
          Flushbar(
            duration: Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: flushColor,
            animationDuration: Duration(milliseconds: flushAnimationDuration),
            message: 'Masukkan email yang valid',
          )..show(context);

          setState(() {
            isEmailValid = false;
            isPhoneNumberValid = true;
          });
        } else if (phoneNumberController.text.length < 10) {
          setState(() {
            isPhoneNumberValid = false;
            isEmailValid = true;
          });

          Flushbar(
            duration: Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: flushColor,
            animationDuration: Duration(milliseconds: flushAnimationDuration),
            message: 'Masukkan nomor handphone yang valid',
          )..show(context);
        } else if (phoneNumberController.text.length > 20) {
          setState(() {
            isPhoneNumberValid = false;
          });

          Flushbar(
            duration: Duration(seconds: 2),
            flushbarPosition: FlushbarPosition.TOP,
            backgroundColor: flushColor,
            animationDuration: Duration(milliseconds: flushAnimationDuration),
            message: 'Yah, nomor telepon-nya kepanjangan!',
          )..show(context);
        } else {
          setState(() {
            isEmailValid = true;
            isPhoneNumberValid = true;
            isPasswordSame = true;
            isButtonLoading = true;
            isPhoneNumberRegistered = false;
            isEmailRegistered = false;
          });

          // check for registered email
          QuerySnapshot snapshot = await _userEmailCheck
              .where('email', isEqualTo: emailController.text.trim())
              .get();

          var document = snapshot.docs;

          List<String?> listEmail = [];

          for (var doc in document) {
            listEmail.add(doc['email']);
          }

          setState(() {
            _emailChecked = listEmail.join().trim();
          });

          print(_emailChecked);
          print('${emailController.text.trim()}');

          // check for registered phone number
          QuerySnapshot snapshotPhoneNumber = await _userEmailCheck
              .where('nomor handphone', isEqualTo: phoneNumberController.text)
              .get();

          var documentPhoneNumber = snapshotPhoneNumber.docs;

          List<String?> listPhoneNumber = [];

          for (var doc in documentPhoneNumber) {
            listPhoneNumber.add(doc['nomor handphone']);
          }

          setState(() {
            _phoneNumberChecked = listPhoneNumber.join().trim();
          });

          print(_phoneNumberChecked);
          print('${phoneNumberController.text}');

          // check for registered id member
          if (widget.isIdRegistered) {
            QuerySnapshot snapshotIdMember = await _userEmailCheck
                .where('id member',
                    isEqualTo: widget.registeredMemberData.idMember)
                .get();

            var documentIdMember = snapshotIdMember.docs;

            List<String?> listIdMember = [];

            for (var doc in documentIdMember) {
              listIdMember.add(doc['id member']);
            }

            setState(() {
              _idMemberChecked = listIdMember.join().trim();
            });

            print(_idMemberChecked);
            print('${widget.registeredMemberData.idMember}');
          }

          if ('${emailController.text.trim()}' == _emailChecked) {
            setState(() {
              isEmailRegistered = true;
            });

            Flushbar(
              duration: Duration(seconds: 2),
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: flushColor,
              animationDuration: Duration(milliseconds: 800),
              message: 'Email sudah terdaftar sebagai member',
            )..show(context).then((value) {
                setState(() {
                  isButtonLoading = false;
                });
              });
          } else if ('${phoneNumberController.text.trim()}' ==
              _phoneNumberChecked) {
            setState(() {
              isPhoneNumberRegistered = true;
            });

            Flushbar(
              duration: Duration(seconds: 2),
              flushbarPosition: FlushbarPosition.TOP,
              backgroundColor: flushColor,
              animationDuration: Duration(milliseconds: 800),
              message: 'Nomor handphone sudah terdaftar sebagai member',
            )..show(context).then((value) {
                setState(() {
                  isButtonLoading = false;
                });
              });
          } else {
            setState(() {
              isEmailValid = true;
            });

            if (widget.isIdRegistered == false) {
              print('benar');
              widget.registrationData.name = nameController.text;
              widget.registrationData.email = emailController.text.trim();
              widget.registrationData.phoneNumber =
                  '${phoneNumberController.text}';
              widget.registrationData.city = selectedCity;
              widget.registrationData.gender =
                  selectedGender == 'kosong' ? '' : selectedGender;
              widget.registrationData.birthday =
                  selectedDate == '' ? '' : selectedDate;
              widget.registrationData.nickName = nickNameController.text;

              context.read<PasswordTempBloc>().add(
                    SetPasswordTemp(passwordController.text),
                  );

              await AuthServices.signUpWithEmail(
                password: passwordController.text,
                name: nameController.text,
                phoneNumber: '${phoneNumberController.text}',
                email: emailController.text,
                city: selectedCity,
                gender: selectedGender,
                birthday: selectedDate,
                nickName: nickNameController.text,
                isUserRegistered: false,
                yPoin: 0,
                isEmailVerified: false,
              ).then((ApiReturnValue value) {
                if (value.message == 'Email sudah terdaftar' ||
                    value.message == 'nomor telepon sudah terdaftar') {
                  Flushbar(
                    duration: Duration(seconds: 2),
                    flushbarPosition: FlushbarPosition.TOP,
                    backgroundColor: flushColor,
                    animationDuration: Duration(milliseconds: 800),
                    message: 'Email atau nomor telepon sudah terdaftar',
                  )..show(context);

                  setState(() {
                    isButtonLoading = false;
                  });
                } else if (value.message == 'id member sudah terdaftar' ||
                    value.message == 'Id member sama' ||
                    value.message == 'Gagal Menyimpan, Coba Lagi') {
                  Flushbar(
                    duration: Duration(seconds: 2),
                    flushbarPosition: FlushbarPosition.TOP,
                    backgroundColor: flushColor,
                    animationDuration: Duration(milliseconds: 800),
                    message: 'Id member sudah terdaftar',
                  )..show(context);

                  setState(() {
                    isButtonLoading = false;
                  });
                }
              });
            } else if (widget.isIdRegistered == true) {
              if (_idMemberChecked != widget.registeredMemberData.idMember) {
                widget.registeredMemberData.name = nameController.text;
                widget.registeredMemberData.email = emailController.text.trim();
                widget.registeredMemberData.phoneNumber =
                    '${phoneNumberController.text}';
                widget.registeredMemberData.city = selectedCity;
                widget.registeredMemberData.gender = selectedGender;
                widget.registeredMemberData.birthday = selectedDate;
                widget.registeredMemberData.nickName = nickNameController.text;
                widget.registeredMemberData.nickName = nickNameController.text;

                context.read<PasswordTempBloc>().add(
                      SetPasswordTemp(passwordController.text),
                    );

                await AuthServices.signUpWithEmail(
                  password: passwordController.text,
                  name: nameController.text,
                  phoneNumber: '${phoneNumberController.text}',
                  email: emailController.text.trim(),
                  city: selectedCity,
                  gender: selectedGender,
                  birthday: selectedDate,
                  nickName: nickNameController.text,
                  isUserRegistered: true,
                  yPoin: widget.registeredMemberData.yPoin,
                  registeredIdMember: widget.registeredMemberData.idMember,
                  isEmailVerified: false,
                ).then((ApiReturnValue value) {
                  if (value.message == 'Email sudah terdaftar' ||
                      value.message == 'nomor telepon sudah terdaftar') {
                    Flushbar(
                      duration: Duration(seconds: 2),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: flushColor,
                      animationDuration: Duration(milliseconds: 800),
                      message: 'Email atau nomor telepon sudah terdaftar',
                    )..show(context);

                    setState(() {
                      isButtonLoading = false;
                    });
                  } else if (value.message == 'id member sudah terdaftar' ||
                      value.message == 'Id member sama' ||
                      value.message == 'Gagal Menyimpan, Coba Lagi') {
                    Flushbar(
                      duration: Duration(seconds: 2),
                      flushbarPosition: FlushbarPosition.TOP,
                      backgroundColor: flushColor,
                      animationDuration: Duration(milliseconds: 800),
                      message: 'Terjadi gangguan, silahkan coba lagi',
                    )..show(context);

                    setState(() {
                      isButtonLoading = false;
                    });
                  }
                });
              } else {
                Flushbar(
                  duration: Duration(seconds: 2),
                  flushbarPosition: FlushbarPosition.TOP,
                  backgroundColor: flushColor,
                  animationDuration: Duration(
                    milliseconds: flushAnimationDuration,
                  ),
                  message: 'Id member telah terdafar',
                )..show(context).then((value) {
                    setState(() {
                      isButtonLoading = false;
                    });
                  });
              }
            }
          }
        }
      },
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
                  Icon(Icons.arrow_drop_up, color: ThemeColor.blackTextColor),
                  _buildListCity(),
                  Icon(Icons.arrow_drop_down, color: ThemeColor.blackTextColor),
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
        height: MediaQuery.of(context).size.height * textFieldHeight,
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
                    ThemeColor.accentColor2
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
            (selectedDate == '')
                ? 'Pilih Tanggal Lahir (Optional)'
                : selectedDate!,
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
}
