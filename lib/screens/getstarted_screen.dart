import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takecare/controllers/auth_controller.dart';
import 'package:takecare/screens/bottom_nav_bar.dart';

class GetStartedScreen extends StatefulWidget {
  static String id = 'getstarted-screen';
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  final AuthController _authController = Get.find<AuthController>();

  final List<Widget> _pages = [
    const PageContent(
      imageAsset: 'lib/images/puzzle.png',
      text: 'Know Yourself Better',
    ),
    const PageContent(
      imageAsset: 'lib/images/teddy.png',
      text: 'Heal Your Inner Child',
    ),
    const PageContent(
      imageAsset: 'lib/images/family.png',
      text: 'Be the Best Version of Yourself',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_currentPage == _pages.length - 1) {
        _controller.jumpToPage(0);
      } else {
        _controller.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
      _startAutoScroll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() => _authController.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 100,
                    child: PageView(
                      controller: _controller,
                      children: _pages,
                      onPageChanged: (index) {
                        setState(() {
                          _currentPage = index;
                        });
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                DotsIndicator(
                  dotsCount: _pages.length,
                  position: _currentPage,
                  decorator: DotsDecorator(
                    size: const Size.square(9.0),
                    activeSize: const Size(18.0, 9.0),
                    activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    activeColor: const Color.fromARGB(255, 27, 132, 219),
                  ),
                ),
                const SizedBox(height: 50),
                const Text(
                  'Ready to feel better?',
                  style: TextStyle(color: Colors.blueGrey, fontSize: 15),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade100,
                  ),
                  onPressed: () async {
                    await _authController.loginWithGoogle();
                    Get.offAll(() => BottomNavBar());
                                    },
                  icon: Image.asset('lib/images/google_logo.png', height: 24),
                  label: const Text('Sign in with Google', style: TextStyle(fontSize: 16, color: Colors.black)),
                ),
                const SizedBox(height: 40),
                const SizedBox(height: 50),
              ],
            )),
    );
  }
}

class PageContent extends StatelessWidget {
  final String imageAsset;
  final String text;

  const PageContent({super.key, required this.imageAsset, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: Image.asset(imageAsset)),
        Text(
          text,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.blueGrey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
