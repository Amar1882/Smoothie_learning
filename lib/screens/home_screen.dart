import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/smoothie.dart';
import '../utils/responsive_helper.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Scaffold(
      backgroundColor: const Color(0xFF6B7280),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top Header with Menu and Settings
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 24,
                  vertical: isMobile ? 12 : 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        size: ResponsiveHelper.getResponsiveFontSize(context, 24),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.settings_outlined,
                        color: Colors.white,
                        size: ResponsiveHelper.getResponsiveFontSize(context, 24),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: isMobile ? 10 : 20),

              // Vertical List Section
              _buildVerticalList(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }



  Widget _buildVerticalList(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Our best-seller section
          Text(
            'Our best-seller',
            style: TextStyle(
              color: Colors.white,
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 18),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // Best seller card
          _buildProductCard(
            context,
            smoothieList[0],
            isBookmarked: true,
          ),
          const SizedBox(height: 24),
          
          // Recommended section
          Text(
            'Recommended for you',
            style: TextStyle(
              color: Colors.white,
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 18),
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 16),

          // Recommended card
          _buildProductCard(
            context,
            smoothieList[1],
            isBookmarked: false,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Smoothie smoothie, {required bool isBookmarked}) {
    final isMobile = ResponsiveHelper.isMobile(context);
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DetailScreen(smoothie: smoothie),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              return FadeTransition(opacity: animation, child: child);
            },
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
            // Image Section with bookmark
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
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        const Color(0xFFE8E8ED),
                        const Color(0xFFF5F5F7),
                      ],
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                    child: CachedNetworkImage(
                      imageUrl: smoothie.imagePath,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      placeholder: (context, url) => Center(
                        child: CircularProgressIndicator(
                          color: const Color(0xFF8B4A7C),
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
                        size: ResponsiveHelper.getResponsiveFontSize(context, 20),
                      ),
                    ),
                  ),
              ],
            ),

            // Details Section
            Padding(
              padding: EdgeInsets.all(isMobile ? 16 : 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    smoothie.name,
                    style: TextStyle(
                      color: const Color(0xFF8B4A7C),
                      fontSize: ResponsiveHelper.getResponsiveFontSize(context, 18),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    smoothie.description,
                    style: TextStyle(
                      color: const Color(0xFF6B7280),
                      fontSize: ResponsiveHelper.getResponsiveFontSize(context, 12),
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
                            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 20),
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
                            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 11),
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
                          size: ResponsiveHelper.getResponsiveFontSize(context, 12),
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
          colors: [
            color.withOpacity(0.8),
            color,
          ],
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
          // Straw
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
          // Foam effect
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
                  colors: [
                    Colors.white.withOpacity(0.4),
                    Colors.transparent,
                  ],
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
