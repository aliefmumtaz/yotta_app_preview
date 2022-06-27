part of 'page_bloc.dart';

@immutable
abstract class PageState extends Equatable {
  const PageState();
}

class PageInitial extends PageState {
  @override
  List<Object> get props => [];
}

class OnLoginPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnVerificationPage extends PageState {
  final String phoneNumber;

  OnVerificationPage(this.phoneNumber);

  @override
  List<Object> get props => [phoneNumber];
}

class OnSplashPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnChooseMemberStatusPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnRegistrationPage extends PageState {
  final RegistrationData registrationData;
  final DataForRegisteredIdMember registeredMemberData;
  final bool isIdRegistered;

  OnRegistrationPage(
    this.registrationData,
    this.registeredMemberData,
    this.isIdRegistered,
  );

  @override
  List<Object> get props => [registrationData];
}

class OnInputMemberIdPage extends PageState {
  final DataForRegisteredIdMember registrationData;

  OnInputMemberIdPage(this.registrationData);

  @override
  List<Object> get props => [];
}

class OnHomePage extends PageState {
  final int index;
  final String? selectedOrder;
  final String? userID;

  OnHomePage(this.index, this.selectedOrder, this.userID);

  @override
  List<Object> get props => [index];
}

class OnRegistrationVerificationPage extends PageState {
  final String phoneNumber;
  final RegistrationData registrationData;
  final DataForRegisteredIdMember registeredIdMember;
  final String password;

  OnRegistrationVerificationPage(
    this.phoneNumber,
    this.registrationData,
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

class OnSelectMenuPage extends PageState {
  final PreOrderData? preOrderData;
  final DeliveryOrderData? deliveryOrderData;
  final String? selectedVariant;
  final String? selectedProductStyle;

  OnSelectMenuPage(
    this.selectedVariant,
    this.selectedProductStyle, {
    this.preOrderData,
    this.deliveryOrderData,
  });

  @override
  List<Object?> get props => [
        preOrderData,
        deliveryOrderData,
        selectedVariant,
        selectedProductStyle,
      ];
}

class OnSelectDetailProductPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSelectDetailOrderCup extends PageState {
  final ChoosenColdMenu choosenColdMenu;
  final List<String> price;
  final PreOrderData? preOrderData;
  final DeliveryOrderData? deliveryOrderData;
  final String drinkType;
  final String? selectedVariant;
  final String? selectedProductStyle;
  final String? imgUrl;

  OnSelectDetailOrderCup(
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

class OnSelectDetailOrderHot extends PageState {
  final ChoosenHotMenu choosenHotMenu;
  final List<String> price;
  final PreOrderData? preOrderData;
  final DeliveryOrderData? deliveryOrderData;
  final String drinkType;
  final String? selectedVariant;
  final String? selectedProductStyle;

  OnSelectDetailOrderHot(
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
        deliveryOrderData,
      ];
}

class OnSelectDetailOrderBottle extends PageState {
  final ChoosenBottleMenu choosenBottleMenu;
  final List<String> price;
  final PreOrderData? preOrderData;
  final DeliveryOrderData? deliveryOrderData;
  final String drinkType;
  final String? selectedVariant;
  final String? selectedProductStyle;

  OnSelectDetailOrderBottle(
    this.choosenBottleMenu,
    this.price,
    this.drinkType,
    this.selectedVariant,
    this.selectedProductStyle, {
    this.preOrderData,
    this.deliveryOrderData,
  });

  @override
  List<Object?> get props => [
        choosenBottleMenu,
        price,
        preOrderData,
        drinkType,
        selectedVariant,
        selectedProductStyle,
        deliveryOrderData,
      ];
}

class OnSelectOutletPreOrder extends PageState {
  final String selectedCity;
  final String orderType;
  final LatLngInitialLocation latLngInitialLocation;

  OnSelectOutletPreOrder(
    this.selectedCity,
    this.orderType,
    this.latLngInitialLocation,
  );

  @override
  List<Object> get props => [selectedCity, orderType, latLngInitialLocation];
}

class OnCartDetailPage extends PageState {
  final PreOrderData? preOrderData;
  final DeliveryOrderData? deliveryOrderData;
  final String? selectedVariant;
  final String? selectedProductStyle;

  OnCartDetailPage(
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

class OnSuccessCheckoutPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnCartCheckoutPage extends PageState {
  final PageEvent pageEvent;

  OnCartCheckoutPage(this.pageEvent);

  @override
  List<Object> get props => [pageEvent];
}

class OnHistoryOrderDetailPage extends PageState {
  final DetailHistoryOrderType? detailHistoryOrderType;
  final DetailHistoryOrderDeliveryType? detailHistoryOrderDeliveryType;
  final String orderType;

  OnHistoryOrderDetailPage(
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

class OnEditProfilePage extends PageState {
  final String? name;
  final String? nickName;
  final String? email;
  final String? city;
  final String? date;
  final String? phoneNumber;

  OnEditProfilePage({
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

class OnTestingPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnSetDeliveryLocationPage extends PageState {
  final LatLngInitialLocation latLngInitialLocation;

  OnSetDeliveryLocationPage(this.latLngInitialLocation);

  @override
  List<Object> get props => [latLngInitialLocation];
}

class OnOutletPage extends PageState {
  final LatLngInitialLocation latLngInitialLocation;
  final String? selectedCity;

  OnOutletPage(this.latLngInitialLocation, this.selectedCity);

  @override
  List<Object?> get props => [latLngInitialLocation, selectedCity];
}

class OnMenuPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnContactUsPage extends PageState {
  @override
  List<Object> get props => [];
}

class OnCartCheckoutDeliveryPage extends PageState {
  final LatLng outletLatLng;
  final LatLng userLoc;
  final PageEvent pageEvent;

  OnCartCheckoutDeliveryPage(
    this.outletLatLng,
    this.userLoc,
    this.pageEvent,
  );

  @override
  List<Object> get props => [outletLatLng, userLoc, pageEvent];
}

class OnDetailSpecialOfferPage extends PageState {
  final DetailSpecialOffer detailSpecialOffer;

  OnDetailSpecialOfferPage(this.detailSpecialOffer);

  @override
  List<Object> get props => [detailSpecialOffer];
}

class OnListPromoPage extends PageState {
  final String idMember;

  OnListPromoPage(this.idMember);

  @override
  List<Object?> get props => [idMember];
}

class OnDetailPromoPage extends PageState {
  final Promo promo;
  final bool isClaimed;
  final int userPromoId;
  final bool isSpecialPromo;
  final bool isFromMainPage;
  final bool isBirthdayPromo;

  OnDetailPromoPage({
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

class OnAccountPage extends PageState {
  @override
  List<Object?> get props => [];
}
