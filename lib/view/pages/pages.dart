import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
// import 'dart:math';

// import 'package:flutter/gestures.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yotta_user_app/bloc/bloc.dart';
import 'package:yotta_user_app/main.dart';
import 'package:yotta_user_app/models/models.dart';
import 'package:yotta_user_app/services/services.dart';
import 'package:yotta_user_app/shared/shared.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yotta_user_app/view/widgets/widgets.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:another_flushbar/flushbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yotta_user_app/extentions/extentions.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:sticky_headers/sticky_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:geocoding/geocoding.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

part 'login_page.dart';
part 'main_page.dart';
part 'verification_page.dart';
part 'wrapper.dart';
part 'splash_page.dart';
part 'choose_member_status_page.dart';
part 'registration_page.dart';
part 'input_member_id_page.dart';
part 'home_page.dart';
part 'registration_verification_page.dart';
part 'reward_page.dart';
part 'cart_page.dart';
part 'account_page.dart';
part 'select_menu_page.dart';
part 'select_detail_order_page_cup.dart';
part 'select_detail_order_page_hot.dart';
part 'select_detail_order_page_bottle.dart';
part 'select_outlet_preorder.dart';
part 'cart_detail_order.dart';
part 'success_checkout_page.dart';
part 'cart_checkuot_list_page.dart';
part 'history_order_detail_order_page.dart';
part 'edit_profile_page.dart';
// part 'set_delivery_location_page.dart';
part 'outlet_page.dart';
part 'menu_page.dart';
part 'contact_us_page.dart';
part 'cart_checkout_list_delivery_page.dart';
part 'detail_special_offer_page.dart';
part 'reset_password_page.dart';
part 'list_promo_page.dart';
part 'detail_promo_page.dart';