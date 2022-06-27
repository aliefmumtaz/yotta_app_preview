part of 'pages.dart';

class DetailPromoPage extends StatefulWidget {
  final Promo promo;
  final bool isClaimed;
  final int userPromoId;
  final bool isSpecialPromo;
  final bool isFromMainPage;
  final bool isBirthdayPromo;

  DetailPromoPage({
    required this.promo,
    required this.isClaimed,
    required this.userPromoId,
    required this.isSpecialPromo,
    required this.isFromMainPage,
    required this.isBirthdayPromo,
  });

  @override
  _DetailPromoPageState createState() => _DetailPromoPageState();
}

class _DetailPromoPageState extends State<DetailPromoPage> {
  String qrData = '-';
  bool isClaimed = false;

  bool isClaimedOrCancelBtnPressed = false;

  @override
  void initState() {
    if (widget.isClaimed) {
      setState(() {
        isClaimed = true;
      });
    }

    super.initState();
  }

  Widget _buildAppbar() {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<UserBloc, UserState>(
      builder: (_, userState) => Padding(
        padding: EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          children: [
            BackButtonWidget(
              name: 'Detail Promo',
              onTapFunc: () {
                context.read<PromoBloc>().add(
                      GetAllPromoList(
                        idMember:
                            '${(userState is UserLoaded) ? userState.user.idMember : ''}',
                        userCity:
                            '${(userState is UserLoaded) ? userState.user.city : ''}',
                      ),
                    );

                context.read<ClaimedPromoBloc>().add(
                      GetAllClaimedPromo(
                        '${(userState is UserLoaded) ? userState.user.idMember : ''}',
                      ),
                    );

                if (widget.isFromMainPage) {
                  context.read<PageBloc>().add(GoToHomePage(0));
                } else {
                  context.read<PageBloc>().add(GoToListPromoPage(
                        (userState is UserLoaded)
                            ? '${userState.user.idMember}'
                            : '',
                      ));
                }
              },
            ),
            SizedBox(height: height * verticalMargin),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (_, userState) => WillPopScope(
        onWillPop: () async {
          context.read<PageBloc>().add(GoToListPromoPage(
                (userState is UserLoaded) ? '${userState.user.idMember}' : '',
              ));

          return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (_, userState) => Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverAppBar(
                        backgroundColor: Colors.white,
                        automaticallyImplyLeading: false,
                        elevation: 0,
                        pinned: true,
                        title: _buildAppbar(),
                      ),
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [_buildContentList()],
                        ),
                      ),
                    ],
                  ),
                  if (userState is UserLoaded)
                    (!isClaimed)
                        ? _claimPromoBTN(
                            idMember: userState.user.idMember!,
                            name: userState.user.name!,
                            phoneNumber: userState.user.phoneNumber!,
                            userCity: userState.user.city!,
                          )
                        : SizedBox(),
                  if (isClaimedOrCancelBtnPressed)
                    Container(
                      color: Colors.black.withOpacity(.4),
                      child: Center(
                        child: Container(
                          height: MediaQuery.of(context).size.height * .5,
                          child: SpinKitRing(
                            color: ThemeColor.accentColor2,
                            size: 34,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentList() {
    var height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        ClipRRect(
          child: Image.network(
            widget.promo.img!,
            fit: BoxFit.fill,
            width: double.infinity,
          ),
        ),
        SizedBox(height: height * verticalMargin),
        (!isClaimed)
            ? SizedBox()
            : BlocBuilder<UserBloc, UserState>(
                builder: (_, userState) => _qrCode(
                  idMember:
                      (userState is UserLoaded) ? userState.user.idMember! : '',
                  name: (userState is UserLoaded) ? userState.user.name! : '',
                  phoneNumber: (userState is UserLoaded)
                      ? userState.user.phoneNumber!
                      : '',
                ),
              ),
        (!isClaimed) ? SizedBox() : SizedBox(height: height * verticalMargin),
        _promoDesc(
          title: 'Keterangan Promo',
          desc: widget.promo.termCondition!,
        ),
        SizedBox(height: height * verticalMargin),
        _promoDesc(
          title: 'Ketentuan',
          desc: widget.promo.provision!,
        ),
        SizedBox(height: height * verticalMargin),
        _promoUntil(),
        SizedBox(height: height * verticalMargin),
        if (isClaimed) _cancelClaimedPromo(),
        SizedBox(height: height * verticalMargin),
        if (isClaimed) _backButton(),
        (isClaimed)
            ? SizedBox(height: height * verticalMargin)
            : SizedBox(
                height: height *
                    (verticalMargin + ((verticalMargin / 2) * 2) + 0.06),
              ),
      ],
    );
  }

  Widget _promoUntil() {
    var height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
      margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ThemeColor.outlineColor),
      ),
      child: Column(
        children: [
          SizedBox(height: height * verticalMargin),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                'Berlaku Sampai',
                style: accentFontBlackRegular.copyWith(
                  fontSize: 14,
                  color: ThemeColor.accentColor4,
                ),
              ),
              AutoSizeText(
                widget.promo.promoEndDate!.dateTimeFormat,
                style: accentFontBlackBold.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: height * verticalMarginHalf),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AutoSizeText(
                'Tipe Promo',
                style: accentFontBlackRegular.copyWith(
                  fontSize: 14,
                  color: ThemeColor.accentColor4,
                ),
              ),
              AutoSizeText(
                (widget.promo.promoCategory! == 'repeat')
                    ? 'Berulang'
                    : 'Sekali Tukar',
                style: accentFontBlackBold.copyWith(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          SizedBox(height: height * verticalMargin),
        ],
      ),
    );
  }

  Widget _promoDesc({required String title, required String desc}) {
    var height = MediaQuery.of(context).size.height;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
      margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: ThemeColor.outlineColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: height * verticalMargin),
          AutoSizeText(
            title,
            style: accentFontBlackBold.copyWith(
              fontSize: 18,
            ),
          ),
          SizedBox(height: height * verticalMarginHalf),
          AutoSizeText(
            desc,
            style: accentFontBlackRegular.copyWith(
              fontSize: 14,
              color: ThemeColor.accentColor4,
            ),
          ),
          SizedBox(height: height * verticalMargin),
        ],
      ),
    );
  }

  Widget _qrCode({
    required String idMember,
    required String name,
    required String phoneNumber,
  }) {
    var claimPromoData = ClaimPromoData(
      idMember: idMember,
      name: name,
      phoneNumber: phoneNumber,
      promoId: widget.promo.promoId!,
    );

    return Container(
      child: QrImage(
        data: (widget.isClaimed && !widget.isSpecialPromo)
            ? '${claimPromoData.idMember}%%%!!!${widget.userPromoId}%%%!!!promo'
            : (widget.isClaimed && widget.isSpecialPromo)
                ? '${claimPromoData.idMember}%%%!!!${widget.userPromoId}%%%!!!next-purchase'
                : qrData,
        version: QrVersions.auto,
        size: MediaQuery.of(context).size.width - (defaultMargin * 2),
        // size: ,
      ),
    );
  }

  Widget _backButton() {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<UserBloc, UserState>(
      builder: (_, userState) => Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {
            context.read<PromoBloc>().add(GetAllPromoList(
                  idMember:
                      '${(userState is UserLoaded) ? userState.user.idMember : ''}',
                  userCity:
                      '${(userState is UserLoaded) ? userState.user.city : ''}',
                ));

            context.read<ClaimedPromoBloc>().add(GetAllClaimedPromo(
                  ((userState is UserLoaded) ? userState.user.idMember : '')!,
                ));

            if (widget.isFromMainPage) {
              context.read<PageBloc>().add(GoToHomePage(0));
            } else {
              context.read<PageBloc>().add(GoToListPromoPage(
                    (userState is UserLoaded)
                        ? '${userState.user.idMember}'
                        : '',
                  ));
            }
          },
          child: Container(
            margin: const EdgeInsets.only(bottom: defaultMargin),
            height: height * 0.06,
            width: height * 0.06,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ThemeColor.mainColor,
            ),
            child: Center(
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _cancelClaimedPromo() {
    if (widget.isBirthdayPromo) {
      return SizedBox();
    } else {
      return BlocBuilder<UserPromoIdBloc, UserPromoIdState>(
        builder: (_, userPromoIdState) => BlocBuilder<UserBloc, UserState>(
          builder: (_, userState) => GestureDetector(
            onTap: () async {
              print(
                  'promo id = ${((userPromoIdState is LoadUserPromoId) ? userPromoIdState.userPromoId : 0)}');
              _onPressedCancelPromo(
                idMember:
                    '${(userState is UserLoaded) ? userState.user.idMember : ''}',
                userPromoId: ((userPromoIdState is LoadUserPromoId)
                    ? userPromoIdState.userPromoId
                    : 0),
                userCity:
                    '${(userState is UserLoaded) ? userState.user.city : ''}',
              );
            },
            child: AutoSizeText(
              'Batalkan Klaim',
              style: accentFontBlackRegular.copyWith(
                fontSize: 14,
                color: ThemeColor.errorColor,
              ),
            ),
          ),
        ),
      );
    }
  }

  Widget _claimPromoBTN({
    required String idMember,
    required String name,
    required String phoneNumber,
    required String userCity,
  }) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(
          vertical: defaultMargin / 2,
          horizontal: defaultMargin,
        ),
        width: double.infinity,
        child: BlocBuilder<UserPromoIdBloc, UserPromoIdState>(
          builder: (_, promoUserIdState) => GlobalButton(
            onTapFunc: () => _onPressedClaimPromo(
              userCity: userCity,
              idMember: idMember,
              name: name,
              phoneNumber: phoneNumber,
              userPromoId: (promoUserIdState is LoadUserPromoId)
                  ? promoUserIdState.userPromoId
                  : 0,
            ),
            title: 'Klaim Promo',
          ),
        ),
      ),
    );
  }

  void _onPressedCancelPromo({
    required String idMember,
    required String userCity,
    int userPromoId = 0,
  }) async {
    showDialog(
      context: context,
      builder: (_) => AlertBoxWidget(
        boxTitle: 'Batalkan klaim\npromo ini?',
        topButtonTitle: 'Iya',
        bottomButtonTitle: 'Tidak',
        isRightCTA: true,
        onTapBottomButton: () {
          Navigator.pop(context);
        },
        onTapTopButton: () async {
          Navigator.pop(context);

          setState(() {
            isClaimedOrCancelBtnPressed = true;
          });

          await PromoService.cancelClaimedPromo(
            idMember: idMember,
            userPromoId: widget.userPromoId,
          ).then((value) {
            context.read<PromoBloc>().add(
                  GetAllPromoList(
                    idMember: idMember,
                    userCity: userCity,
                  ),
                );

            context.read<ClaimedPromoBloc>().add(GetAllClaimedPromo(idMember));

            context.read<PageBloc>().add(GoToListPromoPage(
                  idMember,
                ));

            setState(() {
              isClaimedOrCancelBtnPressed = false;
            });
          });
        },
      ),
    );
  }

  void _onPressedClaimPromo({
    required String idMember,
    required String name,
    required String phoneNumber,
    required String userCity,
    required int userPromoId,
  }) async {
    showDialog(
      context: context,
      builder: (_) => AlertBoxWidget(
        boxTitle: 'Klaim promo\nsekarang?',
        topButtonTitle: 'Ya',
        bottomButtonTitle: 'Tidak',
        isRightCTA: true,
        onTapBottomButton: () {
          Navigator.pop(context);
        },
        onTapTopButton: () async {
          Navigator.pop(context);

          var claimPromoData = ClaimPromoData(
            idMember: idMember,
            name: name,
            phoneNumber: phoneNumber,
            promoId: widget.promo.promoId!,
          );

          setState(() {
            isClaimedOrCancelBtnPressed = true;
          });

          await PromoService.claimPromoOnce(
            claimPromoData: claimPromoData,
          ).then((value) {
            context.read<PromoBloc>().add(
                  GetAllPromoList(
                    idMember: idMember,
                    userCity: userCity,
                  ),
                );

            context.read<ClaimedPromoBloc>().add(
                  GetAllClaimedPromo(idMember),
                );

            context.read<PageBloc>().add(GoToListPromoPage(idMember));

            setState(() {
              isClaimedOrCancelBtnPressed = false;
            });
          });

          // context.read<ClaimPromoBloc>().add(
          //       ClaimPromoOnce(claimPromoData: claimPromoData),
          //     );
        },
      ),
    );
  }
}
