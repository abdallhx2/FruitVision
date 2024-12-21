import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final PageController _pageController;
  late final AnimationController _animationController;
  late final Animation<double> _slideAnimation;

  int _currentPage = 0;

  static const List<WelcomeSlide> slides = [
    WelcomeSlide(
      title: 'Smart Fruit Analysis',
      description:
          'Discover advanced technology that uses artificial intelligence to analyze fruit quality with over 90% accuracy. All you need is one photo for instant evaluation.',
      image: 'assets/images/1.png',
    ),
    WelcomeSlide(
      title: 'Automated Quality Check',
      description:
          'An integrated system that detects damaged fruits and automatically classifies their quality. Saves you time and effort in sorting and classification.',
      image: 'assets/images/2.png',
    ),
    WelcomeSlide(
      title: 'Ripeness Prediction',
      description:
          'Get accurate predictions for fruit ripening times and development stages. Helps you improve crop management and reduce waste.',
      image: 'assets/images/3.png',
    ),
    WelcomeSlide(
      title: 'WELCOME',
      description: '',
      image: 'assets/images/1.png',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _slideAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _handlePageChange(int page) async {
    setState(() => _currentPage = page);
    await _animationController.forward(from: 0);
  }

  void _navigateToNextPage() {
    if (_currentPage < slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _navigateToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _skipToEnd() {
    _pageController.animateToPage(
      slides.length - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = _currentPage == slides.length - 1;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            PageView.builder(
              controller: _pageController,
              onPageChanged: _handlePageChange,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: slides.length,
              itemBuilder: (context, index) => _buildPage(index),
            ),

            // Back button - only on the last page
            if (isLastPage)
              Positioned(
                top: 16,
                left: 16,
                child: IconButton(
                  onPressed: _navigateToPreviousPage,
                  icon: const Icon(
                    Icons.chevron_left,
                    color: Color(0xFF2E7D32),
                    size: 32,
                  ),
                ),
              ),

            // Navigation bar - only on non-last pages
            if (!isLastPage)
              Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Column(
                  children: [
                    // Page Indicator
                    _PageIndicator(
                      currentPage: _currentPage,
                      totalPages: slides.length - 1, // Exclude welcome page
                    ),
                    const SizedBox(height: 20),
                    // Navigation Buttons
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Back button
                          if (_currentPage > 0)
                            IconButton(
                              onPressed: _navigateToPreviousPage,
                              icon: const Icon(
                                Icons.chevron_left,
                                color: Color(0xFF2E7D32),
                                size: 32,
                              ),
                            )
                          else
                            const SizedBox(width: 48),

                          // Skip button
                          TextButton(
                            onPressed: _skipToEnd,
                            child: const Text(
                              'Skip',
                              style: TextStyle(
                                color: Color(0xFF2E7D32),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                          // Next button
                          IconButton(
                            onPressed: _navigateToNextPage,
                            icon: const Icon(
                              Icons.chevron_right,
                              color: Color(0xFF2E7D32),
                              size: 32,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage(int index) {
    final bool isWelcomePage = index == slides.length - 1;

    if (isWelcomePage) {
      return _WelcomePage(
        animation: _slideAnimation,
        slide: slides[index],
      );
    }

    return _OnboardingPage(
      animation: _slideAnimation,
      slide: slides[index],
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  final Animation<double> animation;
  final WelcomeSlide slide;

  const _OnboardingPage({
    required this.animation,
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated Image
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Transform.translate(
              offset: Offset(0, (1 - animation.value) * -100),
              child: child,
            ),
            child: Image.asset(
              slide.image,
              height: 250,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 40),
          // Animated Text
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Transform.translate(
              offset: Offset(0, (1 - animation.value) * 100),
              child: child,
            ),
            child: Column(
              children: [
                Text(
                  slide.title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  slide.description,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  final Animation<double> animation;
  final WelcomeSlide slide;

  const _WelcomePage({
    required this.animation,
    required this.slide,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated Logo
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Transform.translate(
              offset: Offset(0, (1 - animation.value) * -100),
              child: child,
            ),
            child: Image.asset(
              slide.image,
              height: 120,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(height: 40),
          // Animated Content
          AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Transform.translate(
              offset: Offset(0, (1 - animation.value) * 100),
              child: child,
            ),
            child: Column(
              children: [
                Text(
                  slide.title,
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2E7D32),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle sign in
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFD32F2F),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'SIGN IN',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Create Account Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      // Handle create account
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'CREATE ACCOUNT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Sign Up Options
                const Text(
                  'or Sign Up with',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 20),
                // Social Sign In Options
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _SocialButton(
                      onPressed: () {
                        // Handle Apple sign in
                      },
                      icon: const Icon(
                        Icons.apple,
                        color: Color(0xFF2E7D32),
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 32),
                    _SocialButton(
                      onPressed: () {
                        // Handle Google sign in
                      },
                      icon: Image.asset(
                        'assets/images/2.png',
                        height: 30,
                        width: 30,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const _PageIndicator({
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: currentPage == index ? 24 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: currentPage == index
                ? const Color(0xFF2E7D32)
                : Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}

class _SocialButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;

  const _SocialButton({
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
      padding: EdgeInsets.zero,
      iconSize: 30,
    );
  }
}

class WelcomeSlide {
  final String title;
  final String description;
  final String image;

  const WelcomeSlide({
    required this.title,
    required this.description,
    required this.image,
  });
}
