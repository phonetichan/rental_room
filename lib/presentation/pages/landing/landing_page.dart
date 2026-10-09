import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../data/data.dart';
import '../../../di/di.dart';
import '../../styles/styles.dart';
import '../auth/login/login_page.dart';

class LandingPage extends StatefulWidget {
  static const String routePath = '/landing';
  static const String routeName = 'landing';

  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  Timer? _autoSlideTimer;

  static const Duration _autoSlideInterval = Duration(seconds: 4);

  final List<_LandingModel> _slides = const [
    _LandingModel(
      title: 'Find the perfect place for your future house',
      description:
      'Find the best place for your dream house with your family and loved ones',
    ),
    _LandingModel(
      title: 'Fast rent your property in just one click',
      description:
      'Simplify the property sales process with just your smartphone',
    ),
    _LandingModel(
      title: 'Find your dream home with us',
      description:
      'Just search and select your favorite property you want to locate',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  @override
  void dispose() {
    _stopAutoSlide();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoSlide() {
    _stopAutoSlide();
    _autoSlideTimer = Timer.periodic(_autoSlideInterval, (timer) {
      if (_currentPage < _slides.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      } else {
        _pageController.animateToPage(
          0,
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _stopAutoSlide() {
    _autoSlideTimer?.cancel();
    _autoSlideTimer = null;
  }

  Future<void> _completeLanding() async {
    _stopAutoSlide();
    await inject<AppStorage>().setIsNewInstall(false);
    if (mounted) {
      context.go(LoginPage.routePath);
    }
  }

  void _onNext() {
    _startAutoSlide(); // Reset timer on manual button press
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeLanding();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // TOP BAR: SKIP BUTTON
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: $styles.insets.sm,
                vertical: $styles.insets.xs,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_currentPage < _slides.length - 1)
                    TextButton(
                      onPressed: _completeLanding,
                      child: Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: 48),
                ],
              ),
            ),

            // PAGE VIEW SLIDER WITH LISTENER FOR MANUAL TOUCH INTERACTION
            Expanded(
              child: NotificationListener<UserScrollNotification>(
                onNotification: (notification) {
                  // Pause timer during active manual user dragging/gestures
                  _startAutoSlide();
                  return false;
                },
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _slides.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final slide = _slides[index];
                    return Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: $styles.grid.columnsMargin,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _OverlappingImages(pageIndex: index),
                          SizedBox(height: $styles.insets.lg),
                          Text(
                            slide.title,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                          SizedBox(height: $styles.insets.xs),
                          Text(
                            slide.description,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.bodyLarge?.copyWith(
                              height: 1.4,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),

            // PAGE INDICATOR DOTS
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _slides.length,
                    (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: EdgeInsets.symmetric(
                    horizontal: $styles.insets.xs / 2,
                  ),
                  height: 8,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? $styles.color.clrPrimary
                        : $styles.color.clrSoftGrey,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ),
            SizedBox(height: $styles.insets.md),

            // BOTTOM NAVIGATION ACTION BUTTON
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: $styles.grid.columnsMargin,
              ).copyWith(bottom: $styles.insets.md),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: $styles.color.clrPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentPage == _slides.length - 1 ? 'Get Started' : 'Next',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: $styles.color.clrWhite,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LandingModel {
  final String title;
  final String description;

  const _LandingModel({required this.title, required this.description});
}

class _OverlappingImages extends StatelessWidget {
  final int pageIndex;

  const _OverlappingImages({super.key, required this.pageIndex});

  @override
  Widget build(BuildContext context) {
    const double cardWidth = 160.0;
    const double cardHeight = 240.0;
    const double stadiumRadius = cardWidth / 2;

    final String mainImage = pageIndex == 1
        ? 'assets/brand/landing2.png'
        : 'assets/brand/landing1.png';
    final String secondaryImage = pageIndex == 1
        ? 'assets/brand/landing1.png'
        : 'assets/brand/landing2.png';

    final bool isOpposite = pageIndex == 1;

    return FittedBox(
      fit: BoxFit.scaleDown,
      child: SizedBox(
        width: 270,
        height: 320,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              top: 70,
              left: isOpposite ? 10 : null,
              right: isOpposite ? null : 10,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(stadiumRadius),
                child: Image.asset(
                  secondaryImage,
                  width: cardWidth,
                  height: cardHeight,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                  const SizedBox.shrink(),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: isOpposite ? null : 10,
              right: isOpposite ? 10 : null,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(stadiumRadius),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.12),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: Offset(isOpposite ? -4 : 4, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(stadiumRadius),
                  child: Image.asset(
                    mainImage,
                    width: cardWidth,
                    height: cardHeight,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                    const SizedBox.shrink(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}