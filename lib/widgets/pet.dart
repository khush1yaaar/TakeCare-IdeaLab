import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takecare/controllers/pet_controller.dart';

class Pet extends StatelessWidget {
  final PetController controller = Get.put(PetController());

  Pet({super.key});

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
              // Left Wing (Pivot from Top Edge)
              Positioned(
                top: 65,
                left: 40,
                child: AnimatedBuilder(
                  animation: controller.flapAnimation,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.rotationZ(
                        -controller.flapAnimation.value,
                      ), // Counterclockwise (-90°)
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
                    );
                  },
                ),
              ),

              // Right Wing (Pivot from Top Edge)
              Positioned(
                top: 65,
                right: 40,
                child: AnimatedBuilder(
                  animation: controller.flapAnimation,
                  builder: (context, child) {
                    return Transform(
                      alignment: Alignment.topCenter,
                      transform: Matrix4.rotationZ(
                        controller.flapAnimation.value,
                      ), // Clockwise (+90°)
                      child: Container(
                        width: 13,
                        height: 45,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(50),
                          ),
                        ),
                      ),
                    );
                  },
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
                            // Left eye
                            AnimatedEye(
                              blinkAnimation: controller.leftEyeBlink,
                              isLeftEye: true,
                            ),
                            SizedBox(width: 15),
                            // Right eye
                            AnimatedEye(
                              blinkAnimation: controller.rightEyeBlink,
                              isLeftEye: false,
                            ),
                          ],
                        ),
                      ),
                      // Blush with animated color change during smile
                      Positioned(
                        left: 10,
                        top: 55,
                        child: AnimatedBuilder(
                          animation: controller.blushAnimation,
                          builder: (context, child) {
                            return Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: controller.blushAnimation.value,
                                shape: BoxShape.circle,
                              ),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 55,
                        child: AnimatedBuilder(
                          animation: controller.blushAnimation,
                          builder: (context, child) {
                            return Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                color: controller.blushAnimation.value,
                                shape: BoxShape.circle,
                              ),
                            );
                          },
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
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedEye extends StatelessWidget {
  final Animation<double> blinkAnimation;
  final bool isLeftEye;

  const AnimatedEye({
    required this.blinkAnimation,
    this.isLeftEye = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: blinkAnimation,
      builder: (context, child) {
        return CustomPaint(
          size: Size(15, 15),
          painter: EyePainter(
            blinkProgress: blinkAnimation.value,
            isLeftEye: isLeftEye,
          ),
        );
      },
    );
  }
}

class EyePainter extends CustomPainter {
  final double blinkProgress;
  final bool isLeftEye;

  EyePainter({required this.blinkProgress, required this.isLeftEye});

  @override
  void paint(Canvas canvas, Size size) {
    final eyePaint =
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.fill;

    final highlightPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    final center = Offset(size.width / 2, size.height / 2);
    final eyeRadius = size.width / 2;

    // Draw eye (always visible)
    canvas.drawCircle(center, eyeRadius, eyePaint);

    // Draw highlight (only when eye is open)
    if (blinkProgress < 0.7) {
      canvas.drawCircle(
        Offset(center.dx + eyeRadius * 0.3, center.dy - eyeRadius * 0.3),
        eyeRadius * 0.3,
        highlightPaint,
      );
    }

    // Draw eyelid (curved)
    final eyelidPath = Path();
    final eyelidHeight = size.height * blinkProgress;

    if (isLeftEye) {
      eyelidPath.moveTo(0, size.height / 2);
      eyelidPath.quadraticBezierTo(
        size.width / 2,
        size.height / 2 - eyelidHeight * 2,
        size.width,
        size.height / 2,
      );
    } else {
      eyelidPath.moveTo(size.width, size.height / 2);
      eyelidPath.quadraticBezierTo(
        size.width / 2,
        size.height / 2 - eyelidHeight * 2,
        0,
        size.height / 2,
      );
    }

    eyelidPath.lineTo(size.width, size.height / 2);
    eyelidPath.close();

    canvas.drawPath(
      eyelidPath,
      Paint()
        ..color =
            Colors
                .white // Match your pet's face color
        ..style = PaintingStyle.fill,
    );
  }

  @override
  bool shouldRepaint(covariant EyePainter oldDelegate) {
    return blinkProgress != oldDelegate.blinkProgress;
  }
}
