import 'package:flutter/material.dart';

//modification of library modal_progress_hud;

///
/// Wrap around any widget that makes an async call to show a modal progress
/// indicator while the async call is in progress.
///
/// The progress indicator can be turned on or off using [inAsyncCall]
///
/// The progress indicator defaults to a [CircularProgressIndicator] but can be
/// any kind of widget
///
/// The progress indicator can be positioned using [offset] otherwise it is
/// centered
///
/// The modal barrier can be dismissed using [dismissible]
///
/// The color of the modal barrier can be set using [color]
///
/// The opacity of the modal barrier can be set using [opacity]
///
/// HUD=Heads Up Display
///
class LoadingScreen extends StatelessWidget {
  final bool inAsyncCall;
  final double opacity;
  final Color color;
  final Widget progressIndicator;
  final Offset offset;
  final bool dismissible;
  final Widget child;

  LoadingScreen({
    Key key,
    @required this.inAsyncCall,
    this.opacity = 0.7,
    this.color = Colors.white,
    this.progressIndicator = const CircularProgressIndicator(),
    this.offset,
    this.dismissible = false,
    @required this.child,
  })  : assert(child != null),
        assert(inAsyncCall != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> widgetList = [];
    widgetList.add(child);
    if (inAsyncCall) {
      Widget layOutProgressIndicator;
      if (offset == null) {
        layOutProgressIndicator = Center(
            child: Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  //color: Palette.primaryColor,
                  shape: BoxShape.circle,
                ),
                //need this due to bug...https://github.com/flutter/flutter/issues/18399
                child: Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    child: CircularProgressIndicator(
                        // backgroundColor: Palette.textColorInvert,
                        ),
                    height: 30.0,
                    width: 30.0,
                  ),
                )));
      } else {
        layOutProgressIndicator = Positioned(
          child: progressIndicator,
          left: offset.dx,
          top: offset.dy,
        );
      }
      final modal = [
        new Opacity(
          child: new ModalBarrier(dismissible: dismissible, color: color),
          opacity: opacity,
        ),
        layOutProgressIndicator
      ];
      widgetList += modal;
    }
    return new Stack(
      children: widgetList,
    );
  }
}
