import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/smoothie.dart';
import '../utils/responsive_helper.dart';

class DetailScreen extends StatefulWidget {
  final Smoothie smoothie;

  const DetailScreen({super.key, required this.smoothie});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOutBack),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveHelper.isMobile(context);
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: const Color(0xFF2B2B3D),
      body: SafeArea(
        child: Stack(
          children: [
            // Main Content
            SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: AnimatedBuilder(
                animation: _animationController,
                builder: (context, child) {
                  return FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hero Smoothie Image Section
                        ScaleTransition(
                          scale: _scaleAnimation,
                          child: Container(
                            height: ResponsiveHelper.getResponsiveHeight(
                              context,
                              mobile: screenHeight * 0.5,
                              tablet: screenHeight * 0.55,
                              desktop: screenHeight * 0.6,
                            ),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  _getSmoothieColor().withOpacity(0.3),
                                  const Color(0xFF2B2B3D),
                                ],
                              ),
                            ),
                            child: Hero(
                              tag: 'smoothie_${widget.smoothie.id}',
                              child: CachedNetworkImage(
                                imageUrl: widget.smoothie.imagePath,
                                fit: BoxFit.contain,
                                height: ResponsiveHelper.getResponsiveHeight(
                                  context,
                                  mobile: screenHeight * 0.4,
                                  tablet: screenHeight * 0.45,
                                  desktop: screenHeight * 0.5,
                                ),
                                placeholder: (context, url) => Center(
                                  child: CircularProgressIndicator(
                                    color: _getSmoothieColor(),
                                  ),
                                ),
                                errorWidget: (context, url, error) => Center(
                                  child: _buildHeroSmoothieImage(
                                    height: ResponsiveHelper.getResponsiveHeight(
                                      context,
                                      mobile: screenHeight * 0.4,
                                      tablet: screenHeight * 0.45,
                                      desktop: screenHeight * 0.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Details Section
                        Padding(
                          padding: ResponsiveHelper.getResponsivePadding(context),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              
                              // Title
                              Text(
                                widget.smoothie.name,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ResponsiveHelper.getResponsiveFontSize(context, 32),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              
                              const SizedBox(height: 12),
                              
                              // Description
                              Text(
                                widget.smoothie.description,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: ResponsiveHelper.getResponsiveFontSize(context, 16),
                                  height: 1.5,
                                ),
                              ),
                              
                              const SizedBox(height: 30),
                              
                              // Ingredients Section
                              Text(
                                'Ingredients',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: ResponsiveHelper.getResponsiveFontSize(context, 20),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              
                              const SizedBox(height: 16),
                              
                              Wrap(
                                spacing: 12,
                                runSpacing: 12,
                                children: widget.smoothie.ingredients.map((ingredient) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isMobile ? 16 : 20,
                                      vertical: isMobile ? 10 : 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF3A3A4D),
                                      borderRadius: BorderRadius.circular(20),
                                      border: Border.all(
                                        color: _getSmoothieColor().withOpacity(0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      ingredient,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              
                              const SizedBox(height: 30),
                              
                              // Nutrition Info (Mock)
                              Container(
                                padding: EdgeInsets.all(isMobile ? 20 : 24),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3A3A4D),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Nutrition Facts',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: ResponsiveHelper.getResponsiveFontSize(context, 18),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    _buildNutritionRow('Calories', '250 kcal'),
                                    _buildNutritionRow('Protein', '8g'),
                                    _buildNutritionRow('Carbs', '45g'),
                                    _buildNutritionRow('Fat', '5g'),
                                  ],
                                ),
                              ),
                              
                              SizedBox(height: isMobile ? 100 : 120),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Top Bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: ResponsiveHelper.getResponsivePadding(context),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFF2B2B3D),
                      const Color(0xFF2B2B3D).withOpacity(0.0),
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: ResponsiveHelper.getResponsiveFontSize(context, 24),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.favorite_border,
                        color: Colors.white,
                        size: ResponsiveHelper.getResponsiveFontSize(context, 28),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Add to Cart Button
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: ResponsiveHelper.getResponsivePadding(context),
                decoration: BoxDecoration(
                  color: const Color(0xFF2B2B3D),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, -10),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Price
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Price',
                          style: TextStyle(
                            color: Colors.white54,
                            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$${widget.smoothie.price.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: ResponsiveHelper.getResponsiveFontSize(context, 28),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 24),
                    
                    // Add to Cart Button
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _showAddedToCartSnackbar();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _getSmoothieColor(),
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            vertical: isMobile ? 18 : 22,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 8,
                          shadowColor: _getSmoothieColor().withOpacity(0.5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              size: ResponsiveHelper.getResponsiveFontSize(context, 22),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Add to cart',
                              style: TextStyle(
                                fontSize: ResponsiveHelper.getResponsiveFontSize(context, 18),
                                fontWeight: FontWeight.bold,
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
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSmoothieImage({required double height}) {
    final color = _getSmoothieColor();
    
    return Hero(
      tag: 'smoothie_${widget.smoothie.id}',
      child: Container(
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
              color: color.withOpacity(0.5),
              blurRadius: 50,
              spreadRadius: 10,
              offset: const Offset(0, 20),
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
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 5,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
            ),
            // Straw bend
            Positioned(
              top: height * 0.03,
              left: height * 0.15,
              child: Container(
                width: height * 0.08,
                height: height * 0.03,
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
                      Colors.white.withOpacity(0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            // Highlight shine
            Positioned(
              left: height * 0.1,
              top: height * 0.2,
              child: Container(
                width: height * 0.15,
                height: height * 0.3,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withOpacity(0.3),
                      Colors.transparent,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(height * 0.1),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutritionRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white70,
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: ResponsiveHelper.getResponsiveFontSize(context, 14),
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getSmoothieColor() {
    switch (widget.smoothie.id) {
      case '1':
        return const Color(0xFF8B4A7C);
      case '2':
        return const Color(0xFF6B4423);
      case '3':
        return const Color(0xFFE84A5F);
      case '4':
        return const Color(0xFFFF8C42);
      case '5':
        return const Color(0xFF88B04B);
      default:
        return const Color(0xFF8B4A7C);
    }
  }

  void _showAddedToCartSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: Colors.white,
              size: ResponsiveHelper.getResponsiveFontSize(context, 24),
            ),
            const SizedBox(width: 12),
            Text(
              'Added to cart!',
              style: TextStyle(
                fontSize: ResponsiveHelper.getResponsiveFontSize(context, 16),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        backgroundColor: _getSmoothieColor(),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
