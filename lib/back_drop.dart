import 'package:flutter/material.dart';

class BackdropScaffold extends StatefulWidget {
  final AnimationController controller;
  final Widget title;
  final Widget backpanel;
  final Widget body;
  final List<Widget> actions;
  final double headerHeight;

  BackdropScaffold({
    this.controller,
    this.title,
    this.backpanel,
    this.body,
    this.actions,
    this.headerHeight = 32.0,
  });

  @override
  _BackdropScaffoldState createState() => _BackdropScaffoldState();
}

class _BackdropScaffoldState extends State<BackdropScaffold>
    with SingleTickerProviderStateMixin {
  bool shouldDisposeController = false;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      shouldDisposeController = true;
      _controller = AnimationController(
          vsync: this, duration: Duration(milliseconds: 100), value: 1.0);
    } else {
      _controller = widget.controller;
    }
  }

  @override
  void dispose() {
    super.dispose();
    if (shouldDisposeController) {
      _controller.dispose();
    }
  }

  bool get isTopPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.completed ||
        status == AnimationStatus.forward;
  }

  bool get isBackPanelVisible {
    final AnimationStatus status = _controller.status;
    return status == AnimationStatus.dismissed ||
        status == AnimationStatus.reverse;
  }

  Animation<RelativeRect> getPanelAnimation(BoxConstraints constraints) {
    final height = constraints.biggest.height;
    final backPanelHeight = height - widget.headerHeight;
    final frontPanelHeight = -backPanelHeight;

    return RelativeRectTween(
      begin: RelativeRect.fromLTRB(0.0, backPanelHeight, 0.0, frontPanelHeight),
      end: RelativeRect.fromLTRB(
          0.0, MediaQuery.of(context).size.height / 2, 0.0, 0.0),
    ).animate(new CurvedAnimation(parent: _controller, curve: Curves.linear));
  }

  Widget _buildInactiveLayer() {
    if (isBackPanelVisible) {
      return GestureDetector(
        onTap: () => _controller.fling(velocity: 1.0),
        /*onVerticalDragStart: (a) =>
            _controller.fling(velocity: 1.0),*/
        onVerticalDragStart: (gesture) {},
        onVerticalDragUpdate: (gesture) {
          debugPrint(gesture.delta.dy.toString());
          gesture.delta.dy > 0
              ? _controller.fling(velocity: -1.0)
              : _controller.fling(velocity: 1.0);
        },

        behavior: HitTestBehavior.opaque,
        child: SizedBox.expand(
          child: Container(
            decoration: BoxDecoration(
              //color: Colors.grey.shade200.withOpacity(0.7),
            ),
            child: Center(
              child: SizedBox(
                height: 0.0,
                width: 0.0,
              ),
            ),
          ),
        ),
      );
    } else {
      return GestureDetector(
        child: Container(
          color: Colors.transparent,
        ),
        onVerticalDragStart: (gesture) {},
        onVerticalDragUpdate: (gesture) {
          gesture.delta.dy > 0
              ? _controller.fling(velocity: -1.0)
              : _controller.fling(velocity: 1.0);
        },
      );
    }
  }

  Widget _buildBackPanel({ontap}) {
    return GestureDetector(
      child: Material(
        color: Theme.of(context).primaryColor,
        child: widget.backpanel,
      ),
      onPanDown: ontap,
    );
  }

  Widget _buildFrontPanel() {
    return Material(
      elevation: 12.0,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
      child: Stack(
        children: <Widget>[
          widget.body,
          _buildInactiveLayer(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: widget.title,
        actions: widget.actions,
        elevation: 0.0,
        leading: IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.close_menu,
            progress: _controller.view,
          ),
          onPressed: () => _controller.fling(
                velocity: isTopPanelVisible ? -1.0 : 1.0,
              ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            child: Stack(
              children: <Widget>[
                _buildBackPanel(
                  ontap: isTopPanelVisible
                      ? (gesture) =>
                      _controller.fling(
                        velocity: isTopPanelVisible ? -1.0 : 1.0,
                      )
                      : (gesture) {},
                ),
                PositionedTransition(
                  rect: getPanelAnimation(constraints),
                  child: _buildFrontPanel(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
