import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageInitial()) {
    on<GoToLoginPage>((event, emit) => emit(OnLoginPage()));
    on<GoToVerificationPage>(
      (event, emit) => emit(OnVerificationPage(event.phoneNumber)),
    );
    on<GoToSplashPage>((event, emit) => emit(OnSplashPage()));
    on<GoToChooseMemberStatusPage>(
        (event, emit) => emit(OnChooseMemberStatusPage()));
    on<GoToRegistrationPage>(
      (event, emit) => emit(
        OnRegistrationPage(
          event.registrationData,
          event.registeredMemberData,
          event.isIdRegistered,
        ),
      ),
    );
    on<GoToInputMemberIdPage>(
      (event, emit) => emit(OnInputMemberIdPage(event.registrationData)),
    );
    on<GoToHomePage>(
      (event, emit) => emit(
        OnHomePage(event.index, event.selectedOrder, event.userID),
      ),
    );
    on<GoToRegistrationVerificationPage>(
      (event, emit) => emit(
        OnRegistrationVerificationPage(
          event.phoneNumber,
          event.registrationData,
          event.registeredIdMember,
          event.password,
        ),
      ),
    );
    on<GoToSelectMenuPage>(
      (event, emit) => emit(
        OnSelectMenuPage(
          event.selectedVariant,
          event.selectedProductStyle,
          preOrderData: event.preOrderData,
          deliveryOrderData: event.deliveryOrderData,
        ),
      ),
    );
    on<GoToSelectDetailProductPage>(
      (event, emit) => emit(OnSelectDetailProductPage()),
    );
    on<GoToSelectDetailOrderCup>(
      (event, emit) => emit(
        OnSelectDetailOrderCup(
          event.choosenColdMenu,
          event.price,
          event.drinkType,
          event.selectedVariant,
          event.selectedProductStyle,
          preOrderData: event.preOrderData,
          deliveryOrderData: event.deliveryOrderData,
          imgUrl: event.imgUrl,
        ),
      ),
    );
    on<GoToSelectDetailOrderHot>(
      (event, emit) => emit(
        OnSelectDetailOrderHot(
          event.choosenHotMenu,
          event.drinkType,
          event.price,
          event.selectedVariant,
          event.selectedProductStyle,
          preOrderData: event.preOrderData,
          deliveryOrderData: event.deliveryOrderData,
        ),
      ),
    );
    on<GoToSelectDetailOrderBottle>(
      (event, emit) => emit(
        OnSelectDetailOrderBottle(
          event.choosenBottleMenu,
          event.price,
          event.orderType,
          event.selectedVariant,
          event.selectedProductStyle,
          preOrderData: event.preOrderData,
          deliveryOrderData: event.deliveryOrderData,
        ),
      ),
    );
    on<GoToSelectOutletPreorder>(
      (event, emit) => emit(
        OnSelectOutletPreOrder(
          event.selectCity,
          event.orderType,
          event.latLngInitialLocation,
        ),
      ),
    );
    on<GoToCartDetailPage>(
      (event, emit) => emit(
        OnCartDetailPage(
          event.selectedVariant,
          event.selectedProductStyle,
          preOrderData: event.preOrderData,
          deliveryOrderData: event.deliveryOrderData,
        ),
      ),
    );
    on<GoToSuccessCheckoutPage>((event, emit) => emit(OnSuccessCheckoutPage()));
    on<GoToCartCheckoutPage>(
      (event, emit) => emit(OnCartCheckoutPage(event.pageEvent)),
    );
    on<GoToHistoryOrderDetailPage>(
      (event, emit) => emit(
        OnHistoryOrderDetailPage(
          event.orderType,
          detailHistoryOrderDeliveryType: event.detailHistoryOrderDeliveryType,
          detailHistoryOrderType: event.detailHistoryOrderType,
        ),
      ),
    );
    on<GoToEditProfilePage>(
      (event, emit) => emit(
        OnEditProfilePage(
          name: event.name,
          nickName: event.nickName,
          email: event.email,
          city: event.city,
          date: event.date,
          phoneNumber: event.phoneNumber,
        ),
      ),
    );
    on<GoToSetDeliveryLocationPage>(
      (event, emit) => emit(
        OnSetDeliveryLocationPage(event.latLngInitialLocation),
      ),
    );
    on<GoToOutletPage>(
      (event, emit) => emit(
        OnOutletPage(
          event.latLngInitialLocation,
          event.selectedCity,
        ),
      ),
    );
    on<GoToMenuPage>((event, emit) => emit(OnMenuPage()));
    on<GoToContactUsPage>((event, emit) => emit(OnContactUsPage()));
    on<GoToCartCheckoutDeliveryPage>(
      (event, emit) => OnCartCheckoutDeliveryPage(
        event.outletLatLng,
        event.userLoc,
        event.pageEvent,
      ),
    );
    on<GoToDetailSpecialOfferPage>(
      (event, emit) => emit(
        OnDetailSpecialOfferPage(event.detailSpecialOffer),
      ),
    );
    on<GoToListPromoPage>(
      (event, emit) => emit(OnListPromoPage(event.idMember)),
    );
    on<GoToDetailPromoPage>(
      (event, emit) => emit(
        OnDetailPromoPage(
          isClaimed: event.isClaimed,
          promo: event.promo,
          userPromoId: event.userPromoId,
          isSpecialPromo: event.isSpecialPromo,
          isFromMainPage: event.isFromMainPage,
          isBirthdayPromo: event.isBirthdayPromo,
        ),
      ),
    );
    on<GoToAccountPage>((event, emit) => emit(OnAccountPage()));
  }
}
