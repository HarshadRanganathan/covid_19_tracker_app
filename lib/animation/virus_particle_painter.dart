import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:covid_19_tracker_app/model/virus_model.dart';

class VirusParticlePainter extends CustomPainter {
  ui.Image image;
  List<VirusModel> virusParticles;
  Duration time;

  VirusParticlePainter(this.virusParticles, this.image, this.time);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.green.withAlpha(80);

    virusParticles.forEach((particle) {
      var progress = particle.animationProgress.progress(time);
      final animation = particle.tween.transform(progress);
      final position =
          Offset(animation["x"] * size.width, animation["y"] * size.height);

      final ui.Rect rect = position & new Size(50.0, 50.0); 
      // contain image inside box size
      final Size imageSize = new Size(image.width.toDouble(), image.height.toDouble()); 
      FittedSizes sizes = applyBoxFit(BoxFit.contain, imageSize, new Size(50.0, 50.0)); 

      final Rect inputSubrect = Alignment.center.inscribe(sizes.source, Offset.zero & imageSize); 
      final Rect outputSubrect = Alignment.center.inscribe(sizes.destination, rect);

      canvas.drawImageRect(image, inputSubrect, outputSubrect, paint);
    });
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}