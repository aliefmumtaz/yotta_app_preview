// part of 'pages.dart';

// class SetDeliveryLocationPage extends StatefulWidget {
//   final LatLngInitialLocation latLngInitialLocation;

//   SetDeliveryLocationPage(this.latLngInitialLocation);

//   @override
//   _SetDeliveryLocationPageState createState() =>
//       _SetDeliveryLocationPageState();
// }

// class _SetDeliveryLocationPageState extends State<SetDeliveryLocationPage>
//     with TickerProviderStateMixin {
//   Completer<GoogleMapController> _controllerGoogleMaps = Completer();

//   late CameraPosition _initialCameraPosition;

//   Marker? _nearestOutlet;
//   Marker? _deliveryPoint;
//   late BitmapDescriptor _userCustomMarker;
//   late BitmapDescriptor _nearestOutletCustomMarker;

//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//         targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }

//   void setUserPositionMarker() async {
//     final Uint8List markerIcon = await getBytesFromAsset(
//       'assets/icon_loc_position.png',
//       100,
//     );

//     _userCustomMarker = BitmapDescriptor.fromBytes(markerIcon);
//   }

//   void setNearestOutletMarker() async {
//     final Uint8List markerIcon = await getBytesFromAsset(
//       'assets/icon_loc_outlet.png',
//       100,
//     );

//     _nearestOutletCustomMarker = BitmapDescriptor.fromBytes(markerIcon);
//   }

//   late GoogleMapController _mapController;
//   Position? _currentPosition;
//   Directions? _directions;

//   String _city = '';
//   String _address = '';

//   String? _nearestOutletName = '';
//   String _nearestOutletDistance = '';

//   String _selectedRecomendedOutlet = '';

//   bool _isLoadingNearestOutlet = false;
//   bool _isMarkerDraggable = true;
//   bool _isVisible = true;
//   bool _isDistanceNear = false;
//   bool _isNoRecomendedOutlet = false;
//   bool _isQuickTipVisible = false;
//   bool _isBTNCurrentLoc = false;

//   int _btnDurationOpacity = 300;

//   int _deliveryFee = 0;

//   List<NearestOutletRecommendation> nearestOutletRecommendation = [];
//   List<NearestOutletRecommendation> nearestOutletRecommendationAfterSort = [];

//   BoxShadow _iconBoxShadow = BoxShadow(
//     blurRadius: 12,
//     offset: Offset(0, 5),
//     color: Colors.black.withOpacity(0.1),
//   );

//   void _backButtonPressed() async {
//     context.read<PageBloc>().add(GoToHomePage(0));
//     context.read<GeolocationBloc>().add(DistanceToinitial());
//     context.read<OrderTypeBloc>().add(OrderTypeToInitial());
//     _resetState();
//   }

//   bool _isOutletFull = false;
//   bool _isOutletReadyToDelivery = false;
//   bool _isOutletOutOfDistance = false;

//   @override
//   void initState() {
//     _resetState();

//     setUserPositionMarker();
//     setNearestOutletMarker();
//     _initialCameraPosition = CameraPosition(
//       target: LatLng(
//         widget.latLngInitialLocation.lat!,
//         widget.latLngInitialLocation.lang!,
//       ),
//       zoom: 17,
//       bearing: 50,
//     );
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _mapController.dispose();
//     super.dispose();
//   }

//   double animatedHeight = (.2 + (verticalMargin * 8) + (.06 * 4));

//   bool _isBTNfindLocVisible = true;

//   void _resetState() {
//     setState(() {
//       _isVisible = true;
//       _isLoadingNearestOutlet = false;
//       _isDistanceNear = false;
//       _nearestOutletName = '';
//       _nearestOutletDistance = '';
//       _isBTNfindLocVisible = true;
//       _isOutletReadyToDelivery = false;
//       _isOutletOutOfDistance = false;
//       _isOutletFull = false;
//       _isDetailDeliveryDataWidgetVisible = false;
//       _isDetailDeliveryDataWidgetVisibleNoSpace = false;
//       _isOutletIsFullWidgetVisible = false;
//       _isOutletIsFullWidgetVisibleNoSpace = false;
//       _address = '';
//       _city = '';
//       _directions = null;
//       _currentPosition = null;
//       _deliveryPoint = null;
//       _nearestOutlet = null;
//       _isMarkerDraggable = true;
//       _isDistanceNearOutlet = false;
//       _selectedRecomendedOutlet = '';
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     var height = MediaQuery.of(context).size.height;

//     return WillPopScope(
//       onWillPop: () async {
//         _backButtonPressed();

//         return false;
//       },
//       child: Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Colors.white,
//         body: Stack(
//           children: [
//             _buildGoogleMapsWidget(),
//             SafeArea(
//               child: Column(
//                 children: [
//                   SizedBox(height: height * verticalMargin),
//                   _backCircleWidget(),
//                   Spacer(),
//                 ],
//               ),
//             ),
//             _bottomSheetWidget(),
//             Column(
//               children: [
//                 Spacer(),
//                 if (!_isVisible)
//                   Container(
//                     height: height * (verticalMargin * 2 + .06),
//                     color: Colors.white,
//                   ),
//               ],
//             ),
//             Visibility(
//               visible: _isBTNfindLocVisible,
//               child: SafeArea(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Spacer(),
//                     AnimatedOpacity(
//                       opacity: _isVisible ? 1.0 : 0.0,
//                       onEnd: () {
//                         setState(() {
//                           _isBTNfindLocVisible = false;
//                         });
//                       },
//                       duration: Duration(
//                         milliseconds: _btnDurationOpacity,
//                       ),
//                       child: Column(
//                         children: [
//                           _buildLocationCurrentLocationWidget(),
//                           Container(
//                             color: (!_isVisible)
//                                 ? Colors.white
//                                 : Colors.transparent,
//                             child: Column(
//                               children: [
//                                 SizedBox(height: height * verticalMargin),
//                                 (_currentPosition == null)
//                                     ? _btnCurrentLocation()
//                                     : _btnGetNearestOutlet(),
//                                 SizedBox(height: height * verticalMargin),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Visibility(
//               visible: _isQuickTipVisible,
//               child: _buildQuickTipWidget(),
//             ),
//             _bottomSheetWidget(),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildQuickTipWidget() {
//     var height = MediaQuery.of(context).size.height;

//     return Stack(
//       children: [
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               _isQuickTipVisible = false;
//             });
//           },
//           child: Container(
//             color: Colors.black.withOpacity(0.5),
//           ),
//         ),
//         Column(
//           children: [
//             SizedBox(height: height * verticalMargin * 4),
//             QuickTipsDeliveryMarker(
//               onTap: () async {
//                 setState(() {
//                   _isQuickTipVisible = false;
//                 });
//               },
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget _buildLocationCurrentLocationWidget() {
//     var height = MediaQuery.of(context).size.height;

//     return BlocBuilder<SelectedLocationBloc, SelectedLocationState>(
//       builder: (_, locationState) => Container(
//         width: double.infinity,
//         padding: const EdgeInsets.all(defaultMargin),
//         margin: const EdgeInsets.symmetric(horizontal: defaultMargin),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(12),
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               blurRadius: 12,
//               offset: Offset(0, 5),
//               color: Colors.black.withOpacity(0.1),
//             ),
//           ],
//         ),
//         child: (_currentPosition != null)
//             ? Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   AutoSizeText(
//                     'Alamat Tujuan',
//                     style: accentFontBlackRegular.copyWith(
//                       fontSize: 12,
//                       color: accentColor4,
//                     ),
//                   ),
//                   SizedBox(height: height * verticalMarginHalf),
//                   AutoSizeText(
//                     (locationState is LoadSelectedLocation)
//                         ? locationState.address!
//                         // ? 'Jl. Tamalate VII No.8, Bonto Makkio, Kec. Rappocini, Kota Makassar, Sulawesi Selatan 90222'
//                         : '',
//                     style: accentFontBlackBold.copyWith(
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               )
//             : Center(
//                 child: (!_isBTNCurrentLoc)
//                     ? AutoSizeText(
//                         'Tentukan Lokasi Pengiriman',
//                         maxLines: 1,
//                         style: mainFontBlackBold.copyWith(
//                           fontSize: 18,
//                           color: accentColor4,
//                         ),
//                       )
//                     : SpinKitRing(color: accentColor2, size: 24),
//               ),
//       ),
//     );
//   }

//   Widget _bottomSheetWidget() {
//     return SafeArea(
//       child: AnimatedOpacity(
//         opacity: _isVisible ? 1.0 : 1.0,
//         duration: Duration(
//           milliseconds: _btnDurationOpacity,
//         ),
//         child: Container(
//           width: double.infinity,
//           child: GestureDetector(
//             onTap: () {
//               print('tapeddd');
//             },
//             onVerticalDragUpdate: (details) {
//               int sensitivity = 8;
//               if (details.delta.dy > sensitivity) {
//                 print('-------- down');
//                 setState(() {
//                   _isDetailDeliveryDataWidgetVisible = true;
//                   _isOutletIsFullWidgetVisible = true;
//                 });
//               }
//             },
//             child: Column(
//               children: [
//                 Spacer(),
//                 if (_isOutletReadyToDelivery) _buildDetailDeliveryData(),
//                 if (_isOutletOutOfDistance) _buildOutOfDistanceOutletWidget(),
//                 if (_isOutletFull) _buildOutletIsFullWidget(),
//                 if (_isDistanceNearOutlet) _buildOutletIsNearWidget(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   bool _isOutletIsFullWidgetVisible = false;
//   bool _isOutletIsFullWidgetVisibleNoSpace = false;

//   Widget _buildOutletIsFullWidget() {
//     var height = MediaQuery.of(context).size.height;

//     return Stack(
//       children: [
//         _buildOutletIsFullSwipeDownWidget(),
//         Visibility(
//           visible: !_isOutletIsFullWidgetVisibleNoSpace,
//           child: AnimatedOpacity(
//             opacity: _isOutletIsFullWidgetVisible ? 0.0 : 1.0,
//             duration: Duration(
//               milliseconds: _btnDurationOpacity,
//             ),
//             onEnd: () {
//               setState(() {
//                 _isOutletIsFullWidgetVisibleNoSpace = true;
//               });
//             },
//             child: BlocBuilder<SelectedLocationBloc, SelectedLocationState>(
//               builder: (_, locationState) => Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(24),
//                     topRight: Radius.circular(24),
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: defaultMargin,
//                       ),
//                       child: Column(
//                         children: [
//                           SizedBox(height: height * verticalMarginHalf),
//                           _swipeDownUpLine(),
//                           SizedBox(height: height * verticalMargin),
//                           Container(
//                             padding: const EdgeInsets.fromLTRB(
//                               defaultMargin,
//                               defaultMargin / 2,
//                               defaultMargin,
//                               defaultMargin / 2,
//                             ),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(12),
//                               border: Border.all(color: outlineColor),
//                             ),
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 AutoSizeText(
//                                   'Alamat Tujuan',
//                                   style: accentFontBlackRegular.copyWith(
//                                     fontSize: 12,
//                                     color: accentColor4,
//                                   ),
//                                 ),
//                                 SizedBox(height: height * verticalMarginHalf),
//                                 AutoSizeText(
//                                   (locationState is LoadSelectedLocation)
//                                       ? locationState.address!
//                                       // 'Jl. Tamalate VII No.8, Bonto Makkio, Kec. Rappocini, Kota Makassar, Sulawesi Selatan 90222',
//                                       : '',
//                                   style: accentFontBlackBold.copyWith(
//                                     fontSize: 18,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           _buildAddressAndNearestOutletWidget(),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: height * verticalMargin),
//                     Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: defaultMargin,
//                       ),
//                       child: AutoSizeText(
//                         'Antrian delivery lagi\nbanyak, nih.',
//                         style: mainFontBlackBold.copyWith(
//                           fontSize: 24,
//                           color: accentColor4,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: height * verticalMarginHalf),
//                     (!_isNoRecomendedOutlet)
//                         ? Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: defaultMargin,
//                             ),
//                             child: RichText(
//                               text: TextSpan(
//                                 text:
//                                     'Biar cepat, pesan dari outlet terdekat lain yuk. Atau kamu bisa ',
//                                 style: accentFontBlackRegular.copyWith(
//                                   fontSize: 14,
//                                   color: accentColor4,
//                                 ),
//                                 children: [
//                                   TextSpan(
//                                     text: 'pesan Pre-order',
//                                     style: accentFontBlackBold.copyWith(
//                                       fontSize: 14,
//                                       color: ThemeColor.mainColor,
//                                     ),
//                                     recognizer: TapGestureRecognizer()
//                                       ..onTap = () => _onPressedPreOrderText(),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           )
//                         : Padding(
//                             padding: const EdgeInsets.symmetric(
//                               horizontal: defaultMargin,
//                             ),
//                             child: AutoSizeText(
//                               'Coba lagi nanti ya. Kalau mau sekarang, kamu bisa pesan melalui pre-order',
//                               style: accentFontBlackRegular.copyWith(
//                                 fontSize: 14,
//                                 color: accentColor4,
//                               ),
//                               maxLines: 3,
//                             ),
//                           ),
//                     SizedBox(height: height * verticalMargin),
//                     if (!_isNoRecomendedOutlet)
//                       Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: defaultMargin,
//                         ),
//                         child: AutoSizeText(
//                           'Outlet terdekat lain:',
//                           style: accentFontBlackBold.copyWith(
//                             fontSize: 12,
//                           ),
//                         ),
//                       ),
//                     if (!_isNoRecomendedOutlet)
//                       SizedBox(height: height * verticalMarginHalf),
//                     if (!_isNoRecomendedOutlet)
//                       Container(
//                         height: height * .08,
//                         child: ListView.builder(
//                           itemCount:
//                               nearestOutletRecommendationAfterSort.length,
//                           scrollDirection: Axis.horizontal,
//                           itemBuilder: (_, index) {
//                             var e = nearestOutletRecommendationAfterSort[index];

//                             return GestureDetector(
//                               onTap: () {
//                                 setState(() {
//                                   _selectedRecomendedOutlet = e.outlet!;
//                                 });
//                               },
//                               child: ButtonRecommendedOutlet(
//                                 isSelected:
//                                     e.outlet! == _selectedRecomendedOutlet,
//                                 distance: "${e.distance!} km",
//                                 outletName: e.outlet!,
//                                 margin: (index == 0)
//                                     ? EdgeInsets.only(
//                                         left: defaultMargin,
//                                         right: defaultMargin / 2,
//                                       )
//                                     : (index ==
//                                             nearestOutletRecommendation.length -
//                                                 1)
//                                         ? EdgeInsets.only(right: defaultMargin)
//                                         : EdgeInsets.only(
//                                             right: defaultMargin / 2),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     SizedBox(height: height * verticalMargin),
//                     Padding(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: defaultMargin,
//                         ),
//                         child: (!_isNoRecomendedOutlet)
//                             ? _btnChangeOutlet()
//                             : _btnTryPreOrder()),
//                     SizedBox(height: height * verticalMargin),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _buildOutletIsNearWidget() {
//     var height = MediaQuery.of(context).size.height;

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(24),
//           topRight: Radius.circular(24),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: defaultMargin,
//         ),
//         child: Column(
//           children: [
//             SizedBox(height: height * verticalMargin),
//             AutoSizeText(
//               'Anda berada dekat dari\ndari outlet',
//               style: mainFontBlackBold.copyWith(
//                 fontSize: 24,
//                 color: accentColor4,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: height * verticalMarginHalf),
//             AutoSizeText(
//               'Jarak untuk memesan delivery harus\ndiatas 100 meter',
//               style: accentFontBlackRegular.copyWith(
//                 fontSize: 14,
//                 color: accentColor4,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: height * verticalMargin),
//             _btnTryPreOrder(),
//             SizedBox(height: height * verticalMargin),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOutletIsFullSwipeDownWidget() {
//     var height = MediaQuery.of(context).size.height;

//     return Visibility(
//       visible: _isOutletIsFullWidgetVisibleNoSpace,
//       child: AnimatedOpacity(
//         opacity: !_isOutletIsFullWidgetVisible ? 0.0 : 1.0,
//         duration: Duration(
//           milliseconds: _btnDurationOpacity,
//         ),
//         onEnd: () {
//           setState(() {
//             _isOutletIsFullWidgetVisibleNoSpace = false;
//           });
//         },
//         child: GestureDetector(
//           onVerticalDragUpdate: (details) {
//             int sensitivity = 8;

//             if (details.delta.dy < -sensitivity) {
//               print('-------- up');
//               setState(() {
//                 _isOutletIsFullWidgetVisibleNoSpace = false;
//                 _isOutletIsFullWidgetVisible = false;
//               });
//             }
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(24),
//                 topRight: Radius.circular(24),
//               ),
//             ),
//             child: Column(
//               children: [
//                 SizedBox(height: height * verticalMarginHalf),
//                 _swipeDownUpLine(),
//                 SizedBox(height: height * verticalMargin),
//                 AutoSizeText(
//                   'Antrian delivery lagi\nbanyak, nih.',
//                   style: mainFontBlackBold.copyWith(
//                     fontSize: 24,
//                     color: ThemeColor.mainColor,
//                   ),
//                   textAlign: TextAlign.center,
//                 ),
//                 SizedBox(height: height * verticalMargin),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void _onPressedPreOrderText() async {
//     LatLngInitialLocation firstOutlet =
//         await OutletServices.getFirstOutletOnSelectedCity(_city);

//     context.read<GeolocationBloc>().add(DistanceToinitial());
//     context.read<OrderTypeBloc>().add(PreOrder());
//     context.read<PickupTimeBloc>().add(GetPickUpTime());
//     context.read<ListOutletBloc>().add(GetListOutlet(_city));
//     context.read<PageBloc>().add(
//           GoToSelectOutletPreorder(
//             _city,
//             'Pre-Order',
//             firstOutlet,
//           ),
//         );
//   }

//   Widget _buildOutOfDistanceOutletWidget() {
//     var height = MediaQuery.of(context).size.height;

//     return Container(
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(24),
//           topRight: Radius.circular(24),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: defaultMargin,
//         ),
//         child: Column(
//           children: [
//             SizedBox(height: height * verticalMargin),
//             AutoSizeText(
//               'Waah kejauhan...',
//               style: mainFontBlackBold.copyWith(
//                 fontSize: 24,
//                 color: accentColor4,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: height * verticalMarginHalf / 2),
//             AutoSizeText(
//               'Biar nggak nunggu lama, jarak pengantaran maksimal 7 km dari outlet',
//               style: accentFontBlackRegular.copyWith(
//                 fontSize: 14,
//                 color: accentColor4,
//               ),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: height * verticalMargin),
//             _btnBackToHome(),
//             SizedBox(height: height * verticalMargin),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildAddressAndNearestOutletWidget() {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;

//     return Container(
//       height: height * .17,
//       width: double.infinity,
//       // color: Colors.red,
//       child: Row(
//         children: [
//           Column(
//             children: [
//               Container(
//                 // color: Colors.green,
//                 width: height * .05,
//                 height: height * .1,
//                 child: Stack(
//                   children: [
//                     Align(
//                       alignment: Alignment.center,
//                       child: Container(
//                         width: 1,
//                         height: height * .1,
//                         color: outlineColor,
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.center,
//                       child: Container(
//                         height: height * .013,
//                         width: height * .013,
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: outlineColor,
//                         ),
//                       ),
//                     ),
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: Container(
//                         width: height * .025,
//                         height: 1,
//                         color: outlineColor,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Container(
//                 // color: Colors.blue,
//                 width: height * .07,
//                 height: height * .07,
//                 child: ClipRRect(
//                   borderRadius: BorderRadius.circular(12),
//                   child: Image(
//                     image: AssetImage('assets/outlet_icon.png'),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(width: width * horizontalMarginHalf),
//           Column(
//             children: [
//               Container(
//                 height: height * .1,
//                 // color: Colors.amber,
//                 width: width * .68,
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Row(
//                     children: [
//                       AutoSizeText(
//                         'Jarak: ',
//                         style: accentFontBlackRegular.copyWith(
//                           fontSize: 12,
//                           color: accentColor4,
//                         ),
//                       ),
//                       AutoSizeText(
//                         ' $_nearestOutletDistance',
//                         // '12',
//                         style: accentFontBlackBold.copyWith(
//                           fontSize: 12,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 height: height * .07,
//                 // color: Colors.blueAccent,
//                 width: width * .68,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     AutoSizeText(
//                       'Outlet Terdekat',
//                       style: accentFontBlackRegular.copyWith(
//                         fontSize: 12,
//                         color: accentColor4,
//                       ),
//                     ),
//                     AutoSizeText(
//                       '$_nearestOutletName',
//                       // 'Cendrawasih',
//                       style: accentFontBlackBold.copyWith(
//                         fontSize: 18,
//                         color: ThemeColor.mainColor,
//                       ),
//                       maxLines: 1,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }

//   bool _isDetailDeliveryDataWidgetVisible = false;
//   bool _isDetailDeliveryDataWidgetVisibleNoSpace = false;

//   Widget _buildDetailDeliveryData() {
//     var height = MediaQuery.of(context).size.height;

//     return Stack(
//       children: [
//         Visibility(
//           visible: !_isDetailDeliveryDataWidgetVisibleNoSpace,
//           child: AnimatedOpacity(
//             opacity: _isDetailDeliveryDataWidgetVisible ? 0.0 : 1.0,
//             duration: Duration(
//               milliseconds: _btnDurationOpacity,
//             ),
//             onEnd: () {
//               setState(() {
//                 _isDetailDeliveryDataWidgetVisibleNoSpace = true;
//               });
//             },
//             child: BlocBuilder<SelectedLocationBloc, SelectedLocationState>(
//               builder: (_, locationState) => Container(
//                 padding: const EdgeInsets.symmetric(
//                   horizontal: defaultMargin,
//                 ),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(24),
//                     topRight: Radius.circular(24),
//                   ),
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Column(
//                       children: [
//                         SizedBox(height: height * verticalMarginHalf),
//                         _swipeDownUpLine(),
//                         SizedBox(height: height * verticalMargin),
//                         Container(
//                           padding: const EdgeInsets.fromLTRB(
//                             defaultMargin,
//                             defaultMargin / 2,
//                             defaultMargin,
//                             defaultMargin / 2,
//                           ),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: outlineColor),
//                           ),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               AutoSizeText(
//                                 'Alamat Tujuan',
//                                 style: accentFontBlackRegular.copyWith(
//                                   fontSize: 12,
//                                   color: accentColor4,
//                                 ),
//                               ),
//                               SizedBox(height: height * verticalMarginHalf),
//                               AutoSizeText(
//                                 (locationState is LoadSelectedLocation)
//                                     ? locationState.address!
//                                     // 'Jl. Tamalate VII No.8, Bonto Makkio, Kec. Rappocini, Kota Makassar, Sulawesi Selatan 90222',
//                                     : '',
//                                 style: accentFontBlackBold.copyWith(
//                                   fontSize: 18,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         _buildAddressAndNearestOutletWidget(),
//                       ],
//                     ),
//                     SizedBox(height: height * verticalMargin),
//                     Container(
//                       padding: const EdgeInsets.fromLTRB(
//                         defaultMargin,
//                         defaultMargin / 2,
//                         defaultMargin,
//                         defaultMargin / 2,
//                       ),
//                       decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(12),
//                         border: Border.all(color: outlineColor),
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           AutoSizeText(
//                             'Ongkir',
//                             style: accentFontBlackBold.copyWith(
//                               fontSize: 12,
//                               color: accentColor4,
//                             ),
//                           ),
//                           AutoSizeText(
//                             '$_deliveryFee.000',
//                             style: accentFontBlackBold.copyWith(
//                               fontSize: 16,
//                               color: ThemeColor.mainColor,
//                             ),
//                             maxLines: 1,
//                           ),
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: height * verticalMarginHalf),
//                     AutoSizeText(
//                       'Dapatkan diskon ongkir minimal pembelian 60.000',
//                       style: accentFontBlackRegular.copyWith(
//                         fontSize: 12,
//                         color: accentColor4,
//                       ),
//                     ),
//                     SizedBox(height: height * verticalMargin),
//                     _btnContinue(),
//                     SizedBox(height: height * verticalMargin),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ),
//         _buildDetailDeliveryDataSwipeDown(),
//       ],
//     );
//   }

//   Widget _buildDetailDeliveryDataSwipeDown() {
//     var height = MediaQuery.of(context).size.height;
//     var width = MediaQuery.of(context).size.width;

//     return Visibility(
//       visible: _isDetailDeliveryDataWidgetVisibleNoSpace,
//       child: AnimatedOpacity(
//         opacity: !_isDetailDeliveryDataWidgetVisible ? 0.0 : 1.0,
//         duration: Duration(
//           milliseconds: _btnDurationOpacity,
//         ),
//         onEnd: () {
//           setState(() {
//             _isDetailDeliveryDataWidgetVisibleNoSpace = false;
//           });
//         },
//         child: GestureDetector(
//           onVerticalDragUpdate: (details) {
//             int sensitivity = 8;

//             if (details.delta.dy < -sensitivity) {
//               print('-------- up');
//               setState(() {
//                 _isDetailDeliveryDataWidgetVisibleNoSpace = false;
//                 _isDetailDeliveryDataWidgetVisible = false;
//                 // _isOutletReadyToDelivery = true;
//                 // _isDetailDeliveryDataWidgetVisibleNoSpace = false;
//               });
//             }
//           },
//           child: Container(
//             padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(24),
//                 topRight: Radius.circular(24),
//               ),
//             ),
//             child: Column(
//               children: [
//                 SizedBox(height: height * verticalMarginHalf),
//                 _swipeDownUpLine(),
//                 SizedBox(height: height * verticalMargin),
//                 Row(
//                   children: [
//                     Container(
//                       // color: Colors.blue,
//                       width: height * .07,
//                       height: height * .07,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(12),
//                         child: Image(
//                           image: AssetImage('assets/outlet_icon.png'),
//                         ),
//                       ),
//                     ),
//                     SizedBox(width: width * horizontalMarginHalf),
//                     Container(
//                       height: height * .07,
//                       // color: Colors.blueAccent,
//                       width: width * .68,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           AutoSizeText(
//                             'Outlet Terdekat',
//                             style: accentFontBlackRegular.copyWith(
//                               fontSize: 12,
//                               color: accentColor4,
//                             ),
//                           ),
//                           AutoSizeText(
//                             '$_nearestOutletName',
//                             // 'Cendrawasih',
//                             style: accentFontBlackBold.copyWith(
//                               fontSize: 18,
//                               color: ThemeColor.mainColor,
//                             ),
//                             maxLines: 1,
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: height * verticalMargin),
//                 Container(
//                   padding: const EdgeInsets.fromLTRB(
//                     defaultMargin,
//                     defaultMargin / 2,
//                     defaultMargin,
//                     defaultMargin / 2,
//                   ),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(color: outlineColor),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       AutoSizeText(
//                         'Ongkir',
//                         style: accentFontBlackBold.copyWith(
//                           fontSize: 12,
//                           color: accentColor4,
//                         ),
//                       ),
//                       AutoSizeText(
//                         '$_deliveryFee.000',
//                         style: accentFontBlackBold.copyWith(
//                           fontSize: 16,
//                           color: ThemeColor.mainColor,
//                         ),
//                         maxLines: 1,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: height * verticalMargin),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _swipeDownUpLine() {
//     var height = MediaQuery.of(context).size.height;

//     return Container(
//       margin: const EdgeInsets.symmetric(horizontal: defaultMargin * 5),
//       height: height * .005,
//       decoration: BoxDecoration(
//         color: outlineColor,
//         borderRadius: BorderRadius.circular(24),
//       ),
//     );
//   }

//   Widget _btnChangeOutlet() {
//     return AnimatedOpacity(
//       opacity: _isVisible ? 0.0 : 1.0,
//       duration: Duration(milliseconds: _btnDurationOpacity),
//       child: (_selectedRecomendedOutlet != '')
//           ? GlobalButton(
//               title: 'Ganti Outlet',
//               onTapFunc: () async {
//                 context
//                     .read<QueueOrderCheckBloc>()
//                     .add(CheckQeueOrderToInitial());

//                 setState(() {
//                   _nearestOutletName = _selectedRecomendedOutlet;
//                   _isVisible = _isVisible;
//                   _isLoadingNearestOutlet = true;
//                   _isMarkerDraggable = false;
//                   _isDistanceNear = _distanceCheck();
//                   _isLoadingNearestOutlet = false;
//                 });

//                 await _getOtherRecomendedOutlet();

//                 context.read<QueueOrderCheckBloc>().add(
//                       CheckQueueOrder(_nearestOutletName),
//                     );
//               },
//             )
//           : GlobalButton(
//               isButtonSolidColor: true,
//               buttonSolidColor: accentColor5,
//               title: 'Ganti Outlet',
//               textColor: Colors.white,
//               isBorder: false,
//               borderColor: Colors.transparent,
//             ),
//     );
//   }

//   Widget _btnCurrentLocation() {
//     return AnimatedOpacity(
//       opacity: _isVisible ? 1.0 : 0.0,
//       duration: Duration(milliseconds: _btnDurationOpacity),
//       child: (!_isBTNCurrentLoc)
//           ? GlobalButton(
//               margin: EdgeInsets.symmetric(horizontal: defaultMargin),
//               title: 'Cari Lokasimu Sekarang',
//               onTapFunc: (!_isBTNCurrentLoc)
//                   ? () async {
//                       setState(() {
//                         _isBTNCurrentLoc = true;
//                       });

//                       await _getCurrentLocation().then((value) {
//                         setState(() {
//                           _isBTNCurrentLoc = false;
//                         });
//                       });

//                       setState(() {
//                         _isQuickTipVisible = true;
//                       });

//                       context.read<SelectedLocationBloc>().add(
//                             SetSelectedLocation(
//                               address: _address,
//                               city: _city,
//                             ),
//                           );
//                     }
//                   : () {},
//             )
//           : GlobalButton(
//               isButtonSolidColor: true,
//               buttonSolidColor: accentColor5,
//               title: 'Cari Lokasimu Sekarang',
//               margin: EdgeInsets.symmetric(horizontal: defaultMargin),
//               textColor: Colors.white,
//               isBorder: false,
//               borderColor: Colors.transparent,
//             ),
//     );
//   }

//   Widget _btnBackToHome() {
//     return AnimatedOpacity(
//       opacity: _isVisible ? 0.0 : 1.0,
//       duration: Duration(milliseconds: _btnDurationOpacity),
//       child: GlobalButton(
//         title: 'Ganti Lokasi',
//         onTapFunc: () => _resetState(),
//       ),
//     );
//   }

//   Widget _btnTryPreOrder() {
//     return AnimatedOpacity(
//       opacity: _isVisible ? 0.0 : 1.0,
//       duration: Duration(milliseconds: _btnDurationOpacity),
//       child: GlobalButton(
//         title: 'Pesan Pre-Order',
//         onTapFunc: () => _onPressedPreOrderText(),
//       ),
//     );
//   }

//   Widget _btnContinue() {
//     return AnimatedOpacity(
//       opacity: _isVisible ? 1.0 : 1.0,
//       duration: Duration(milliseconds: _btnDurationOpacity),
//       child: GlobalButton(
//         title: 'Lanjutkan',
//         onTapFunc: () async {
//           if (_isDistanceNear) {
//             var _deliveryOrderData = DeliveryOrderData(
//               address: _address,
//               distance: _nearestOutletDistance,
//               outlet: _nearestOutletName,
//               selectedLocationLat: _currentPosition!.latitude,
//               selectedLocationLng: _currentPosition!.longitude,
//               deliveryFee: _deliveryFee.toString(),
//               orderType: 'Delivery',
//             );

//             context.read<VariantListBloc>().add(GetVariantList());
//             context.read<AllMenuBloc>().add(AllMenuToInitial());
//             context.read<AllMenuBloc>().add(GetAllMenu(_nearestOutletName));
//             context.read<PageBloc>().add(
//                   GoToSelectMenuPage(
//                     'Dingin',
//                     'Semua Menu',
//                     deliveryOrderData: _deliveryOrderData,
//                   ),
//                 );
//           }
//         },
//       ),
//     );
//   }

//   Widget _btnGetNearestOutlet() {
//     return AnimatedOpacity(
//       opacity: _isVisible ? 1.0 : 0.0,
//       duration: Duration(milliseconds: _btnDurationOpacity),
//       child: BlocBuilder<QueueOrderCheckBloc, QueueOrderCheckState>(
//         builder: (_, outletStatus) => GlobalButton(
//           onTapFunc: (!_isLoadingNearestOutlet)
//               ? () async {
//                   bool _isCityAvailable =
//                       await LocationServices.outletCityAvailableCheck(_city);

//                   print('city available = ' + _isCityAvailable.toString());

//                   if (_isCityAvailable == false) {
//                     setState(() {
//                       _isVisible = !_isVisible;
//                       _isLoadingNearestOutlet = true;
//                       _isMarkerDraggable = false;
//                       _isDistanceNear = false;
//                       _isLoadingNearestOutlet = false;
//                     });
//                   } else {
//                     NearestOutlet _nearestOutlet = await _getNearestOutlet(
//                       _city,
//                     );

//                     setState(() {
//                       _nearestOutletName = _nearestOutlet.outletName;
//                       _isVisible = !_isVisible;
//                       _isLoadingNearestOutlet = true;
//                       _isMarkerDraggable = false;
//                       _isDistanceNear = _distanceCheck();
//                       _isLoadingNearestOutlet = false;
//                     });

//                     context.read<QueueOrderCheckBloc>().add(
//                           CheckQueueOrder(_nearestOutletName),
//                         );

//                     print('#######' + _nearestOutletName!);

//                     for (var doc in nearestOutletRecommendation) {
//                       if (doc.outlet != _nearestOutletName!) {
//                         if (doc.distance! < 7) {
//                           nearestOutletRecommendationAfterSort.add(
//                             NearestOutletRecommendation(
//                               distance: doc.distance,
//                               outlet: doc.outlet,
//                             ),
//                           );
//                         }
//                       }
//                     }

//                     if (nearestOutletRecommendationAfterSort.isEmpty) {
//                       setState(() {
//                         _isNoRecomendedOutlet = true;
//                       });
//                     } else {
//                       setState(() {
//                         _isNoRecomendedOutlet = false;
//                       });
//                     }

//                     print('cek jarak = ' + _isDistanceNear.toString());
//                     print('outlet terdekat = $_nearestOutletName');
//                   }

//                   if (!_isDistanceNearOutlet) {
//                     if (_isDistanceNear) {
//                       if (outletStatus is QueueDeliveryOrderStatus) {
//                         if (!outletStatus.isFull) {
//                           print('outlet full');
//                           setState(() {
//                             _isOutletFull = true;
//                           });
//                         } else {
//                           print('outlet ready');
//                           setState(() {
//                             _isOutletReadyToDelivery = true;
//                           });
//                         }
//                       } else {
//                         setState(() {
//                         });
//                       }
//                     } else {
//                       print('outlet out of distance');
//                       setState(() {
//                         _isOutletOutOfDistance = true;
//                       });
//                     }
//                   } else {}
//                 }
//               : () {
//                   print('loading . . . . . . .');
//                 },
//           isButtonSolidColor: true,
//           isBorder: (_isLoadingNearestOutlet) ? false : true,
//           borderColor: Colors.transparent,
//           buttonSolidColor: (_isLoadingNearestOutlet) ? accentColor5 : null,
//           margin: EdgeInsets.symmetric(horizontal: defaultMargin),
//           textColor: Colors.white,
//           title: (!_isLoadingNearestOutlet)
//               ? 'Konfirmasi Lokasi'
//               : 'Mencari Outlet Terdekat...',
//         ),
//       ),
//     );
//   }

//   Widget _buildGoogleMapsWidget() {
//     return GoogleMap(
//       initialCameraPosition: _initialCameraPosition,
//       myLocationButtonEnabled: false,
//       myLocationEnabled: false,
//       zoomGesturesEnabled: true,
//       zoomControlsEnabled: false,
//       polylines: {
//         if (_directions != null && _isDistanceNear)
//           Polyline(
//             polylineId: PolylineId('overview_polyline'),
//             color: accentColor3,
//             width: 5,
//             points: _directions!.polylinePoints
//                 .map((e) => LatLng(e.latitude, e.longitude))
//                 .toList(),
//           ),
//       },
//       markers: {
//         if (_nearestOutlet != null && _isDistanceNear) _nearestOutlet!,
//         if (_deliveryPoint != null) _deliveryPoint!,
//       },
//       mapType: MapType.normal,
//       onMapCreated: (GoogleMapController controller) {
//         _controllerGoogleMaps.complete(controller);
//         _mapController = controller;
//       },
//     );
//   }

//   Widget _backCircleWidget() {
//     var height = MediaQuery.of(context).size.height;

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         GestureDetector(
//           onTap: () async => _backButtonPressed(),
//           child: Container(
//             height: height * .06,
//             width: height * .06,
//             margin: EdgeInsets.only(left: defaultMargin),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               boxShadow: [
//                 _iconBoxShadow,
//               ],
//               color: Colors.white,
//             ),
//             child: Center(
//               child: Icon(Icons.arrow_back, color: ThemeColor.mainColor),
//             ),
//           ),
//         ),
//         if (_currentPosition != null)
//           GestureDetector(
//             onTap: () => _resetState(),
//             child: Container(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: defaultMargin,
//               ),
//               margin: EdgeInsets.only(right: defaultMargin),
//               height: height * .06,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 boxShadow: [
//                   _iconBoxShadow,
//                 ],
//                 color: Colors.white,
//               ),
//               child: Center(
//                 child: Text(
//                   'Ubah Lokasi',
//                   style: mainFontBlackBold.copyWith(
//                     fontSize: 18,
//                     color: ThemeColor.mainColor,
//                   ),
//                 ),
//               ),
//             ),
//           )
//         else
//           GestureDetector(
//             onTap: () async {
//               setState(() {
//                 _isBTNCurrentLoc = true;
//               });

//               await _getCurrentLocation().then((value) {
//                 setState(() {
//                   _isBTNCurrentLoc = false;
//                 });
//               });

//               context.read<SelectedLocationBloc>().add(
//                     SetSelectedLocation(
//                       address: _address,
//                       city: _city,
//                     ),
//                   );
//             },
//             child: Container(
//               height: height * .06,
//               width: height * .06,
//               margin: EdgeInsets.only(right: defaultMargin),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 boxShadow: [
//                   _iconBoxShadow,
//                 ],
//                 color: Colors.white,
//               ),
//               child: Center(
//                 child: Icon(
//                   Icons.location_searching_outlined,
//                   color: ThemeColor.mainColor,
//                   size: 22,
//                 ),
//               ),
//             ),
//           ),
//       ],
//     );
//   }

//   Future _getCurrentLocation() async {
//     print('getting location');

//     try {
//       await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best,
//       ).then((Position position) async {
//         List<Placemark> _listPlacemark = [];

//         setState(() {
//           _currentPosition = position;

//           print('CURRENT POS: $_currentPosition');

//           _mapController.animateCamera(
//             CameraUpdate.newCameraPosition(
//               CameraPosition(
//                 target: LatLng(position.latitude, position.longitude),
//                 zoom: 18,
//               ),
//             ),
//           );

//           _deliveryPoint = Marker(
//             markerId: MarkerId('Set Delivery Point'),
//             infoWindow: const InfoWindow(title: 'Set Delivery Point'),
//             icon: _userCustomMarker,
//             position: LatLng(
//               _currentPosition!.latitude,
//               _currentPosition!.longitude,
//             ),
//             draggable: _isMarkerDraggable,
//             onDragEnd: ((onDrag) async {
//               _currentPosition = Position(
//                 speed: 0.0,
//                 altitude: 0.0,
//                 heading: 0.0,
//                 accuracy: 0.0,
//                 speedAccuracy: 0.0,
//                 timestamp: null,
//                 latitude: onDrag.latitude,
//                 longitude: onDrag.longitude,
//               );

//               _listPlacemark = await placemarkFromCoordinates(
//                 _currentPosition!.latitude,
//                 _currentPosition!.longitude,
//               );

//               Placemark _selectedCity = _listPlacemark[0];

//               var p = _selectedCity;
//               var city = '${p.locality!.split(' ')[1]}';
//               var city2 = '${p.subAdministrativeArea!.split(' ')[1]}';

//               print(
//                 'alamattttts = ${p.street}, ${p.subLocality}, $city, ${p.subAdministrativeArea}',
//               );

//               bool _checkCity =
//                   await LocationServices.outletCityAvailableCheck(city);

//               if (_checkCity == true) {
//                 _city = city;
//                 _address = '${p.street}, ${p.subLocality}, $city';

//                 context.read<SelectedLocationBloc>().add(
//                       SetSelectedLocation(
//                         address: _address,
//                         city: city,
//                       ),
//                     );
//               } else {
//                 _city = city2;
//                 _address = '${p.street}, ${p.subLocality}, $city';

//                 context.read<SelectedLocationBloc>().add(
//                       SetSelectedLocation(
//                         address: _address,
//                         city: city2,
//                       ),
//                     );
//               }
//             }),
//           );
//         });

//         _listPlacemark = await placemarkFromCoordinates(
//           _currentPosition!.latitude,
//           _currentPosition!.longitude,
//         );

//         Placemark _selectedCity = _listPlacemark[0];

//         var p = _selectedCity;
//         // beberapa platform tidak bisa membaca jika menggunakan ini
//         var city = '${p.locality!.split(' ')[1]}';
//         // untuk antisipasi
//         var city2 = '${p.subAdministrativeArea!.split(' ')[1]}';
//         print(
//             'alamattttts = ${p.street}, ${p.subLocality}, $city, ${p.subAdministrativeArea}');
//         print('kota: ' + city);

//         bool _checkCity = await LocationServices.outletCityAvailableCheck(city);
//         print('isCityAvailable = ' + _checkCity.toString());

//         if (_checkCity == true) {
//           setState(() {
//             _city = city;
//             _address = '${p.street}, ${p.subLocality}, $city';
//           });

//           context.read<SelectedLocationBloc>().add(
//                 SetSelectedLocation(
//                   address: _address,
//                   city: city,
//                 ),
//               );
//         } else {
//           setState(() {
//             _city = city2;
//             _address = '${p.street}, ${p.subLocality}, $city';
//           });

//           context.read<SelectedLocationBloc>().add(
//                 SetSelectedLocation(
//                   address: _address,
//                   city: city2,
//                 ),
//               );
//         }
//       }).catchError((e) {
//         print('tidak bisa mengambil lokasi, karena: $e');
//       });
//     } catch (e) {
//       print(e);
//     }
//   }

//   void _setMarker(LatLng pos) async {
//     if (_deliveryPoint != null ||
//         _deliveryPoint == null && _nearestOutlet == null) {
//       setState(() {
//         _nearestOutlet = Marker(
//           markerId: MarkerId('destination'),
//           infoWindow: const InfoWindow(title: 'Destination'),
//           icon: _nearestOutletCustomMarker,
//           position: pos,
//         );
//       });

//       final direction = await LocationServices().getDirections(
//         origin: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
//         destination: _nearestOutlet!.position,
//       );

//       setState(() {
//         if (_isDistanceNear) {
//           _directions = direction;
//         } else {
//           _directions = null;
//         }
//       });

//       _mapController.animateCamera(
//         _directions != null
//             ? CameraUpdate.newLatLngBounds(_directions!.bounds, 80)
//             : CameraUpdate.newCameraPosition(_initialCameraPosition),
//       );
//     }
//   }

//   bool _isDistanceNearOutlet = false;

//   Future<NearestOutlet> _getNearestOutlet(String city) async {
//     nearestOutletRecommendation = [];
//     nearestOutletRecommendationAfterSort = [];

//     setState(() {
//       _isLoadingNearestOutlet = true;
//       _selectedRecomendedOutlet = '';
//     });

//     List<NearestOutlet> _listOutlet =
//         await LocationServices.getListOfNearestOutlet(city);

//     Directions? _directionList;
//     List<double> _listOfDistance = [];

//     for (var doc in _listOutlet) {
//       _directionList = await LocationServices()
//           .getDirections(
//         origin: LatLng(
//           _currentPosition!.latitude,
//           _currentPosition!.longitude,
//         ),
//         destination: LatLng(doc.latitude!, doc.longitude!),
//       )
//           .timeout(Duration(seconds: 10), onTimeout: () {
//         print('eror timeout 2');

//         _resetState();

//         Flushbar(
//           duration: Duration(seconds: 2),
//           flushbarPosition: FlushbarPosition.TOP,
//           backgroundColor: flushColor,
//           animationDuration: Duration(milliseconds: flushAnimationDuration),
//           message: 'Terjadi kesalahan, silahkan coba lagi',
//         )..show(context);

//         return _directionList = null;
//       });

//       var _totalDistance = double.parse(
//         _directionList!.totalDistance!.split(' ')[0],
//       );

//       print('outlet = ' + _directionList!.totalDistance!);

//       _listOfDistance.add(_totalDistance);

//       nearestOutletRecommendation.add(NearestOutletRecommendation(
//         distance: _totalDistance,
//         outlet: doc.outletName,
//       ));
//     }

//     double _nearestDistance = _listOfDistance.reduce(min).toDouble();
//     int _indexOfNearestDistance = _listOfDistance.indexOf(_nearestDistance);

//     print('index ke-' + _indexOfNearestDistance.toString());

//     _setMarker(
//       LatLng(
//         _listOutlet[_indexOfNearestDistance].latitude!,
//         _listOutlet[_indexOfNearestDistance].longitude!,
//       ),
//     );

//     if (_directionList!.totalDistance!.split(' ')[1] == 'km') {
//       setState(() {
//         _nearestOutletDistance = '$_nearestDistance km';
//       });
//     } else if (_directionList!.totalDistance!.split(' ')[1] == 'm') {
//       int _metersRounded = _nearestDistance.round();

//       setState(() {
//         _nearestOutletDistance = '$_metersRounded m';
//       });

//       if (_metersRounded < 100) {
//         setState(() {
//           _isDistanceNearOutlet = true;
//         });
//       }
//     }

//     return _listOutlet[_indexOfNearestDistance];
//   }

//   Future<void> _getOtherRecomendedOutlet() async {
//     setState(() {
//       _isOutletFull = false;
//       _isVisible = _isVisible;
//     });

//     Directions? _directionList;

//     OtherRecommendedOutlet? otherRecommendedOutlet =
//         await DeliveryService.getRecommendedOutetData(
//       _selectedRecomendedOutlet,
//     );

//     _directionList = await LocationServices()
//         .getDirections(
//       origin: LatLng(
//         _currentPosition!.latitude,
//         _currentPosition!.longitude,
//       ),
//       destination: LatLng(
//         otherRecommendedOutlet.lat!,
//         otherRecommendedOutlet.long!,
//       ),
//     )
//         .timeout(Duration(seconds: 10), onTimeout: () {
//       print('eror timeout 1');

//       _resetState();

//       Flushbar(
//         duration: Duration(seconds: 2),
//         flushbarPosition: FlushbarPosition.TOP,
//         backgroundColor: flushColor,
//         animationDuration: Duration(milliseconds: flushAnimationDuration),
//         message: 'Terjadi kesalahan, silahkan coba lagi',
//       )..show(context);

//       return _directionList = null;
//     });

//     var _totalDistance = double.parse(
//       _directionList!.totalDistance!.split(' ')[0],
//     );

//     _setMarker(
//       LatLng(
//         otherRecommendedOutlet.lat!,
//         otherRecommendedOutlet.long!,
//       ),
//     );

//     if (_directionList!.totalDistance!.split(' ')[1] == 'km') {
//       setState(() {
//         _nearestOutletDistance = '$_totalDistance km';
//         _isOutletReadyToDelivery = true;
//       });
//     } else if (_directionList!.totalDistance!.split(' ')[1] == 'm') {
//       int _metersRounded = _totalDistance.round();

//       setState(() {
//         _nearestOutletDistance = '$_metersRounded m';
//         _isOutletReadyToDelivery = true;
//       });
//     }

//     print('outlet terdekat recomendasi = ' + '$_nearestOutletName');
//     print('ongkir terdekat recomendasi = ' + '$_nearestOutletDistance');
//     print('status visible = ' + "$_isVisible");
//   }

//   bool _distanceCheck() {
//     print('getting distance....');

//     var _distanceStrToDouble = double.parse(
//       _nearestOutletDistance.split(' ')[0],
//     );

//     int _distanceRoundedVal = _distanceStrToDouble.round();

//     if (_nearestOutletDistance.split(' ')[1] == 'km') {
//       if (_distanceStrToDouble <= 7.0 && _distanceStrToDouble > 1.0) {
//         setState(() {
//           _deliveryFee = ((_distanceRoundedVal * 3).round()) + 3;
//         });

//         return true;
//       } else if (_distanceStrToDouble <= 1.0 && _distanceStrToDouble > 0.0) {
//         setState(() {
//           _deliveryFee = 6;
//         });

//         return true;
//       } else {
//         return false;
//       }
//     } else if (_nearestOutletDistance.split(' ')[1] == 'm') {
//       var _distanceStrToInt = int.parse(
//         _nearestOutletDistance.split(' ')[0],
//       );

//       if (_distanceStrToInt <= 100 && _distanceStrToInt > 0) {
//         setState(() {
//           _deliveryFee = 6;
//         });

//         return true;
//       } else {
//         return false;
//       }
//     } else {
//       return false;
//     }
//   }
// }
