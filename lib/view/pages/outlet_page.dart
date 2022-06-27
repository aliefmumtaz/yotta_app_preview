part of 'pages.dart';

class OutletPage extends StatefulWidget {
  final LatLngInitialLocation latLngInitialLocation;
  final String? selectedCity;

  OutletPage(this.latLngInitialLocation, this.selectedCity);

  @override
  _OutletPageState createState() => _OutletPageState();
}

class _OutletPageState extends State<OutletPage> {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();
  late GoogleMapController _googleMapController;
  Marker? _markers;

  BitmapDescriptor? _outletLocation;

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
        .buffer
        .asUint8List();
  }

  void _setUserOutletMarker() async {
    final Uint8List markerIcon = await getBytesFromAsset(
      'assets/icon_loc_outlet.png',
      75,
    );

    _outletLocation = BitmapDescriptor.fromBytes(markerIcon);
  }

  double? latInitial;
  double? lngInitial;

  String? selectedOutletCity;
  String? selectedOutlet;

  void _updateLocation(double lat, double lng) {
    _googleMapController.animateCamera(
      CameraUpdate.newLatLng(LatLng(lat, lng)),
    );
    setState(() {
      _markers = null;
    });

    setState(() {
      _markers = Marker(
        markerId: MarkerId('id-1'),
        icon: _outletLocation!,
        position: LatLng(
          latInitial!,
          lngInitial!,
        ),
      );
    });
  }

  @override
  void initState() {
    selectedOutletCity = widget.selectedCity;
    latInitial = widget.latLngInitialLocation.lat;
    lngInitial = widget.latLngInitialLocation.lang;
    _setUserOutletMarker();

    super.initState();
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  void _onPressBackButton() {
    context.read<PageBloc>().add(GoToHomePage(0));
    context.read<ListOutletBloc>().add(OutletListToInitial());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
      builder: (_, userState) => WillPopScope(
        onWillPop: () async {
          _onPressBackButton();

          return false;
        },
        child: Scaffold(
          backgroundColor: ThemeColor.whiteBackColor,
          body: Stack(
            children: [
              _buildMapsWidget(),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.white,
                ),
              ),
              _buildBottomSheetBar(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMapsWidget() {
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Container(
        height: height * .62,
        child: BlocBuilder<ListOutletBloc, ListOutletState>(
          builder: (_, outletState) => GoogleMap(
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
            mapType: MapType.normal,
            markers: {
              if (_markers != null) _markers!,
            },
            initialCameraPosition: CameraPosition(
              target: LatLng(latInitial!, lngInitial!),
              zoom: 18,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              _googleMapController = controller;

              setState(() {
                _markers = null;
              });

              setState(() {
                _markers = Marker(
                  markerId: MarkerId('id-1'),
                  icon: _outletLocation!,
                  position: LatLng(
                    latInitial!,
                    lngInitial!,
                  ),
                );
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBottomSheetBar() {
    var height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          GestureDetector(
            onTap: () => _onPressBackButton(),
            child: Container(
              height: height * .06,
              width: height * .06,
              margin: EdgeInsets.only(left: defaultMargin),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(Icons.arrow_back, color: ThemeColor.accentColor4),
              ),
            ),
          ),
          SizedBox(height: height * verticalMargin),
          Container(
            height: height * .4,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: _buildSheetContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildSheetContent() {
    var height = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: defaultMargin),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              SizedBox(height: height * verticalMargin),
              _buildButtonSelectCityOutlet(),
              _generateListOfOutlet(),
              Icon(
                Icons.arrow_drop_down,
                color: ThemeColor.mainColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButtonSelectCityOutlet() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: ThemeColor.accentColor2,
              ),
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height * verticalMarginHalf,
                  ),
                  Icon(Icons.arrow_drop_up, color: ThemeColor.blackTextColor),
                  _buildListCity(),
                  Icon(Icons.arrow_drop_down, color: ThemeColor.blackTextColor),
                  SizedBox(
                    height:
                        MediaQuery.of(context).size.height * verticalMarginHalf,
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Container(
        height: MediaQuery.of(context).size.height * 0.06,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: ThemeColor.mainColor),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  selectedOutletCity!,
                  style: mainFontBlackBold.copyWith(
                    fontSize: 18,
                    color: ThemeColor.mainColor,
                  ),
                ),
              ),
              Icon(Icons.arrow_drop_down, color: ThemeColor.mainColor),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildListCity() {
    return BlocBuilder<ListCityForRegistrationBloc,
        ListCityForRegistrationState>(
      builder: (context, cityState) => Container(
        height: MediaQuery.of(context).size.height * .25,
        child: Stack(
          children: [
            ListView.builder(
              shrinkWrap: true,
              itemCount: cityState.cityForRegistration.toList().length,
              itemBuilder: (_, index) {
                var cityList = cityState.cityForRegistration.toList()[index];
                var cityListLength =
                    cityState.cityForRegistration.toList().length;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedOutletCity = cityList.name;
                    });

                    context.read<ListOutletBloc>().add(OutletListToInitial());

                    context.read<ListOutletBloc>().add(
                          GetListOutlet(selectedOutletCity),
                        );

                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 6),
                        margin:
                            EdgeInsets.symmetric(horizontal: defaultMargin * 2),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: (index == cityListLength - 1)
                              ? null
                              : Border(
                                  bottom: BorderSide(
                                    color: ThemeColor.blackTextColor,
                                    width: 0.4,
                                  ),
                                ),
                        ),
                        child: Center(
                          child: Text(
                            cityList.name!,
                            style: mainFontBlackBold.copyWith(
                              fontSize: 18,
                              color: ThemeColor.blackTextColor,
                            ),
                          ),
                        ),
                      ),
                      (index == cityListLength - 1)
                          ? SizedBox()
                          : SizedBox(
                              height: MediaQuery.of(context).size.height *
                                  verticalMarginHalf /
                                  2,
                            ),
                    ],
                  ),
                );
              },
            ),
            Container(
              height: MediaQuery.of(context).size.height * .015,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    ThemeColor.accentColor2.withOpacity(0),
                    ThemeColor.accentColor2,
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: MediaQuery.of(context).size.height * .015,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      ThemeColor.accentColor2,
                      ThemeColor.accentColor2.withOpacity(0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _generateListOfOutlet() {
    var height = MediaQuery.of(context).size.height;

    return BlocBuilder<ListOutletBloc, ListOutletState>(
      builder: (_, outletState) {
        if (outletState is LoadListOutlet) {
          return Container(
            height: height * .27,
            width: double.infinity,
            child: Stack(
              children: [
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: outletState.outlet.toList().length,
                  itemBuilder: (_, index) {
                    var outlet = outletState.outlet[index];
                    var outletlength = outletState.outlet.length;

                    return Padding(
                      padding: EdgeInsets.fromLTRB(
                        0,
                        (index == 0) ? defaultMargin : 0,
                        0,
                        (index == outletlength - 1) ? defaultMargin : 0,
                      ),
                      child: ButtonOutlet(
                        name: outlet.name,
                        address: outlet.address,
                        onTap: () {
                          setState(() {
                            _markers = null;
                          });

                          setState(() {
                            selectedOutlet = outlet.name;
                            latInitial = outlet.lat;
                            lngInitial = outlet.lang;

                            _markers = Marker(
                              markerId: MarkerId('id-1'),
                              icon: _outletLocation!,
                              position: LatLng(
                                latInitial!,
                                lngInitial!,
                              ),
                            );
                          });

                          _updateLocation(latInitial!, lngInitial!);
                        },
                        isSelected: selectedOutlet == outlet.name,
                      ),
                    );
                  },
                ),
                Container(
                  height: height * .02,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.white.withOpacity(0),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: height * .02,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.white.withOpacity(0), Colors.white],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            height: height * .27,
            child: Align(
              alignment: Alignment.topCenter,
              child: SpinKitRing(color: ThemeColor.accentColor2, size: 24),
            ),
          );
        }
      },
    );
  }
}
