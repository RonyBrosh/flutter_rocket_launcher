import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_rocket_launcher/features/splash/presentation/assets/splash_resources.dart';

class SplashTitleWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashTitleWidgetState();
  }
}

class _SplashTitleWidgetState extends State<SplashTitleWidget> with TickerProviderStateMixin {
  final int _animationDuration = 400;
  AnimationController _topTitleAnimationController;
  AnimationController _bottomTitleAnimationController;
  Animation _topTitleAnimation;
  Animation _bottomTitleAnimation;

  @override
  void initState() {
    super.initState();
    _initTopTitleAnimation();
    _initBottomTitleAnimation();
    Future.delayed(Duration(seconds: 1), () {
      _topTitleAnimationController.forward();
    });
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

  @override
  void dispose() {
    _topTitleAnimationController.dispose();
    _bottomTitleAnimationController.dispose();
    super.dispose();
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
        } else if (status == AnimationStatus.dismissed) {
          _topTitleAnimationController.forward();
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
          Future.delayed(Duration(seconds: 3), () {
            _animateExit();
          });
        }
      });
  }

  void _animateExit() {
    _bottomTitleAnimationController.reverse();
    _topTitleAnimationController.reverse();
  }
}
