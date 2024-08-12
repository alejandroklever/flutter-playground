import 'package:flutter/material.dart';

class CustomScrollPhysics extends ScrollPhysics {
  const CustomScrollPhysics({super.parent});

  @override
  CustomScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor));
  }

  @override
  double applyPhysicsToUserOffset(ScrollMetrics position, double offset) {
    // Aplica un rebote similar a BouncingScrollPhysics
    if (position.outOfRange) {
      return offset / 2.0;
    }
    return offset;
  }

  @override
  Simulation? createBallisticSimulation(
      ScrollMetrics position, double velocity) {
    // Si no hay velocidad, detiene el scroll y no hace nada más
    if (velocity == 0.0) return null;

    final Tolerance tolerance = toleranceFor(position);

    // Si el desplazamiento está fuera del rango, usa la simulación de rebote
    if (position.outOfRange) {
      return BouncingScrollSimulation(
        spring: spring,
        position: position.pixels,
        velocity: velocity,
        leadingExtent: position.minScrollExtent,
        trailingExtent: position.maxScrollExtent,
        tolerance: tolerance,
      );
    }

    final targetOffset = _findTargetOffset(position);

    return ScrollSpringSimulation(
      spring,
      position.pixels,
      targetOffset,
      velocity,
      tolerance: tolerance,
    );
  }

  double _findTargetOffset(ScrollMetrics position) {
    return 0.0;
  }

  @override
  SpringDescription get spring => const SpringDescription(
        mass: 50.0,
        stiffness: 100.0,
        damping: 1.0,
      );

  @override
  bool get allowImplicitScrolling => true;
}
