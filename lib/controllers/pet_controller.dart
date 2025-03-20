import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class PetController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController nodController;
   late AnimationController blinkController;
  late AnimationController moveController;
  late AnimationController flapController;
  late AnimationController blushController;

  var isNodding = false.obs;
  var isBlinking = false.obs;
  var isMoving = false.obs;
  var blushColor = Colors.pink.shade100.obs;

  late Animation<double> flapAnimation;
  late Animation<Color?> blushAnimation;

  @override
  void onInit() {
    nodController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );
    blinkController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
    );
    moveController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 700),
    );

    flapController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250), 
      lowerBound: -1, 
      upperBound: 1,
    );

    blushController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    flapAnimation = Tween<double>(begin: 0, end: 1.2).animate(flapController);
    blushAnimation = ColorTween(
      begin: Colors.pink.shade100,
      end: Colors.pink.shade200,
    ).animate(blushController);

    super.onInit();
  }

  void nod() async {
    isNodding.value = true;
    nodController.forward().then((_) => nodController.reverse());
    await Future.delayed(Duration(milliseconds: 400));
    isNodding.value = false;
  }

  void blink() async {
    blinkController.forward().then((_) => blinkController.reverse());
    await Future.delayed(Duration(milliseconds: 300));
  }


  void flapWings() async {
  flapController.repeat(reverse: true);

  // Allow it to flap 3-4 times based on duration
  await Future.delayed(Duration(milliseconds: 1100)); // 4 flaps (150ms each)

  flapController.stop();
  flapController.value = 0; // Reset position
}


  void smile() {
    blink();
    blushController.forward().then((_) => blushController.reverse());
  }

  @override
  void onClose() {
    nodController.dispose();
    blinkController.dispose();
    flapController.dispose();
    blushController.dispose();
    moveController.dispose();
    super.onClose();
  }
}
