<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->


# AnimateEase Flutter Package Documentation

The AnimateEase package is a comprehensive Flutter package designed to simplify the addition of animations to your Flutter applications. It leverages a variety of animation types to enhance the visual appeal of your application, providing a seamless way to implement animations with minimal code. This documentation is structured to guide developers through the integration and usage of the AnimateEase package in their projects.

## Installation

To use the AnimateEase package in your Flutter application, you need to add it as a dependency in your ``pubspec.yaml`` file
```
  dependencies:
    animate_ease: <latest_version>
```
Replace <latest_version> with the latest version of the package.
or directly use the github repo by adding 
```
  dependencies:
    animate_ease:
      git: https://github.com/Hitek-Financials-Ltd/animate_ease.git
```

The github repo will always return the latest version of the package, including the beta version.

## Basic Usage
``AnimateEase`` is designed to be easy to integrate and use. Here's a basic example of how to use it:
```
import 'package:animate_ease/animate_ease.dart';

// Inside your widget tree
AnimateEase(
  child: YourWidget(),
  animate: AnimateEaseType.fadeIn,
)

```
This example will animate YourWidget with a fade-in effect.

## Configuration Options

``AnimateEase`` provides a range of configuration options to customize the animation to suit your needs:

   - child: The widget you want to animate. (required)
   - animate: Type of animation from AnimateEaseType. Defaults to fadeIn.
   - duration: Length of time the animation should last. Defaults to Duration(seconds: 1).
   - delay: Delay before the animation starts. Defaults to Duration(seconds: 0).
   - atRestAnimate: Whether to animate the widget when it is at rest. Defaults to true, this will allow the animation to trigger just once, when this option is ``false`` it will trigger an infinite animation display of the widget.
   - isVisibleChek: If set to true, the animation only plays when the widget is visible on screen. Requires               visibility_detector package. Defaults to false.
   - animationCount: Number of times the animation should repeat. null for infinite looping.

# Advanced Usage
## Visibility Detection
To animate a widget only when it's visible on the viewport, set ``isVisibleChek`` to true. This is particularly useful for lists or scrolling content where you want to animate widgets as they come into view.

## Custom Animation Types
``AnimateEase`` supports a variety of animation types through the ``AnimateEaseType enum``. These include basic animations like fadeIn, fadeOut, complex ones like slideInLeft, rotate, and dynamic effects like bounceIn, elasticOut. Choose the appropriate animation type based on the visual effect you wish to achieve.

## Animation Control
The animation flow is automatically managed by the AnimateEase widget. However, developers can further customize the behavior by using the configuration options provided. For instance, adjusting the duration, delay, and animationCount can significantly alter how the animation behaves.

## Custom Animations

While ``AnimateEase`` covers a wide range of animation types, you might need a custom animation for your specific use case. In such scenarios, consider using Flutter's animation controllers directly for full control over the animation.

## Conclusion 
``AnimateEase`` is a powerful package that significantly simplifies adding animations to your Flutter applications. By providing a wide range of pre-defined animation types and customizable options, it caters to most animation needs out of the box, allowing developers to create engaging and dynamic user interfaces with ease.

For any specific requirements beyond what AnimateEase offers, consider extending the package or using Flutter's built-in animation classes for more granular control.

## Contributions
``AnimateEase`` is developed and maintained by Engineer Usiobaifo Kenneth, contact me via kennethusiobaifo@yahoo.com if you want to contribute to this package.

