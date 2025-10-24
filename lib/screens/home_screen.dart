import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../models/smoothie.dart';
import '../utils/responsive_helper.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _carouselIndex = 0;
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Scaffold(
      backgroundColor: const Color(0xFF4B5563),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF606A75), Color(0xFF454C55)],
            ),
          ),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 32,
              vertical: isMobile ? 12 : 24,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top right action icons
                Align(
                  alignment: Alignment.topRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                          size: ResponsiveHelper.getResponsiveFontSize(
                            context,
                            24,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.settings_outlined,
                          color: Colors.white,
                          size: ResponsiveHelper.getResponsiveFontSize(
                            context,
                            24,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: isMobile ? 12 : 20),

                // Carousel Section
                _buildCarouselSection(context),

                SizedBox(height: isMobile ? 28 : 44),

                // Vertical List Section (best seller + recommended)
                _buildVerticalList(context),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildCarouselSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final double height = ResponsiveHelper.getResponsiveHeight(
      context,
      mobile: 240,
      tablet: 300,
      desktop: 340,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured smoothies',
          style: TextStyle(
            color: Colors.white,
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 20),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 12),
        CarouselSlider.builder(
          itemCount: smoothieList.length,
          carouselController: _carouselController,
          itemBuilder: (context, index, realIdx) {
            final smoothie = smoothieList[index];
            return _buildCarouselCard(context, smoothie, height);
          },
          options: CarouselOptions(
            height: height,
            viewportFraction: isMobile ? 0.88 : 0.5,
            enlargeCenterPage: true,
            enlargeFactor: 0.22,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 700),
            autoPlayCurve: Curves.easeInOutCubic,
            onPageChanged: (i, reason) {
              setState(() => _carouselIndex = i);
            },
          ),
        ),
        const SizedBox(height: 14),
        Center(
          child: AnimatedSmoothIndicator(
            activeIndex: _carouselIndex,
            count: smoothieList.length,
            effect: ExpandingDotsEffect(
              dotHeight: isMobile ? 7 : 9,
              dotWidth: isMobile ? 7 : 9,
              expansionFactor: 3.2,
              activeDotColor: const Color(0xFF8B4A7C),
              dotColor: Colors.white30,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCarouselCard(
    BuildContext context,
    Smoothie smoothie,
    double height,
  ) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final cardWidth = ResponsiveHelper.getResponsiveWidth(
      context,
      mobile: MediaQuery.of(context).size.width - 40,
      tablet: 520,
      desktop: 600,
    );
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DetailScreen(smoothie: smoothie),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            transitionDuration: const Duration(milliseconds: 320),
          ),
        );
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: cardWidth,
            margin: EdgeInsets.symmetric(
              horizontal: isMobile ? 4 : 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF636973), Color(0xFF565C65)],
              ),
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: const Color(0xFF787E88), width: 0.8),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.28),
                  blurRadius: 22,
                  offset: const Offset(0, 10),
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.06),
                  blurRadius: 6,
                  spreadRadius: -2,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 16 : 24),
              child: Row(
                children: [
                  // Left details
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          smoothie.name,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ResponsiveHelper.getResponsiveFontSize(
                              context,
                              18,
                            ),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.25,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          smoothie.ingredients.take(3).join('\n').toLowerCase(),
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.85),
                            fontSize: ResponsiveHelper.getResponsiveFontSize(
                              context,
                              12,
                            ),
                            height: 1.22,
                            letterSpacing: 0.15,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '\$${smoothie.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ResponsiveHelper.getResponsiveFontSize(
                              context,
                              19,
                            ),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: const Text('Added to cart!'),
                                      backgroundColor: const Color(0xFF8B4A7C),
                                      behavior: SnackBarBehavior.floating,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      duration: const Duration(seconds: 2),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF8B4A7C),
                                  foregroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile ? 12 : 16,
                                    vertical: isMobile ? 8 : 10,
                                  ),
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Text(
                                  'Add',
                                  style: TextStyle(
                                    fontSize:
                                        ResponsiveHelper.getResponsiveFontSize(
                                          context,
                                          11,
                                        ),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              width: isMobile ? 36 : 40,
                              height: isMobile ? 36 : 40,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.15),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white24,
                                  width: 1,
                                ),
                              ),
                              child: Icon(
                                Icons.favorite_border,
                                color: Colors.white,
                                size: ResponsiveHelper.getResponsiveFontSize(
                                  context,
                                  18,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Right image circle
                  Expanded(
                    flex: 5,
                    child: Align(
                      alignment: Alignment.center,
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFF7F848E), Color(0xFF5A616B)],
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.32),
                                blurRadius: 26,
                                offset: const Offset(0, 9),
                              ),
                            ],
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(isMobile ? 12 : 18),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: smoothie.imagePath,
                                fit: BoxFit.cover,
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: const Color(0xFF8B4A7C),
                                    strokeWidth: 2.4,
                                  ),
                                ),
                                errorWidget: (context, url, error) =>
                                    _buildSmoothieImage(
                                      color: const Color(0xFF8B4A7C),
                                      height: height * 0.5,
                                    ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (smoothie.id == '1' || smoothie.category == 'featured')
            Positioned(
              top: 6,
              right: 10,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.bookmark,
                  color: const Color(0xFF8B4A7C),
                  size: ResponsiveHelper.getResponsiveFontSize(context, 18),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildVerticalList(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Our best-seller',
          style: TextStyle(
            color: Colors.white,
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 18),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildProductCard(context, smoothieList[0], isBookmarked: true),
        const SizedBox(height: 24),
        Text(
          'Recommended for you',
          style: TextStyle(
            color: Colors.white,
            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 18),
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 16),
        _buildProductCard(context, smoothieList[1], isBookmarked: false),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _buildProductCard(
    BuildContext context,
    Smoothie smoothie, {
    required bool isBookmarked,
  }) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DetailScreen(smoothie: smoothie),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) =>
                    FadeTransition(opacity: animation, child: child),
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white.withOpacity(0.95),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: ResponsiveHelper.getResponsiveHeight(
                    context,
                    mobile: 200,
                    tablet: 250,
                    desktop: 300,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Color(0xFFE8E8ED), Color(0xFFF5F5F7)],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: CachedNetworkImage(
                      imageUrl: smoothie.imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFF8B4A7C),
                        ),
                      ),
                      errorWidget: (context, url, error) => Center(
                        child: _buildSmoothieImage(
                          color: smoothie.id == '1'
                              ? const Color(0xFF8B4A7C)
                              : const Color(0xFF6B4423),
                          height: ResponsiveHelper.getResponsiveHeight(
                            context,
                            mobile: 160,
                            tablet: 200,
                            desktop: 240,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                if (isBookmarked)
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.bookmark,
                        color: const Color(0xFF8B4A7C),
                        size: ResponsiveHelper.getResponsiveFontSize(
                          context,
                          20,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(isMobile ? 16 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    smoothie.name,
                    style: TextStyle(
                      color: const Color(0xFF8B4A7C),
                      fontSize: ResponsiveHelper.getResponsiveFontSize(
                        context,
                        18,
                      ),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    smoothie.description,
                    style: TextStyle(
                      color: const Color(0xFF6B7280),
                      fontSize: ResponsiveHelper.getResponsiveFontSize(
                        context,
                        12,
                      ),
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '\$${smoothie.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: const Color(0xFF1F2937),
                            fontSize: ResponsiveHelper.getResponsiveFontSize(
                              context,
                              20,
                            ),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Added to cart!'),
                              backgroundColor: const Color(0xFF8B4A7C),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              duration: const Duration(seconds: 2),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF8B4A7C),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: isMobile ? 12 : 16,
                            vertical: isMobile ? 8 : 10,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'Add to cart',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getResponsiveFontSize(
                              context,
                              11,
                            ),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: const Color(0xFFE5E7EB),
                            width: 1,
                          ),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: ResponsiveHelper.getResponsiveFontSize(
                            context,
                            12,
                          ),
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmoothieImage({required Color color, required double height}) {
    return Container(
      height: height,
      width: height * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(height * 0.3),
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withOpacity(0.8), color],
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.4),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: height * 0.05,
            left: height * 0.2,
            child: Container(
              width: height * 0.03,
              height: height * 0.4,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(height * 0.015),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: height * 0.15,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(height * 0.3),
                  topRight: Radius.circular(height * 0.3),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.white.withOpacity(0.4), Colors.transparent],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF6B7280),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.home,
                color: const Color(0xFFE84A5F),
                size: ResponsiveHelper.getResponsiveFontSize(context, 28),
              ),
              Icon(
                Icons.favorite_border,
                color: Colors.white70,
                size: ResponsiveHelper.getResponsiveFontSize(context, 28),
              ),
              Icon(
                Icons.person_outline,
                color: Colors.white70,
                size: ResponsiveHelper.getResponsiveFontSize(context, 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
