import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takecare/controllers/pet_controller.dart';

class Pet extends StatelessWidget {
  final PetController controller = Get.put(PetController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          width: 100,
          height: 150,
          child: AnimatedContainer(
            duration: Duration(milliseconds: 500),
            transform: Matrix4.translationValues(
              controller.isMoving.value ? 5.0 : 0.0,
              0.0,
              0.0,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Body
                Positioned(
                  bottom: 10,
                  child: Container(
                    width: 80,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(50),
                    ),
                  ),
                ),
                // White belly
                Positioned(
                  bottom: 20,
                  child: Container(
                    width: 50,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                // Head (separated)
                Positioned(
                  top: -10,
                  child: AnimatedContainer(
                    duration: Duration(milliseconds: 500),
                    transform: Matrix4.translationValues(
                      0.0,
                      controller.isNodding.value ? 5.0 : 0.0,
                      0.0,
                    ),
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                // Eyes
                Positioned(
                  top: 5,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                        opacity: controller.isBlinking.value ? 0.0 : 1.0,
                        duration: Duration(milliseconds: 100),
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle,
                          ),
                          child: Positioned(
                            top: 5,
                            right: 5,
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      AnimatedOpacity(
                        opacity: controller.isBlinking.value ? 0.0 : 1.0,
                        duration: Duration(milliseconds: 100),
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Container(
                              width: 4,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Beak
                Positioned(
                  top: 25,
                  child: Container(
                    width: 20,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                // Feet
                Positioned(
                  bottom: 0,
                  left: 20,
                  child: Container(
                    width: 20,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 20,
                  child: Container(
                    width: 20,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
                // Hands
                Positioned(
                  top: 60,
                  left: 10,
                  child: Container(
                    width: 15,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Positioned(
                  top: 60,
                  right: 10,
                  child: Container(
                    width: 15,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}