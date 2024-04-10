library animate_ease;

import 'package:animate_ease/animate_ease_type.dart';
import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AnimateEase extends StatefulWidget {
  final Widget child;
  final AnimateEaseType animate;
  final Duration duration;
  final Duration delay;
  final bool atRestAnimate;
  final int? animationCount;
  final bool? isVisibleChek;

  const AnimateEase({
    super.key,
    required this.child,
    this.animate = AnimateEaseType.fadeIn,
    this.duration = const Duration(seconds: 1),
    this.delay = const Duration(seconds: 0),
    this.atRestAnimate = true,
    this.isVisibleChek = false,
    this.animationCount,
  });

  @override
  State<AnimateEase> createState() => _AnimateEaseState();
}

class _AnimateEaseState extends State<AnimateEase>
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  AnimationController? _controller;
  Animation<double>? _animation;
  int _animationCycleCount = 0;
  late AnimateEaseType _animationType;
  bool _hasAnimated = false;

  @override
  void initState() {
    super.initState();
    _animationType = widget.animate;
    WidgetsBinding.instance.addObserver(this);

    // Initialize the controller with an initial value based on the animation type to start off-screen
    double startValue = _getStartValueForAnimationType(_animationType);
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
      value: startValue, // Use startValue to begin the animation off-screen
    )..addStatusListener(_statusListener);

    setupAnimation();
  }

  void setupAnimation() {
    switch (_animationType) {
      case AnimateEaseType.fadeIn:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.fadeOut:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.slideInLeft:
        _animation = Tween<double>(begin: -1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.slideOutLeft:
        _animation = Tween<double>(begin: 0.0, end: -1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.slideInRight:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.slideOutRight:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.slideInTop:
        _animation = Tween<double>(begin: -1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.slideOutTop:
        _animation = Tween<double>(begin: 0.0, end: -1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.slideInBottom:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.slideOutBottom:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.scaleUp:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.elasticOut));
        break;
      case AnimateEaseType.scaleDown:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.elasticOut));
        break;
      case AnimateEaseType.rotate:
        _animation = Tween<double>(begin: 0.0, end: 2 * 3.141592653589793)
            .animate(
                CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.flipX:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.flipY:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.zoomIn:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.zoomOut:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;

      case AnimateEaseType.bounceIn:
        _animation = Tween<double>(begin: -1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.bounceOut));
        break;
      case AnimateEaseType.bounceOut:
        _animation = Tween<double>(begin: 0.0, end: -1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.bounceOut));
        break;
      case AnimateEaseType.elasticIn:
        _animation = Tween<double>(begin: -1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.elasticOut));
        break;
      case AnimateEaseType.elasticOut:
        _animation = Tween<double>(begin: 0.0, end: -1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.elasticOut));
        break;
      case AnimateEaseType.jitter:
        _animation = Tween<double>(begin: -1.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.linear));
        break;
      case AnimateEaseType.wiggle:
        _animation = Tween<double>(begin: -0.1, end: 0.1).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.linear));
        break;
      case AnimateEaseType.pulse:
        _animation = Tween<double>(begin: 1.0, end: 0.8).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.expand:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.collapse:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.shake:
        _animation = Tween<double>(begin: -10.0, end: 10.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.linear));
        break;
      case AnimateEaseType.swing:
        _animation = Tween<double>(begin: -0.1, end: 0.1).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.linear));
        break;
      case AnimateEaseType.tada:
        _animation = Tween<double>(begin: -0.1, end: 0.1).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.linear));
        break;
      case AnimateEaseType.wobble:
        _animation = Tween<double>(begin: -0.3, end: 0.3).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.linear));
        break;
      case AnimateEaseType.jello:
        _animation = Tween<double>(begin: -0.1, end: 0.1).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.linear));
        break;
      case AnimateEaseType.heartBeat:
        _animation = Tween<double>(begin: -0.2, end: 0.2).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.linear));
        break;
      case AnimateEaseType.flash:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.linear));
        break;
      case AnimateEaseType.rubberBand:
        _animation = Tween<double>(begin: -0.3, end: 0.3).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.linear));
        break;
      case AnimateEaseType.headShake:
        _animation = Tween<double>(begin: -0.1, end: 0.1).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.linear));
        break;
      case AnimateEaseType.squeeze:
        _animation = Tween<double>(begin: -1.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.fadeInLeft:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.fadeInRight:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.fadeInUp:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.fadeInDown:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.fadeOutLeft:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.fadeOutRight:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.fadeOutUp:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.fadeOutDown:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.slideInLeftFade:
        _animation = Tween<double>(begin: -1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.slideInRightFade:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.slideInTopFade:
        _animation = Tween<double>(begin: -1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.slideInBottomFade:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.rotateIn:
        _animation = Tween<double>(begin: 0.0, end: 2 * 3.141592653589793)
            .animate(
                CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.rotateOut:
        _animation = Tween<double>(begin: 2 * 3.141592653589793, end: 0.0)
            .animate(
                CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.opacityInLeft:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.opacityInRight:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.opacityInUp:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.opacityInDown:
        _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.translateInLeft:
        _animation = Tween<double>(begin: -1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.translateInRight:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.translateInUp:
        _animation = Tween<double>(begin: -1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      case AnimateEaseType.translateInDown:
        _animation = Tween<double>(begin: 1.0, end: 0.0).animate(
            CurvedAnimation(parent: _controller!, curve: Curves.easeInOut));
        break;
      default:
        _animation = Tween<double>(begin: 1.0, end: 1.0).animate(_controller!);
    }
  }

  double _getStartValueForAnimationType(AnimateEaseType type) {
    // Define initial values for each animation type to start off-screen
    // This is a simplistic approach; you might need to adjust based on your animation needs
    switch (type) {
      case AnimateEaseType.slideInLeft:
      case AnimateEaseType.slideInRight:
      case AnimateEaseType.slideInTop:
      case AnimateEaseType.slideInBottom:
      case AnimateEaseType.fadeIn:
      case AnimateEaseType.slideInLeftFade:
      case AnimateEaseType.slideInRightFade:
      case AnimateEaseType.slideInTopFade:
      case AnimateEaseType.translateInLeft:
      case AnimateEaseType.slideInBottomFade:
        return 1.0; // Example value, adjust based on the actual off-screen start needed
      // Add cases for other animations as needed
      default:
        return 0.0;
    }
  }

  void _statusListener(AnimationStatus status) {
    if (status == AnimationStatus.completed) {
      // Animation has fully completed
      if (!widget.atRestAnimate &&
          (widget.animationCount == null ||
              _animationCycleCount < widget.animationCount!)) {
        // If atRestAnimate is false and animationCount allows, restart the animation
        _animationCycleCount++;
        _controller!.forward(from: 0.0);
      } else if (widget.atRestAnimate &&
          widget.animationCount != null &&
          _animationCycleCount < widget.animationCount!) {
        // If atRestAnimate is true and the animation count limit hasn't been reached, reverse the animation
        _animationCycleCount++;
        _controller!.reverse(from: 1.0);
      }
    } else if (status == AnimationStatus.dismissed) {
      // Animation has fully reversed (gone back to the start)
      if (widget.atRestAnimate &&
          (widget.animationCount == null ||
              _animationCycleCount < widget.animationCount!)) {
        // If atRestAnimate is true and animationCount allows, restart the animation
        _controller!.forward();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // If isVisibleChek is true, use VisibilityDetector to control the animation.
    if (widget.isVisibleChek ?? false) {
      return VisibilityDetector(
        key: Key(
            'AnimateEase_${widget.animate.toString()}_${UniqueKey().toString()}'),
        onVisibilityChanged: (visibilityInfo) {
          var visiblePercentage = visibilityInfo.visibleFraction * 100;
          if (visiblePercentage > 0 && !_controller!.isAnimating) {
            if (!_hasAnimated ||
                (widget.atRestAnimate &&
                    (_animationCycleCount < (widget.animationCount ?? 1)))) {
              Future.delayed(widget.delay, () {
                if (!_controller!.isAnimating && mounted) {
                  _controller!.forward(from: 0.0);
                  _hasAnimated = true;
                }
              });
            }
          }
        },
        child: animateEaseFlow(),
      );
    } else {
      // If isVisibleChek is false, skip visibility detection and animate immediately.
      // Ensure this block does not continuously re-trigger by checking _hasAnimated.
      if (!_hasAnimated) {
        Future.delayed(widget.delay, () {
          if (mounted) {
            _controller!.forward(from: 0.0);
            _hasAnimated = true;
          }
        });
      }
      return animateEaseFlow();
    }
  }

  Widget animateEaseFlow() => AnimatedBuilder(
        animation: _controller!,
        builder: (context, child) {
          // Your transformation logic based on the animation type
          // This example uses a simple fade in for demonstration
          double opacityValue =
              _animation?.value ?? 0.0; // Default to 0 for safety

          switch (_animationType) {
            case AnimateEaseType.fadeIn:
              return Opacity(
                opacity: opacityValue,
                child: widget.child,
              );

            case AnimateEaseType.fadeOut:
              return Opacity(
                opacity: opacityValue,
                child: widget.child,
              );
            case AnimateEaseType.rotate:
              return Transform.rotate(
                angle: opacityValue * 2 * 3.141592653589793,
                child: widget.child,
              );
            case AnimateEaseType.scaleUp:
              return Transform.scale(
                scale: 1.0 - opacityValue,
                child: widget.child,
              );
            case AnimateEaseType.scaleDown:
              return Transform.scale(
                scale: opacityValue,
                child: widget.child,
              );
            case AnimateEaseType.slideInRight:
              return Transform.translate(
                offset: Offset(
                    opacityValue * MediaQuery.of(context).size.width, 0.0),
                child: widget.child,
              );

            case AnimateEaseType.slideOutLeft:
              return Transform.translate(
                offset: Offset(
                    -opacityValue * MediaQuery.of(context).size.width, 0.0),
                child: widget.child,
              );

            case AnimateEaseType.slideInBottom:
              return Transform.translate(
                offset: Offset(
                    0.0, opacityValue * MediaQuery.of(context).size.height),
                child: widget.child,
              );
            case AnimateEaseType.slideOutTop:
              return Transform.translate(
                offset: Offset(
                    0.0, -opacityValue * MediaQuery.of(context).size.height),
                child: widget.child,
              );
            case AnimateEaseType.slideInTop:
              return Transform.translate(
                offset: Offset(
                    0.0, opacityValue * MediaQuery.of(context).size.height),
                child: widget.child,
              );
            case AnimateEaseType.slideOutRight:
              return Transform.translate(
                offset: Offset(
                    opacityValue * MediaQuery.of(context).size.width, 0.0),
                child: widget.child,
              );
            case AnimateEaseType.slideInLeft:
              return Transform.translate(
                offset: Offset(
                    -opacityValue * MediaQuery.of(context).size.width, 0.0),
                child: widget.child,
              );

            case AnimateEaseType.slideOutBottom:
              return Transform.translate(
                offset: Offset(
                    0.0, -opacityValue * MediaQuery.of(context).size.height),
                child: widget.child,
              );
            case AnimateEaseType.rotateIn:
              return Transform.rotate(
                angle: opacityValue * (3.141592653589793 / 2),
                child: widget.child,
              );
            case AnimateEaseType.rotateOut:
              return Transform.rotate(
                angle: -opacityValue * (3.141592653589793 / 2),
                child: widget.child,
              );
            case AnimateEaseType.opacityInLeft:
              return Opacity(
                opacity: opacityValue,
                child: Transform.translate(
                  offset: Offset(
                      -(opacityValue * MediaQuery.of(context).size.width), 0.0),
                  child: widget.child,
                ),
              );
            case AnimateEaseType.opacityInRight:
              return Opacity(
                opacity: opacityValue,
                child: Transform.translate(
                  offset: Offset(
                      opacityValue * MediaQuery.of(context).size.width, 0.0),
                  child: widget.child,
                ),
              );
            case AnimateEaseType.opacityInUp:
              return Opacity(
                opacity: opacityValue,
                child: Transform.translate(
                  offset: Offset(0.0,
                      -(opacityValue * MediaQuery.of(context).size.height)),
                  child: widget.child,
                ),
              );
            case AnimateEaseType.opacityInDown:
              return Opacity(
                opacity: opacityValue,
                child: Transform.translate(
                  offset: Offset(
                      0.0, opacityValue * MediaQuery.of(context).size.height),
                  child: widget.child,
                ),
              );
            case AnimateEaseType.translateInLeft:
              return Transform.translate(
                offset: Offset(
                    -(opacityValue * MediaQuery.of(context).size.width), 0.0),
                child: widget.child,
              );
            case AnimateEaseType.translateInRight:
              return Transform.translate(
                offset: Offset(
                    opacityValue * MediaQuery.of(context).size.width, 0.0),
                child: widget.child,
              );
            case AnimateEaseType.translateInUp:
              return Transform.translate(
                offset: Offset(
                    0.0, -(opacityValue * MediaQuery.of(context).size.height)),
                child: widget.child,
              );
            case AnimateEaseType.translateInDown:
              return Transform.translate(
                offset: Offset(
                  _animationType == AnimateEaseType.translateInLeft ||
                          _animationType == AnimateEaseType.translateInRight
                      ? opacityValue * MediaQuery.of(context).size.width
                      : 0.0,
                  _animationType == AnimateEaseType.translateInUp ||
                          _animationType == AnimateEaseType.translateInDown
                      ? opacityValue * MediaQuery.of(context).size.height
                      : 0.0,
                ),
                child: widget.child,
              );
            case AnimateEaseType.scatteredIn:
              return Transform(
                transform:
                    Matrix4.diagonal3Values(opacityValue, opacityValue, 1.0),
                child: widget.child,
              );
            case AnimateEaseType.particles:
              return Transform(
                transform: Matrix4.translationValues(
                    opacityValue * 10, opacityValue * 10, 0.0),
                child: widget.child,
              );
            case AnimateEaseType.rainFall:
              return Transform.translate(
                offset: Offset(
                    0.0, opacityValue * MediaQuery.of(context).size.height),
                child: widget.child,
              );
            case AnimateEaseType.rollInLeft:
              return Transform.rotate(
                angle: opacityValue * (3.141592653589793 / 2),
                child: Transform.translate(
                  offset: Offset(
                      -(opacityValue * MediaQuery.of(context).size.width), 0.0),
                  child: widget.child,
                ),
              );
            case AnimateEaseType.rollInRight:
              return Transform.rotate(
                angle: opacityValue * (-3.141592653589793 / 2),
                child: Transform.translate(
                  offset: Offset(
                      opacityValue * MediaQuery.of(context).size.width, 0.0),
                  child: widget.child,
                ),
              );
            case AnimateEaseType.rollInUp:
              return Transform.rotate(
                angle: opacityValue * (-3.141592653589793 / 2),
                child: Transform.translate(
                  offset: Offset(0.0,
                      -(opacityValue * MediaQuery.of(context).size.height)),
                  child: widget.child,
                ),
              );
            case AnimateEaseType.rollInDown:
              return Transform.rotate(
                angle: opacityValue * (3.141592653589793 / 2),
                child: Transform.translate(
                  offset: Offset(
                      0.0, opacityValue * MediaQuery.of(context).size.height),
                  child: widget.child,
                ),
              );
            case AnimateEaseType.bounceIn:
              return Transform.scale(
                scale: 1 - opacityValue.abs(),
                child: widget.child,
              );

            case AnimateEaseType.bounceOut:
              return Transform.scale(
                scale: opacityValue,
                child: widget.child,
              );

            case AnimateEaseType.elasticIn:
              return Transform.scale(
                scale: 1 - opacityValue,
                child: widget.child,
              );

            case AnimateEaseType.elasticOut:
              return Transform.scale(
                scale: opacityValue,
                child: widget.child,
              );

            case AnimateEaseType.jitter:
              return Transform(
                transform: Matrix4.translationValues(
                  opacityValue * 5,
                  opacityValue * 5,
                  0.0,
                ),
                child: widget.child,
              );

            case AnimateEaseType.wiggle:
              return Transform(
                transform: Matrix4.rotationZ(
                  opacityValue * 0.1,
                ),
                child: widget.child,
              );

            case AnimateEaseType.pulse:
              return Transform.scale(
                scale: 1 - (opacityValue * 0.2),
                child: widget.child,
              );

            case AnimateEaseType.expand:
              return Transform.scale(
                scale: opacityValue,
                child: widget.child,
              );

            case AnimateEaseType.collapse:
              return Transform.scale(
                scale: 1 - opacityValue,
                child: widget.child,
              );

            case AnimateEaseType.shake:
              return Transform(
                transform: Matrix4.translationValues(
                  opacityValue * 10,
                  0.0,
                  0.0,
                ),
                child: widget.child,
              );

            case AnimateEaseType.swing:
              return Transform.rotate(
                angle: opacityValue * 0.2,
                child: widget.child,
              );

            case AnimateEaseType.tada:
              return Transform.scale(
                scale: 1 + opacityValue * 0.1,
                child: widget.child,
              );

            case AnimateEaseType.wobble:
              return Transform(
                transform: Matrix4.rotationZ(
                  opacityValue * 0.2,
                ),
                child: widget.child,
              );

            case AnimateEaseType.jello:
              return Transform(
                transform: Matrix4.skewX(
                  opacityValue * 0.2,
                ),
                child: widget.child,
              );

            case AnimateEaseType.heartBeat:
              return Transform.scale(
                scale: 1 - opacityValue.abs() * 0.2,
                child: widget.child,
              );

            case AnimateEaseType.flash:
              return Opacity(
                opacity: opacityValue < 0.5 ? 1.0 : 0.0,
                child: widget.child,
              );

            case AnimateEaseType.rubberBand:
              return Transform.scale(
                scale: 1 - opacityValue.abs() * 0.3,
                child: widget.child,
              );

            case AnimateEaseType.headShake:
              return Transform.rotate(
                angle: opacityValue * 0.2,
                child: widget.child,
              );

            case AnimateEaseType.squeeze:
              return Transform.scale(
                scale: opacityValue < 0.5 ? 1 - opacityValue : opacityValue,
                child: widget.child,
              );
            case AnimateEaseType.flipX:
              return Transform(
                transform: Matrix4.rotationY(
                  opacityValue * 3.141592653589793,
                ),
                alignment: Alignment.center,
                child: widget.child,
              );

            case AnimateEaseType.flipY:
              return Transform(
                transform: Matrix4.rotationX(
                  opacityValue * 3.141592653589793,
                ),
                alignment: Alignment.center,
                child: widget.child,
              );

            case AnimateEaseType.zoomIn:
              return Transform.scale(
                scale: opacityValue,
                child: widget.child,
              );

            case AnimateEaseType.zoomOut:
              return Transform.scale(
                scale: 1 - opacityValue,
                child: widget.child,
              );

            case AnimateEaseType.slideInLeftFade:
              return Opacity(
                opacity: opacityValue,
                child: Transform.translate(
                  offset: Offset(
                    -opacityValue * MediaQuery.of(context).size.width,
                    0.0,
                  ),
                  child: widget.child,
                ),
              );

            case AnimateEaseType.slideInRightFade:
              return Opacity(
                opacity: opacityValue,
                child: Transform.translate(
                  offset: Offset(
                    opacityValue * MediaQuery.of(context).size.width,
                    0.0,
                  ),
                  child: widget.child,
                ),
              );

            case AnimateEaseType.slideInTopFade:
              return Opacity(
                opacity: opacityValue,
                child: Transform.translate(
                  offset: Offset(
                    0.0,
                    -opacityValue * MediaQuery.of(context).size.height,
                  ),
                  child: widget.child,
                ),
              );

            case AnimateEaseType.slideInBottomFade:
              return Opacity(
                opacity: opacityValue,
                child: Transform.translate(
                  offset: Offset(
                    0.0,
                    opacityValue * MediaQuery.of(context).size.height,
                  ),
                  child: widget.child,
                ),
              );

            default:
              return widget.child;
          }
        },
      );

  @override
  void dispose() {
    _controller?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
}
