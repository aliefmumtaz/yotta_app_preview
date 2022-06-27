import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yotta_user_app/bloc/bloc.dart';
import 'package:yotta_user_app/shared/shared.dart';
import 'package:yotta_user_app/view/pages/pages.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  OneSignal.shared.setAppId(oneSignalAppId);
  OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
    print("Accepted permission: $accepted");
  });
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    configOneSignel();
  }

  void configOneSignel() {
    OneSignal.shared.setAppId(oneSignalAppId);

    OneSignal.shared.promptUserForPushNotificationPermission().then((accepted) {
      print("Accepted permission: $accepted");
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => SpecialOfferBloc()),
        BlocProvider(create: (context) => ListCityForRegistrationBloc()),
        BlocProvider(create: (context) => ToppingBloc()),
        BlocProvider(create: (context) => IdMemberDataBloc()),
        BlocProvider(create: (context) => VariantListBloc()),
        BlocProvider(create: (context) => AllMenuBloc()),
        BlocProvider(create: (context) => OrderTypeBloc()),
        BlocProvider(create: (context) => SugarTypeBloc()),
        BlocProvider(create: (context) => IceTypeBloc()),
        BlocProvider(create: (context) => ListOutletBloc()),
        BlocProvider(create: (context) => PickupTimeBloc()),
        BlocProvider(create: (context) => ListOrderCartColdBloc()),
        BlocProvider(create: (context) => ListOrderCartBottleBloc()),
        BlocProvider(create: (context) => TotalPriceBloc()),
        BlocProvider(create: (context) => ListOrderCartHotBloc()),
        BlocProvider(create: (context) => ListOrderCheckoutCupBloc()),
        BlocProvider(create: (context) => ListOrderCheckoutBottleBloc()),
        BlocProvider(create: (context) => ListOrderCheckoutHotBloc()),
        BlocProvider(create: (context) => CheckoutPreorderDataBloc()),
        BlocProvider(create: (context) => ChangeStatusOrderBloc()),
        BlocProvider(create: (context) => HistoryOrderBloc()),
        BlocProvider(create: (context) => StatusOrderBloc()),
        BlocProvider(create: (context) => HistoryOrderListBloc()),
        BlocProvider(create: (context) => ListHitoryOrderCupBloc()),
        BlocProvider(create: (context) => ListHitoryOrderBottleBloc()),
        BlocProvider(create: (context) => ListHitoryOrderHotBloc()),
        BlocProvider(create: (context) => MenuBloc()),
        BlocProvider(create: (context) => PageBloc()),
        BlocProvider(create: (context) => UserBloc()),
        BlocProvider(create: (context) => GeolocationBloc()),
        BlocProvider(create: (context) => SelectedLocationBloc()),
        BlocProvider(create: (context) => CheckoutDeliveryDataBloc()),
        BlocProvider(create: (context) => CheckoutSelectedOutletLatlngBloc()),
        BlocProvider(create: (context) => ListOrderTypeBloc()),
        BlocProvider(create: (context) => YottaOfTheWeekBloc()),
        BlocProvider(create: (context) => UserPointBloc()),
        BlocProvider(create: (context) => NotificationBloc()),
        BlocProvider(create: (context) => PasswordTempBloc()),
        BlocProvider(create: (context) => GuestModeBloc()),
        BlocProvider(create: (context) => QueueOrderCheckBloc()),
        BlocProvider(create: (context) => PromoBloc()),
        BlocProvider(create: (context) => ClaimedPromoBloc()),
        BlocProvider(create: (context) => ClaimPromoBloc()),
        BlocProvider(create: (context) => UserPromoIdBloc()),
        BlocProvider(create: (context) => CancelClaimedPromoBloc()),
        BlocProvider(create: (context) => DateCreationBloc()),
        BlocProvider(create: (context) => GetPromoNextPurchaseBloc()),
        BlocProvider(create: (context) => BirthdayCheckingBloc()),
      ],
      child: FutureBuilder(
        future: Future.delayed(Duration(seconds: 2)),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: LoadingWelcomePage(),
            );
          } else {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: ScrollConfiguration(
                behavior: CustomBehavior(),
                child: Wrapper(),
              ),
            );
          }
        },
      ),
    );
  }
}

class CustomBehavior extends ScrollBehavior {
  @override
  ScrollPhysics getScrollPhysics(BuildContext context) =>
      ClampingScrollPhysics();

  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) =>
      child;
}

class LoadingWelcomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(),
              Container(
                width: MediaQuery.of(context).size.width * .7,
                child:
                    Image.asset('assets/semangatyo.png', fit: BoxFit.fitWidth),
              ),
              Column(
                children: [
                  Text(
                    'Yotta Indonesia App. Version $appVersion',
                    style: accentFontBlackRegular.copyWith(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height *
                        (verticalMargin * 2),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
