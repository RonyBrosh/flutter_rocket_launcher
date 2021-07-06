import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_resources.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/splash_screen/model/splash_title_animation_state.dart';

class SplashTitleWidget extends StatefulWidget {
  final ValueNotifier<SplashTitleAnimationState> _splashTitleAnimationState;
  final void Function() _onTitleEnterAnimationEnd;
  final void Function() _onTitleExitAnimationEnd;

  SplashTitleWidget({
    required ValueNotifier<SplashTitleAnimationState> splashTitleAnimationState,
    required Function() onTitleEnterAnimationEnd,
    required Function() onTitleExitAnimationEnd,
  })   : this._splashTitleAnimationState = splashTitleAnimationState,
        this._onTitleEnterAnimationEnd = onTitleEnterAnimationEnd,
        this._onTitleExitAnimationEnd = onTitleExitAnimationEnd;

  @override
  State<StatefulWidget> createState() {
    return _SplashTitleWidgetState();
  }
}

class _SplashTitleWidgetState extends State<SplashTitleWidget> with TickerProviderStateMixin {
  final int _animationDuration = 400;

  late AnimationController _topTitleAnimationController;
  late AnimationController _bottomTitleAnimationController;
  late Animation _topTitleAnimation;
  late Animation _bottomTitleAnimation;

  @override
  void initState() {
    super.initState();
    _initTopTitleAnimation();
    _initBottomTitleAnimation();
    widget._splashTitleAnimationState.addListener(_onSplashTitleAnimationStateChanged);
  }

  @override
  void dispose() {
    _topTitleAnimationController.dispose();
    _bottomTitleAnimationController.dispose();
    widget._splashTitleAnimationState.removeListener(_onSplashTitleAnimationStateChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AnimatedBuilder(
          animation: _topTitleAnimation,
          child: DefaultTextStyle(
            style: TextStyle(),
            child: Text(
              SplashResources.from(context).strings.splashTitleRocket,
              style: TextStyle(fontFamily: 'RocketLauncher', fontSize: 50, color: Colors.white),
            ),
          ),
          builder: (context, child) {
            return Transform.translate(
              child: child,
              offset: Offset(_topTitleAnimation.value * screenWidth, 0.0),
            );
          },
        ),
        AnimatedBuilder(
          animation: _bottomTitleAnimation,
          child: DefaultTextStyle(
            style: TextStyle(),
            child: Text(
              SplashResources.from(context).strings.splashTitleLauncher,
              style: TextStyle(fontFamily: 'RocketLauncher', fontSize: 50, color: Colors.white),
            ),
          ),
          builder: (context, child) {
            return Transform.translate(
              child: child,
              offset: Offset(_bottomTitleAnimation.value * screenWidth, 0.0),
            );
          },
        )
      ],
    );
  }

  void _initTopTitleAnimation() {
    _topTitleAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: _animationDuration));
    _topTitleAnimation = Tween<double>(
      begin: -1,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _topTitleAnimationController,
      curve: Curves.easeInOutQuint,
      reverseCurve: Curves.easeInOutQuint,
    ))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _bottomTitleAnimationController.forward();
        }
      });
  }

  void _initBottomTitleAnimation() {
    _bottomTitleAnimationController = AnimationController(vsync: this, duration: Duration(milliseconds: _animationDuration));
    _bottomTitleAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(
      parent: _bottomTitleAnimationController,
      curve: Curves.easeInOutQuint,
      reverseCurve: Curves.easeInOutQuint,
    ))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          widget._onTitleEnterAnimationEnd();
        } else if (status == AnimationStatus.dismissed) {
          widget._onTitleExitAnimationEnd();
        }
      });
  }

  void _onSplashTitleAnimationStateChanged() {
    switch (widget._splashTitleAnimationState.value) {
      case SplashTitleAnimationState.IDLE:
        break;
      case SplashTitleAnimationState.ENTER:
        _topTitleAnimationController.forward();
        break;
      case SplashTitleAnimationState.EXIT:
        _bottomTitleAnimationController.reverse();
        _topTitleAnimationController.reverse();
        break;
    }
  }
}
