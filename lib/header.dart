import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class AnimatedHeader extends StatefulWidget {
  @override
  _AnimatedHeaderState createState() => new _AnimatedHeaderState();
}

class _AnimatedHeaderState extends State<AnimatedHeader> {
  @override
  Widget build(BuildContext context) {
    return FlareActor(
      'assets/animations/planet_revolve_light.flr',
      alignment: Alignment.center,
      fit: BoxFit.cover,
      animation: 'revolve',
      isPaused: false,
    );
  }
}