part of 'pages.dart';

class CartCheckoutDeliveryPage extends StatefulWidget {
  final LatLng? outletLatLng;
  final LatLng? userLoc;
  final PageEvent? pageEvent;

  CartCheckoutDeliveryPage({
    this.outletLatLng,
    this.userLoc,
    this.pageEvent,
  });

  @override
  _CartCheckoutDeliveryPageState createState() =>
      _CartCheckoutDeliveryPageState();
}

class _CartCheckoutDeliveryPageState extends State<CartCheckoutDeliveryPage>
    with TickerProviderStateMixin {
  late CameraPosition _initialCameraPosition;

  Completer<GoogleMapController> _controllerGoogleMaps = Completer();
  late GoogleMapController _mapController;

  Marker? _outlet;
  Marker? _userPosition;

  late BitmapDescriptor _userCustomMarker;
  late BitmapDescriptor _nearestOutletCustomMarker;

  Directions? _direction;

  late AnimationController _colorAnimationController;
  late Animation _colorTween;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void _setMarker(LatLng? outletPos, LatLng? userPos) async {
    final Uint8List markerIcon = await getBytesFromAsset(
      'assets/icon_loc_position.png',
      100,
    );

    final Uint8List markerIcons = await getBytesFromAsset(
      'assets/icon_loc_outlet.png',
      100,
    );

    _nearestOutletCustomMarker = BitmapDescriptor.fromBytes(markerIcons);
    _userCustomMarker = BitmapDescriptor.fromBytes(markerIcon);

    setState(() {
      _outlet = Marker(
        markerId: MarkerId('destination'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: _nearestOutletCustomMarker,
        position: outletPos!,
      );

      _userPosition = Marker(
        markerId: MarkerId('delivery point'),
        infoWindow: const InfoWindow(title: 'Destination'),
        icon: _userCustomMarker,
        position: userPos!,
      );
    });
  }

  void _cameraBounds() async {
    final directions = await LocationServices().getDirections(
      origin: LatLng(
        widget.userLoc!.latitude,
        widget.userLoc!.longitude,
      ),
      destination: LatLng(
        widget.outletLatLng!.latitude,
        widget.outletLatLng!.longitude,
      ),
    );

    setState(() {
      _direction = directions;
    });

    _mapController.animateCamera(
      CameraUpdate.newLatLngBounds(_direction!.bounds, 80),
    );
  }

  void _buttonBackPressed() async {
    context.read<PageBloc>().add(widget.pageEvent!);
  }

  void animatedColorWhenScroll() {
    _colorAnimationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 0),
    );

    _colorTween = ColorTween(
      begin: Colors.transparent,
      end: Colors.black.withOpacity(0.7),
    ).animate(_colorAnimationController);
  }

  bool _scrollListener(ScrollNotification scrollInfo) {
    if (scrollInfo.metrics.axis == Axis.vertical) {
      _colorAnimationController.animateTo(
        scrollInfo.metrics.pixels / 100,
      );

      return true;
    } else {
      return false;
    }
  }

  @override
  void initState() {
    super.initState();

    _setMarker(
      widget.outletLatLng,
      widget.userLoc,
    );

    _cameraBounds();

    _initialCameraPosition = CameraPosition(
      target: widget.userLoc!,
      zoom: 18,
    );

    animatedColorWhenScroll();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        _buttonBackPressed();

        return false;
      },
      child: Scaffold(
        backgroundColor: ThemeColor.whiteBackColor,
        body: NotificationListener<ScrollNotification>(
          onNotification: _scrollListener,
          child: Stack(
            children: [
              _buildGoogleMapsWidget(),
              AnimatedBuilder(
                animation: _colorAnimationController,
                builder: (_, child) => Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: _colorTween.value,
                ),
              ),
              _buttonBack(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 200,
                  color: ThemeColor.whiteBackColor,
                ),
              ),
              _buildDraggableWidget(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buttonBack() {
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Column(
        children: [
          Spacer(),
          GestureDetector(
            onTap: () async => _buttonBackPressed(),
            child: Container(
              height: height * .06,
              width: height * .06,
              margin: EdgeInsets.only(left: defaultMargin),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(Icons.arrow_back, color: ThemeColor.mainColor),
              ),
            ),
          ),
          SizedBox(height: height * verticalMargin),
          SizedBox(height: height * .4),
        ],
      ),
    );
  }

  Widget _buildDraggableWidget() {
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: DraggableScrollableSheet(
        initialChildSize: .4,
        minChildSize: .4,
        maxChildSize: .9,
        builder: (_, controller) {
          return Container(
            padding: const EdgeInsets.fromLTRB(
              defaultMargin,
              defaultMargin,
              defaultMargin,
              0,
            ),
            decoration: BoxDecoration(
              color: ThemeColor.whiteBackColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: ListView(
              controller: controller,
              children: [
                _buildStatusOrderWidget(),
                SizedBox(height: height * verticalMargin),
                _buildOrderedDrinkWidget(),
                _buildDeliveryOrderType(),
                SizedBox(height: height * verticalMargin),
                GlobalButton(
                  title: 'Kembali',
                  onTapFunc: () async {
                    _buttonBackPressed();
                  },
                ),
                SizedBox(height: height * verticalMargin),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildGoogleMapsWidget() {
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Container(
        height: height * .65,
        width: double.infinity,
        child: GoogleMap(
          myLocationButtonEnabled: false,
          myLocationEnabled: false,
          zoomGesturesEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: _initialCameraPosition,
          markers: {
            if (_outlet != null) _outlet!,
            if (_userPosition != null) _userPosition!,
          },
          onMapCreated: (GoogleMapController controller) {
            _controllerGoogleMaps.complete(controller);
            _mapController = controller;
          },
          polylines: {
            if (_direction != null)
              Polyline(
                polylineId: PolylineId('overview_polyline'),
                color: ThemeColor.accentColor3,
                width: 5,
                points: _direction!.polylinePoints
                    .map((e) => LatLng(e.latitude, e.longitude))
                    .toList(),
              ),
          },
        ),
      ),
    );
  }

  Widget _buildStatusOrderWidget() {
    var height = MediaQuery.of(context).size.height;

    return Column(
      children: [
        BlocBuilder<ChangeStatusOrderBloc, ChangeStatusOrderState>(
            builder: (_, statusState) {
          if (statusState is ChangeStatusToProcess) {
            return _buildStatusText('Menyiapkan Pesanan', false);
          } else if (statusState is ChangeStatusToDone) {
            return Column(
              children: [
                _buildStatusText('Menyiapkan Pesanan', true),
                SizedBox(height: height * verticalMarginHalf),
                _buildStatusText('Mengantarkan Pesanan', false),
              ],
            );
          } else {
            return SizedBox();
          }
        }),
      ],
    );
  }

  Widget _buildStatusText(String text, bool isDone) {
    var height = MediaQuery.of(context).size.height;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: const EdgeInsets.only(right: defaultMargin),
          height: height * .025,
          width: height * .025,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: (isDone == false)
                ? ThemeColor.mainColor
                : ThemeColor.accentColor7,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: defaultMargin),
          child: AutoSizeText(
            text,
            style: mainFontBlackBold.copyWith(
              fontSize: 18,
              color: (isDone == false)
                  ? ThemeColor.blackTextColor
                  : ThemeColor.accentColor7,
            ),
            maxLines: 1,
          ),
        ),
      ],
    );
  }

  Widget _buildOrderedDrinkWidget() {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<ListOrderCheckoutCupBloc, ListOrderCheckoutCupState>(
      builder: (_, cupOrder) {
        if (cupOrder is LoadListCheckoutOrderCup) {
          return Column(
            children: [
              Column(
                children: cupOrder.orderCupDetail
                    .map(
                      (e) => CardDetailOrderColdDrink(
                        amount: e.amount,
                        drinkSize: e.cupType,
                        drinkType: e.type,
                        iceLevel: e.iceLevel,
                        productName: e.productName,
                        sizeCupPrice: e.typePrice,
                        sugarLevel: e.sugarLevel,
                        toppingName: e.topping,
                        toppingPrice: e.toppingPrice,
                        totalPrice: e.totalPrice,
                        imgUrl: e.imgUrl,
                      ),
                    )
                    .toList(),
              ),
              _buildHotOrderList(),
              _buildBottleOrderList(),
            ],
          );
        } else {
          return Container(
            height: height * .4,
            child: SpinKitRing(color: ThemeColor.accentColor2, size: 34),
          );
        }
      },
    );
  }

  Widget _buildBottleOrderList() {
    return BlocBuilder<ListOrderCheckoutBottleBloc,
        ListOrderCheckoutBottleState>(
      builder: (_, bottleOrderState) {
        if (bottleOrderState is LoadListCheckoutOrderBottle) {
          return Column(
            children: bottleOrderState.orderBottleDetail
                .map(
                  (e) => CardDetailOrderBottleDrink(
                    amount: e.amount,
                    drinkSize: e.size,
                    drinkType: e.type,
                    productName: e.productName,
                    sizeCupPrice: e.sizePrice,
                    totalPrice: e.totalPrice,
                    sugarLevel: e.sugar,
                  ),
                )
                .toList(),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget _buildHotOrderList() {
    return BlocBuilder<ListOrderCheckoutHotBloc, ListOrderCheckoutHotState>(
      builder: (_, hotOrderState) {
        if (hotOrderState is LoadListCheckoutOrderHot) {
          return Column(
            children: hotOrderState.orderHotDetail
                .map(
                  (e) => CardDetailOrderHotDrink(
                    amount: e.amount,
                    drinkType: e.type,
                    productName: e.productName,
                    sugar: e.sugar,
                    totalPrice: e.totalPrice,
                  ),
                )
                .toList(),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }

  Widget _buildDeliveryOrderType() {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<CheckoutDeliveryDataBloc, CheckoutDeliveryDataState>(
      builder: (_, deliveryDataState) {
        if (deliveryDataState is LoadCheckoutDeliveryOrderData) {
          return Column(
            children: [
              CardDeliveryOrderType(
                orderID: deliveryDataState.deliveryOrderData.orderID,
                address: deliveryDataState.deliveryOrderData.address,
                deliveryFee: deliveryDataState.deliveryOrderData.deliveryFee,
                distance: deliveryDataState.deliveryOrderData.distance,
                orderType: deliveryDataState.deliveryOrderData.orderType,
                outlet: deliveryDataState.deliveryOrderData.outlet,
              ),
              SizedBox(height: height * verticalMargin),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: defaultMargin),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: defaultMargin),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AutoSizeText(
                        'Total Harga',
                        style: accentFontBlackRegular.copyWith(
                          fontSize: 16,
                          color: ThemeColor.accentColor4,
                        ),
                      ),
                      AutoSizeText(
                        '${deliveryDataState.totalPrice}.000',
                        style: accentFontBlackBold.copyWith(
                          fontSize: 18,
                          color: ThemeColor.accentColor3,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
