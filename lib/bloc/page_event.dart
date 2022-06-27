part of 'page_bloc.dart';

@immutable
abstract class PageEvent extends Equatable {
  const PageEvent();
}

class GoToLoginPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToVerificationPage extends PageEvent {
  final String phoneNumber;

  GoToVerificationPage(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class GoToSplashPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToChooseMemberStatusPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToRegistrationPage extends PageEvent {
  final RegistrationData registrationData;
  final DataForRegisteredIdMember registeredMemberData;
  final bool isIdRegistered;

  GoToRegistrationPage(
    this.registrationData,
    this.registeredMemberData,
    this.isIdRegistered,
  );

  @override
  List<Object> get props => [registrationData];
}

class GoToInputMemberIdPage extends PageEvent {
  final DataForRegisteredIdMember registrationData;

  GoToInputMemberIdPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class GoToHomePage extends PageEvent {
  final int index;
  final String? selectedOrder;
  final String? userID;

  GoToHomePage(
    this.index, {
    this.selectedOrder,
    this.userID,
  });

  @override
  List<Object> get props => [index];
}

class GoToRegistrationVerificationPage extends PageEvent {
  final String phoneNumber;
  final RegistrationData registrationData;
  final DataForRegisteredIdMember registeredIdMember;
  final String password;

  GoToRegistrationVerificationPage(
    this.registrationData,
    this.phoneNumber,
    this.registeredIdMember,
    this.password,
  );

  @override
  List<Object> get props => [
        phoneNumber,
        registeredIdMember,
        registrationData,
        password,
      ];
}

class GoToSelectMenuPage extends PageEvent {
  final PreOrderData? preOrderData;
  final DeliveryOrderData? deliveryOrderData;
  final String? selectedVariant;
  final String? selectedProductStyle;

  GoToSelectMenuPage(
    this.selectedVariant,
    this.selectedProductStyle, {
    this.preOrderData,
    this.deliveryOrderData,
  });

  @override
  List<Object?> get props => [
        preOrderData,
        selectedVariant,
        selectedProductStyle,
      ];
}

class GoToSelectDetailProductPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSelectDetailOrderCup extends PageEvent {
  final ChoosenColdMenu choosenColdMenu;
  final List<String> price;
  final PreOrderData? preOrderData;
  final DeliveryOrderData? deliveryOrderData;
  final String drinkType;
  final String? selectedVariant;
  final String? selectedProductStyle;
  final String? imgUrl;

  GoToSelectDetailOrderCup(
    this.choosenColdMenu,
    this.price,
    this.drinkType,
    this.selectedVariant,
    this.selectedProductStyle, {
    this.preOrderData,
    this.deliveryOrderData,
    this.imgUrl,
  });

  @override
  List<Object?> get props => [
        choosenColdMenu,
        price,
        preOrderData,
        drinkType,
        selectedVariant,
        selectedProductStyle,
        deliveryOrderData,
        imgUrl,
      ];
}

class GoToSelectDetailOrderHot extends PageEvent {
  final ChoosenHotMenu choosenHotMenu;
  final List<String> price;
  final PreOrderData? preOrderData;
  final DeliveryOrderData? deliveryOrderData;
  final String drinkType;
  final String? selectedVariant;
  final String? selectedProductStyle;

  GoToSelectDetailOrderHot(
    this.choosenHotMenu,
    this.drinkType,
    this.price,
    this.selectedVariant,
    this.selectedProductStyle, {
    this.preOrderData,
    this.deliveryOrderData,
  });

  @override
  List<Object?> get props => [
        choosenHotMenu,
        drinkType,
        preOrderData,
        price,
        selectedVariant,
        selectedProductStyle,
      ];
}

class GoToSelectDetailOrderBottle extends PageEvent {
  final ChoosenBottleMenu choosenBottleMenu;
  final List<String> price;
  final PreOrderData? preOrderData;
  final DeliveryOrderData? deliveryOrderData;
  final String orderType;
  final String? selectedVariant;
  final String? selectedProductStyle;

  GoToSelectDetailOrderBottle(
    this.choosenBottleMenu,
    this.price,
    this.orderType,
    this.selectedVariant,
    this.selectedProductStyle, {
    this.preOrderData,
    this.deliveryOrderData,
  });

  @override
  List<Object?> get props => [
        choosenBottleMenu,
        price,
        orderType,
        preOrderData,
        selectedVariant,
        selectedProductStyle,
      ];
}

class GoToSelectOutletPreorder extends PageEvent {
  final String selectCity;
  final String orderType;
  final LatLngInitialLocation latLngInitialLocation;

  GoToSelectOutletPreorder(
    this.selectCity,
    this.orderType,
    this.latLngInitialLocation,
  );

  @override
  List<Object> get props => [selectCity, orderType, latLngInitialLocation];
}

class GoToCartDetailPage extends PageEvent {
  final PreOrderData? preOrderData;
  final DeliveryOrderData? deliveryOrderData;
  final String? selectedVariant;
  final String? selectedProductStyle;

  GoToCartDetailPage(
    this.selectedVariant,
    this.selectedProductStyle, {
    this.preOrderData,
    this.deliveryOrderData,
  });

  @override
  List<Object?> get props => [
        preOrderData,
        selectedVariant,
        selectedProductStyle,
        deliveryOrderData,
      ];
}

class GoToSuccessCheckoutPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToCartCheckoutPage extends PageEvent {
  final PageEvent pageEvent;

  GoToCartCheckoutPage(this.pageEvent);

  @override
  List<Object> get props => [pageEvent];
}

class GoToHistoryOrderDetailPage extends PageEvent {
  final String orderType;
  final DetailHistoryOrderType? detailHistoryOrderType;
  final DetailHistoryOrderDeliveryType? detailHistoryOrderDeliveryType;

  GoToHistoryOrderDetailPage(
    this.orderType, {
    this.detailHistoryOrderType,
    this.detailHistoryOrderDeliveryType,
  });

  @override
  List<Object?> get props => [
        orderType,
        detailHistoryOrderType,
        detailHistoryOrderDeliveryType,
      ];
}

class GoToEditProfilePage extends PageEvent {
  final String? name;
  final String? nickName;
  final String? email;
  final String? city;
  final String? date;
  final String? phoneNumber;

  GoToEditProfilePage({
    this.name,
    this.nickName,
    this.email,
    this.city,
    this.date,
    this.phoneNumber,
  });

  @override
  List<Object?> get props => [city, email, name, nickName, date, phoneNumber];
}

class GoToTestingPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToSetDeliveryLocationPage extends PageEvent {
  final LatLngInitialLocation latLngInitialLocation;

  GoToSetDeliveryLocationPage(this.latLngInitialLocation);

  @override
  List<Object> get props => [latLngInitialLocation];
}

class GoToOutletPage extends PageEvent {
  final LatLngInitialLocation latLngInitialLocation;
  final String? selectedCity;

  GoToOutletPage(this.latLngInitialLocation, this.selectedCity);

  @override
  List<Object?> get props => [latLngInitialLocation, selectedCity];
}

class GoToMenuPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToContactUsPage extends PageEvent {
  @override
  List<Object> get props => [];
}

class GoToCartCheckoutDeliveryPage extends PageEvent {
  final LatLng outletLatLng;
  final LatLng userLoc;
  final PageEvent pageEvent;

  GoToCartCheckoutDeliveryPage(
    this.outletLatLng,
    this.userLoc,
    this.pageEvent,
  );

  @override
  List<Object> get props => [outletLatLng, userLoc, pageEvent];
}

class GoToDetailSpecialOfferPage extends PageEvent {
  final DetailSpecialOffer detailSpecialOffer;

  GoToDetailSpecialOfferPage(this.detailSpecialOffer);

  @override
  List<Object> get props => [detailSpecialOffer];
}

class GoToListPromoPage extends PageEvent {
  final String idMember;

  GoToListPromoPage(this.idMember);

  @override
  List<Object?> get props => [idMember];
}

class GoToDetailPromoPage extends PageEvent {
  final Promo promo;
  final bool isClaimed;
  final int userPromoId;
  final bool isSpecialPromo;
  final bool isFromMainPage;
  final bool isBirthdayPromo;

  GoToDetailPromoPage({
    required this.promo,
    required this.isClaimed,
    required this.userPromoId,
    required this.isSpecialPromo,
    required this.isFromMainPage,
    required this.isBirthdayPromo,
  });

  @override
  List<Object?> get props => [
        promo,
        isClaimed,
        userPromoId,
        isSpecialPromo,
        isFromMainPage,
        isBirthdayPromo,
      ];
}

class GoToAccountPage extends PageEvent {
  @override
  List<Object?> get props => [];
}
