import 'package:flutter/material.dart';
import 'package:myapp/screens/login_signup_screen.dart';
import '../models/onboarding_model.dart';
import '../widgets/onboarding_item.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<OnboardingItem> onboardingItems = [
    OnboardingItem(
      image: 'assets/onboarding1.png',
      title: 'Fresh Groceries Delivered',
      description:
          'Get fresh and organic groceries delivered to your doorstep quickly.',
    ),
    OnboardingItem(
      image: 'assets/onboarding1.png',
      title: 'Shop Daily Essentials',
      description:
          'All your daily needs – vegetables, fruits, milk, and more in one place.',
    ),
    OnboardingItem(
      image: 'assets/onboarding1.png',
      title: 'Fast & Secure Checkout',
      description: 'Experience secure payments and quick order placement.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _controller,
            itemCount: onboardingItems.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              final item = onboardingItems[index];
              return OnboardingItemWidget(
                image: item.image,
                title: item.title,
                description: item.description,
              );
            },
          ),
          Positioned(
            bottom: 60,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentIndex < onboardingItems.length - 1)
                  TextButton(
                    child: Text('Skip'),
                    onPressed: () {
                      _finishOnboarding();
                    },
                  ),
                Row(
                  children: List.generate(
                    onboardingItems.length,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color:
                            index == _currentIndex ? Colors.green : Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  child: Text(
                    _currentIndex == onboardingItems.length - 1
                        ? 'Done'
                        : 'Next',
                  ),
                  onPressed: () {
                    if (_currentIndex == onboardingItems.length - 1) {
                      _finishOnboarding();
                    } else {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _finishOnboarding() {
    // Navigate to login or home
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => LoginSignupScreen()), // Replace with actual screen
    );
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text('Welcome to Screenova'),
    //     duration: Duration(seconds: 2),
    //   ),
    // );
  }
}
