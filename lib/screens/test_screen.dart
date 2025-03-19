import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takecare/controllers/auth_controller.dart';
import 'package:takecare/screens/report_screen.dart';
import 'package:takecare/widgets/button.dart';
import 'package:takecare/widgets/option.dart';

class TestScreen extends StatefulWidget {
  final dynamic test;

  const TestScreen({super.key, required this.test});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final AuthController _authController = Get.find<AuthController>();
  final _auth = FirebaseAuth.instance;
  List<int> responses = [];
  int currentQuestionIndex = 0;
  int? selectedOption;
  var user = Rx<User?>(null);
  var isLoading = false.obs;

  void onInit() {
    user.value = _auth.currentUser;
    _auth.authStateChanges().listen((User? newUser) {
      user.value = newUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    var question = widget.test.questions[currentQuestionIndex];
    var options = widget.test.options;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 20),
            child: Text(
              'Test',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Column(
                    children:
                        options.asMap().entries.map<Widget>((entry) {
                          int index = entry.key;
                          String optionText = entry.value;
                          // ignore: unused_local_variable
                          bool isSelected = selectedOption == index;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedOption = index;
                              });
                            },
                            child: Option(
                              optionText: optionText,
                              isSelected: selectedOption == index,
                              onTap: () {
                                setState(() {
                                  selectedOption = index;
                                });
                              },
                            ),
                          );
                        }).toList(),
                  ),

                  const Spacer(),

                  if (selectedOption != null)
                    Button(
                      text: "Next",
                      onPressed: () {
                        if (currentQuestionIndex <
                            widget.test.questions.length - 1) {
                          setState(() {
                            currentQuestionIndex++;
                            responses.add(selectedOption!);
                            selectedOption = null;
                          });
                        } else {
                          responses.add(selectedOption!);
                          Map<String, dynamic> report = widget.test
                              .generateReport(responses);
                          _authController.storeReport(_auth.currentUser!.uid, widget.test.name, report);
                          Get.off(
                            ReportScreen(
                              report: report,
                              name: widget.test.name,
                            ),
                          );
                        }
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
