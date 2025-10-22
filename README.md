# Smoothie Plus - Flutter App

A beautiful, responsive Flutter application for a smoothie shop with smooth animations and an elegant UI design.

## Features

✨ **Two Screen Design**
- **Home Screen**: Features horizontal carousel, vertical product list, and beautiful card designs
- **Detail Screen**: Full-screen view of smoothie items with detailed information

🎨 **Beautiful UI**
- Purple/pink gradient theme matching the reference design
- Dark, modern background (Color: #2B2B3D)
- Smooth 60 FPS animations throughout
- Custom smoothie glass illustrations with foam effects and straws

📱 **Fully Responsive**
- Dynamic sizing for mobile devices
- Optimized for Chrome web browser
- Tablet support with scaled UI elements
- Desktop-friendly layout

⚡ **Performance Optimized**
- Smooth carousel transitions with BouncingScrollPhysics
- Hero animations between screens
- Optimized widget rebuilds
- Hardware-accelerated animations

## Screens

### 1. Home Screen
- **Header**: "SMOOTHIE PLUS" logo with gradient background
- **Featured Section**: Large smoothie image with call-to-action button
- **Horizontal Carousel**: Auto-playing carousel with page indicators
- **Product Cards**: "Our best-seller" and "Recommended for you" sections
- **Bottom Navigation**: Home, Favorites, and Profile icons

### 2. Detail Screen
- **Hero Image**: Large, animated smoothie display
- **Product Details**: Name, description, and price
- **Ingredients**: Chips showing all ingredients
- **Nutrition Facts**: Calorie and macro information
- **Add to Cart**: Prominent button with snackbar confirmation

## Getting Started

### Prerequisites
- Flutter SDK (3.9.0 or higher)
- Dart SDK
- VS Code or Android Studio

### Installation

1. **Get dependencies** (already done)
   ```bash
   flutter pub get
   ```

2. **Run the app**
   
   For mobile (Android/iOS):
   ```bash
   flutter run
   ```
   
   For Chrome:
   ```bash
   flutter run -d chrome
   ```

## Project Structure

```
lib/
├── main.dart                 # App entry point with theme configuration
├── models/
│   └── smoothie.dart        # Smoothie data model
├── screens/
│   ├── home_screen.dart     # Main home screen with carousels
│   └── detail_screen.dart   # Product detail screen
└── utils/
    └── responsive_helper.dart # Responsive design utilities
```

## Customization

### Colors
The app uses a dark theme with the following primary colors:
- Background: `#2B2B3D`
- Card Background: `#3A3A4D`
- Primary Purple: `#8B4A7C`
- Accent Gray: `#6B7280`

### Smoothie Data
Edit `lib/models/smoothie.dart` to add or modify smoothie items.

### Responsive Breakpoints
Adjust in `lib/utils/responsive_helper.dart`:
- Mobile: < 650px
- Tablet: 650px - 1100px
- Desktop: > 1100px

## Dependencies

```yaml
carousel_slider: ^5.0.0          # Smooth carousel implementation
smooth_page_indicator: ^1.2.0+3  # Beautiful page indicators
```

## Running on Different Platforms

### Android
```bash
flutter run -d android
```

### iOS
```bash
flutter run -d ios
```

### Windows
```bash
flutter run -d windows
```

### Web (Chrome)
```bash
flutter run -d chrome --web-renderer html
```

Enjoy your Smoothie Plus app! 🥤✨
