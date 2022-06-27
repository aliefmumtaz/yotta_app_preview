part of 'pages.dart';

class ChooseMemberStatusPage extends StatefulWidget {
  final List<String> buttonName = ['Sudah', 'Belum'];

  @override
  _ChooseMemberStatusPageState createState() => _ChooseMemberStatusPageState();
}

class _ChooseMemberStatusPageState extends State<ChooseMemberStatusPage> {
  String? selectedButton;

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;

    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToSplashPage());

        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BackButtonWidget(
                  name: 'Pilih Status Membership',
                  onTapFunc: () async {
                    context.read<PageBloc>().add(GoToSplashPage());
                  },
                ),
                Container(
                  height: height * 0.3,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/choose_membership.png'),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: defaultMargin),
                  child: AutoSizeText(
                    'Sudah menjadi\nmember Yotta?',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: mainFontBlackBold.copyWith(
                      fontSize: 24,
                    ),
                  ),
                ),
                Column(
                  children: [
                    // generateSelectMemberButtonn(),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: generateMemberButton(),
                      ),
                    ),
                    SizedBox(
                      height: height * verticalMargin,
                    ),
                    _buildButton(),
                    SizedBox(
                      height: height * buttonBottomMargin,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButton() {
    return GlobalButton(
      title: 'Lanjutkan',
      onTapFunc: () {
        if (selectedButton == 'Belum') {
          context.read<ListCityForRegistrationBloc>().add(GetCityList());

          context.read<PageBloc>().add(
                GoToRegistrationPage(
                  RegistrationData(),
                  DataForRegisteredIdMember(),
                  false,
                ),
              );
        } else if (selectedButton == 'Sudah') {
          context.read<PageBloc>().add(
                GoToInputMemberIdPage(
                  DataForRegisteredIdMember(),
                ),
              );
        }
      },
    );
  }

  List<Widget> generateMemberButton() {
    return widget.buttonName
        .map(
          (e) => GlobalButton(
            height: 0.12,
            width: 1 / 2 - 0.090,
            isBorder: selectedButton == e,
            gradient1: ThemeColor.accentColor3,
            gradient2: ThemeColor.accentColor2,
            borderColor: ThemeColor.accentColor3,
            textColor: ThemeColor.accentColor3,
            onTapFunc: () {
              setState(() {
                selectedButton = e;
              });
            },
            title: e,
          ),
        )
        .toList();
  }
}
