import 'dart:ui';
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
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Column(
        children: [
          // Decorated Top Bar
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFFFB3BA),
                  const Color(0xFFFFB3BA).withOpacity(0.85),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFB3BA).withOpacity(0.2),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 20 : 32,
                  vertical: isMobile ? 16 : 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Logo/Title
                    Text(
                      'Smoofy',
                      style: TextStyle(
                        fontSize: ResponsiveHelper.getResponsiveFontSize(
                          context,
                          32,
                        ),
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.2),
                            offset: const Offset(0, 2),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                    ),
                    // Action Icons
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.notifications_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.shopping_bag_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: isMobile ? 24 : 32),

                  // Categories Section
                  _buildCategoriesSection(context),

                  SizedBox(height: isMobile ? 24 : 32),

                  // Most Popular Section
                  _buildMostPopularSection(context),

                  // Bottom padding to avoid content being hidden behind nav bar
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildCategoriesSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    final categories = [
      {
        'name': 'Juices',
        'color': const Color(0xFF4A90E2),
        'icon': Icons.local_drink,
      },
      {
        'name': 'Smoothies',
        'color': const Color(0xFFFFB3BA),
        'icon': Icons.blender,
      },
      {
        'name': 'Detox drinks',
        'color': const Color(0xFF2D3436),
        'icon': Icons.spa,
      },
      {
        'name': 'Milk Shakes',
        'color': const Color(0xFF8B7355),
        'icon': Icons.cake,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 32),
          child: Text(
            'Categories',
            style: TextStyle(
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 28),
              fontWeight: FontWeight.bold,
              color: const Color(0xFFFFB3BA),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 130,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 28),
            physics: const BouncingScrollPhysics(),
            itemCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return GestureDetector(
                onTap: () {
                  // Handle category tap
                },
                child: Container(
                  width: 100,
                  margin: const EdgeInsets.only(right: 16, bottom: 8),
                  child: Column(
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              category['color'] as Color,
                              (category['color'] as Color).withOpacity(0.8),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: (category['color'] as Color).withOpacity(
                                0.4,
                              ),
                              blurRadius: 12,
                              offset: const Offset(0, 6),
                              spreadRadius: 0,
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Icon(
                          category['icon'] as IconData,
                          color: Colors.white,
                          size: 40,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        category['name'] as String,
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getResponsiveFontSize(
                            context,
                            12,
                          ),
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF2D3436),
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildMostPopularSection(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 32),
          child: Text(
            'Most Popular',
            style: TextStyle(
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 24),
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2D3436),
            ),
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 32),
          itemCount: smoothieList.length > 5 ? 5 : smoothieList.length,
          itemBuilder: (context, index) {
            final smoothie = smoothieList[index];
            return AnimatedOpacity(
              opacity: 1.0,
              duration: Duration(milliseconds: 300 + (index * 100)),
              child: _buildMostPopularCard(context, smoothie),
            );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildMostPopularCard(BuildContext context, Smoothie smoothie) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                DetailScreen(smoothie: smoothie),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(32),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFFFB3BA).withOpacity(0.15),
              blurRadius: 24,
              offset: const Offset(0, 10),
              spreadRadius: 0,
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Section with rating badge
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(32),
                  child: CachedNetworkImage(
                    imageUrl: smoothie.imagePath,
                    height: ResponsiveHelper.getResponsiveHeight(
                      context,
                      mobile: 220,
                      tablet: 280,
                      desktop: 320,
                    ),
                    width: double.infinity,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: ResponsiveHelper.getResponsiveHeight(
                        context,
                        mobile: 220,
                        tablet: 280,
                        desktop: 320,
                      ),
                      color: Colors.grey[200],
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Color(0xFFFFB3BA),
                        ),
                      ),
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: ResponsiveHelper.getResponsiveHeight(
                        context,
                        mobile: 220,
                        tablet: 280,
                        desktop: 320,
                      ),
                      color: Colors.grey[200],
                      child: Center(
                        child: _buildSmoothieImage(
                          color: const Color(0xFFFFB3BA),
                          height: 160,
                        ),
                      ),
                    ),
                  ),
                ),
                // Rating Badge
                Positioned(
                  top: 12,
                  left: 12,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '4.8',
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getResponsiveFontSize(
                              context,
                              14,
                            ),
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2D3436),
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(
                          Icons.star,
                          color: Color(0xFFFFC107),
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                // Label Badge (bottom left)
                Positioned(
                  bottom: 12,
                  left: 12,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Fresh juice of',
                        style: TextStyle(
                          fontSize: ResponsiveHelper.getResponsiveFontSize(
                            context,
                            12,
                          ),
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFB3BA),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          smoothie.name,
                          style: TextStyle(
                            fontSize: ResponsiveHelper.getResponsiveFontSize(
                              context,
                              14,
                            ),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFFFFB3BA).withOpacity(0.85),
                  const Color(0xFFFFB3BA).withOpacity(0.75),
                ],
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFFB3BA).withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                  spreadRadius: 0,
                ),
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNavItem(Icons.home, 0),
                    _buildNavItem(Icons.search, 1),
                    _buildNavItem(Icons.favorite, 2),
                    _buildNavItem(Icons.timer, 3),
                    _buildNavItem(Icons.person, 4),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(IconData icon, int index) {
    final isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
        // Handle navigation based on index
        switch (index) {
          case 0:
            // Home - already here
            break;
          case 1:
            // Search
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Search page coming soon!'),
                duration: Duration(seconds: 1),
              ),
            );
            break;
          case 2:
            // Favorites
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Favorites page coming soon!'),
                duration: Duration(seconds: 1),
              ),
            );
            break;
          case 3:
            // Timer/History
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('History page coming soon!'),
                duration: Duration(seconds: 1),
              ),
            );
            break;
          case 4:
            // Profile
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile page coming soon!'),
                duration: Duration(seconds: 1),
              ),
            );
            break;
        }
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: isSelected
            ? BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              )
            : null,
        child: Icon(
          icon,
          color: isSelected ? Colors.white : Colors.white.withOpacity(0.5),
          size: 24,
        ),
      ),
    );
  }
}
