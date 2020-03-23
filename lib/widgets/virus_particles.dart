import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:covid_19_tracker_app/animation/virus_particle_painter.dart';
import 'package:covid_19_tracker_app/model/virus_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:simple_animations/simple_animations/rendering.dart';

class VirusParticles extends StatefulWidget {
  final int numberOfParticles;

  VirusParticles(this.numberOfParticles);

  @override
  _VirusParticlesState createState() => _VirusParticlesState();
}

class _VirusParticlesState extends State<VirusParticles> {
  ui.Image image;
  bool isImageloaded = false;
  final Random random = Random();
  final List<VirusModel> particles = [];

  @override
  void initState() {
    List.generate(widget.numberOfParticles, (index) {
      particles.add(VirusModel(random));
    });
    init();
    super.initState();
  }

  Future<Null> init() async {
    final ByteData data = await rootBundle.load('images/covid-19-icon.png');
    image = await loadImage(new Uint8List.view(data.buffer));
  }

  Future<ui.Image> loadImage(List<int> img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      setState(() {
        isImageloaded = true;
      });
      return completer.complete(img);
    });
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Rendering(
      startTime: Duration(seconds: 30),
      onTick: _simulateVirusParticles,
      builder: (context, time) {
        return CustomPaint(
          painter: VirusParticlePainter(particles, image, time),
        );
      },
    );
  }

  _simulateVirusParticles(Duration time) {
    particles.forEach((particle) => particle.maintainRestart(time));
  }
}
