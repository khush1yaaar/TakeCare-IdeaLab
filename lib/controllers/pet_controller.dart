import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:async';

class PetController extends GetxController with GetTickerProviderStateMixin {
  late AnimationController _nodController;
  late AnimationController _blinkController;
  late AnimationController _moveController;
  
  var isNodding = false.obs;
  var isBlinking = false.obs;
  var isMoving = false.obs;

  @override
  void onInit() {
    _nodController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _blinkController = AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _moveController = AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    super.onInit();
  }

  void nod() async {
    isNodding.value = true;
    _nodController.forward().then((_) => _nodController.reverse());
    await Future.delayed(Duration(milliseconds: 500));
    isNodding.value = false;
  }

  void blink() async {
    isBlinking.value = true;
    _blinkController.forward().then((_) => _blinkController.reverse());
    await Future.delayed(Duration(milliseconds: 300));
    isBlinking.value = false;
  }

  void move() async {
    isMoving.value = true;
    _moveController.forward().then((_) => _moveController.reverse());
    await Future.delayed(Duration(milliseconds: 700));
    isMoving.value = false;
  }

  void flapWings() {
    int count = 0;
    Timer.periodic(Duration(milliseconds: 200), (timer) {
      isMoving.value = !isMoving.value;
      count++;
      if (count >= 6) timer.cancel(); // 3 full cycles (up/down)
    });
  }

  void smile() {
    blink();
  }

  @override
  void onClose() {
    _nodController.dispose();
    _blinkController.dispose();
    _moveController.dispose();
    super.onClose();
  }
}
