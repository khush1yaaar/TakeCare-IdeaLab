import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takecare/controllers/pet_controller.dart';

class Pet extends StatelessWidget {
  final PetController controller = Get.put(PetController());

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Container(
        width: 150,
        height: 150,
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 500),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Feet
              Positioned(
                bottom: 10,
                left: 40,
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
                bottom: 10,
                right: 40,
                child: Container(
                  width: 20,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
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
                  width: 55,
                  height: 70,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                ),
              ),
              // Head with Eyes, Beak, and Blush
              Positioned(
                top: -10,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 200),
                  transform: Matrix4.translationValues(
                    0.0,
                    controller.isNodding.value ? 5.0 : 0.0,
                    0.0,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      // Head
                      Container(
                        width: 70,
                        height: 100, // Reduced to blend better with the face
                        decoration: BoxDecoration(
                          color: Colors.black,
                          shape: BoxShape.circle,
                        ),
                      ),
                      // Face
                      Positioned(
                        bottom: 10,
                        child: Container(
                          width: 55,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(50),
                              bottom: Radius.circular(50),
                            ),
                          ),
                        ),
                      ),

                      // Eyes
                      Positioned(
                        top: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedOpacity(
                              opacity: controller.isBlinking.value ? 0.0 : 1.0,
                              duration: Duration(milliseconds: 100),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Positioned(
                                    top: 1,
                                    left: 5,
                                    child: Container(
                                      width: 3,
                                      height: 3,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 15),
                            AnimatedOpacity(
                              opacity: controller.isBlinking.value ? 0.0 : 1.0,
                              duration: Duration(milliseconds: 100),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 10,
                                    height: 10,
                                    decoration: BoxDecoration(
                                      color: Colors.black,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  Positioned(
                                    top: 1,
                                    left: 5,
                                    child: Container(
                                      width: 3,
                                      height: 3,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Blush (Baby Pink Cheeks)
                      Positioned(
                        left: 10,
                        top: 55,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.pink.shade100,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 55,
                        child: Container(
                          width: 12,
                          height: 12,
                          decoration: BoxDecoration(
                            color: Colors.pink.shade100,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      // Beak
                      Positioned(
                        top: 55,
                        child: Column(
                          children: [
                            Container(
                              width: 20,
                              height: 10,
                              decoration: BoxDecoration(
                                color: Colors.orange.shade400,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(100),
                                ),
                                border: Border.all(
                                  color: Colors.orange.shade700,
                                  width: 1,
                                ),
                              ),
                            ),
                            Container(
                              width: 14,
                              height: 6,
                              decoration: BoxDecoration(
                                color: Colors.orange.shade400,
                                borderRadius: BorderRadius.vertical(
                                  bottom: Radius.circular(100),
                                ),
                                border: Border.all(
                                  color: Colors.orange.shade700,
                                  width: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // Flapping Hands (Wings)
              Positioned(
                top: 60,
                left: 35,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 20),
                  transform: Matrix4.rotationZ(
                    controller.isMoving.value ? 1 : 0,
                  ),
                  child: Container(
                    width: 13,
                    height: 45,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 70,
                right: 35,
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 20),
                  transform: Matrix4.rotationZ(
                    controller.isMoving.value ? -1 : 0,
                  ),
                  child: Container(
                    width: 13,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.horizontal(
                        right: Radius.circular(50),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
