part of 'widgets.dart';

class SmartRefresherContent extends StatefulWidget {
  final onRefresh;
  final onLoading;
  final ListView listView;
  late final AnimationController? anicontroller;
  late final AnimationController? scaleController;
  late final AnimationController? footerController;

  SmartRefresherContent({
    required this.onRefresh,
    required this.onLoading,
    required this.listView,
    required this.anicontroller,
    required this.scaleController,
    required this.footerController,
  });

  @override
  State<SmartRefresherContent> createState() => _SmartRefresherContentState();
}

class _SmartRefresherContentState extends State<SmartRefresherContent>
    with TickerProviderStateMixin {
  RefreshController _refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void initState() {
    widget.anicontroller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    widget.scaleController = AnimationController(
      value: 0.0,
      vsync: this,
      upperBound: 1.0,
    );

    widget.footerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _refreshController.headerMode!.addListener(() {
      if (_refreshController.headerStatus == RefreshStatus.idle) {
        widget.scaleController!.value = 0.0;
        widget.anicontroller!.reset();
      } else if (_refreshController.headerStatus == RefreshStatus.refreshing) {
        widget.anicontroller!.repeat();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: false,
      header: CustomHeader(
        refreshStyle: RefreshStyle.Behind,
        onOffsetChange: (offset) {
          if (_refreshController.headerMode!.value != RefreshStatus.refreshing)
            widget.scaleController!.value = offset / 80.0;
        },
        builder: (c, m) {
          return Container(
            child: FadeTransition(
              opacity: widget.scaleController!,
              child: ScaleTransition(
                child: SpinKitFadingCircle(
                  size: 30.0,
                  controller: widget.anicontroller,
                  itemBuilder: (_, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven
                            ? ThemeColor.mainColor
                            : ThemeColor.mainColor2,
                      ),
                    );
                  },
                ),
                scale: widget.scaleController!,
              ),
            ),
            alignment: Alignment.center,
          );
        },
      ),
      footer: CustomFooter(
        onModeChange: (mode) {
          if (mode == LoadStatus.loading) {
            widget.scaleController!.value = 0.0;
            widget.footerController!.repeat();
          } else {
            widget.footerController!.reset();
          }
        },
        builder: (context, mode) {
          Widget? child;
          switch (mode) {
            case LoadStatus.failed:
              child = Text("failed,click retry");
              break;
            case LoadStatus.noMore:
              child = Text("no more data");
              break;
            default:
              child = SpinKitFadingCircle(
                size: 30.0,
                // controller: _footerController,
                itemBuilder: (_, int index) {
                  return DecoratedBox(
                    decoration: BoxDecoration(
                      color: index.isEven ? Colors.red : Colors.green,
                    ),
                  );
                },
              );
              break;
          }
          return Container(
            height: 60,
            child: Center(
              child: child,
            ),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: widget.onRefresh,
      onLoading: widget.onLoading,
      child: widget.listView,
    );
  }
}
