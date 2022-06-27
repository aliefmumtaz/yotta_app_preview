part of 'pages.dart';

class SuccessCheckoutPage extends StatefulWidget {
  @override
  _SuccessCheckoutPageState createState() => _SuccessCheckoutPageState();
}

class _SuccessCheckoutPageState extends State<SuccessCheckoutPage> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  SizedBox(height: height * verticalMargin * 2),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: defaultMargin * 2,
                    ),
                    child: AutoSizeText(
                      'Yeay, Pesananmu\nBerhasil!',
                      style: mainFontBlackBold.copyWith(fontSize: 28),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
              Container(
                width: width * .7,
                child: Image.asset(
                  'assets/no_order.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              Column(
                children: [
                  BlocBuilder<UserBloc, UserState>(
                    builder: (_, userState) => GlobalButton(
                      title: 'Kembali Ke Beranda',
                      margin: const EdgeInsets.symmetric(
                        horizontal: defaultMargin,
                      ),
                      onTapFunc: () async {
                        context.read<ChangeStatusOrderBloc>().add(
                              SetNewStatusToInitial(),
                            );

                        context.read<ChangeStatusOrderBloc>().add(
                              SetNewStatusToProcess(),
                            );

                        context.read<CheckoutSelectedOutletLatlngBloc>().add(
                              GetSelectedOutletLatLng(
                                (userState is UserLoaded)
                                    ? userState.user.uid
                                    : '',
                              ),
                            );

                        context.read<PageBloc>().add(GoToHomePage(0));

                        context.read<MenuBloc>().add(MenuToInitial());

                        context.read<AllMenuBloc>().add(AllMenuToInitial());
                      },
                    ),
                  ),
                  SizedBox(height: height * (verticalMargin * 2)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
