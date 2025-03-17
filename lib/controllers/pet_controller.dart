import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class PetController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController _nodController;
  late AnimationController _blinkController;
  late AnimationController _moveController;
  late AnimationController _flapController;
  late AnimationController _blushController;

  var isNodding = false.obs;
  var isBlinking = false.obs;
  var isMoving = false.obs;
  var blushColor = Colors.pink.shade100.obs;

  late Animation<double> flapAnimation;
  late Animation<Color?> blushAnimation;

  @override
  void onInit() {
    _nodController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    _blinkController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    _moveController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    _flapController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250), 
      lowerBound: -1, 
      upperBound: 1,
    );

    _blushController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    flapAnimation = Tween<double>(begin: 0, end: 1.2).animate(_flapController);
    blushAnimation = ColorTween(
      begin: Colors.pink.shade100,
      end: Colors.pink.shade200,
    ).animate(_blushController);

    super.onInit();
  }

  void nod() async {
    isNodding.value = true;
    _nodController.forward().then((_) => _nodController.reverse());
    await Future.delayed(Duration(milliseconds: 400));
    isNodding.value = false;
  }

  void blink() async {
    isBlinking.value = true;
    _blinkController.forward().then((_) => _blinkController.reverse());
    await Future.delayed(Duration(milliseconds: 300));
    isBlinking.value = false;
  }

  void flapWings() async {
  _flapController.repeat(reverse: true);

  // Allow it to flap 3-4 times based on duration
  await Future.delayed(Duration(milliseconds: 1100)); // 4 flaps (150ms each)

  _flapController.stop();
  _flapController.value = 0; // Reset position
}


  void smile() {
    blink();
    _blushController.forward().then((_) => _blushController.reverse());
  }

  @override
  void onClose() {
    _nodController.dispose();
    _blinkController.dispose();
    _moveController.dispose();
    _flapController.dispose();
    _blushController.dispose();
    super.onClose();
  }
}
