import 'dart:math';
import 'package:flutter/material.dart';

import 'package:simple_animations/simple_animations.dart';

/*
 * Source - https://gist.github.com/felixblaschke/7afca56be090ad99d3e45e74d5cbd799#file-particle-background-1-dart
 */
class VirusModel {
  Animatable tween;
  double size;
  AnimationProgress animationProgress;
  Random random;

  VirusModel(this.random) {
    restart();
  }

  restart({Duration time = Duration.zero}) {
    final startPosition = Offset(-0.2 + 1.4 * random.nextDouble(), 1.4);
    final endPosition = Offset(-0.2 + 1.4 * random.nextDouble(), -1.4);
    final duration = Duration(milliseconds: 4000 + random.nextInt(1000));

    tween = MultiTrackTween([
      Track("x").add(
          duration, Tween(begin: startPosition.dx, end: endPosition.dx),
          curve: Curves.easeInOutSine),
      Track("y").add(
          duration, Tween(begin: startPosition.dy, end: endPosition.dy),
          curve: Curves.easeIn),
    ]);
    animationProgress = AnimationProgress(duration: duration, startTime: time);
    size = 0.2 + random.nextDouble() * 0.4;
  }

  maintainRestart(Duration time) {
    if (animationProgress.progress(time) == 1.0) {
      restart(time: time);
    }
  }
}
