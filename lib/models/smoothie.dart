class Smoothie {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imagePath;
  final List<String> ingredients;
  final String category;

  Smoothie({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imagePath,
    required this.ingredients,
    required this.category,
  });
}

// Sample smoothie data with Google Photos URLs
final List<Smoothie> smoothieList = [
  Smoothie(
    id: '1',
    name: 'Berries smoothie',
    description: 'Blueberries, raspberries, classic',
    price: 21.00,
    imagePath: 'https://images.unsplash.com/photo-1553530666-ba11a7da3888?w=800&h=1200&fit=crop',
    ingredients: ['Blueberries', 'Raspberries', 'Strawberries', 'Yogurt'],
    category: 'bestseller',
  ),
  Smoothie(
    id: '2',
    name: 'Chocolate smoothie',
    description: 'Rich chocolate with cacao powder',
    price: 20.00,
    imagePath: 'https://images.unsplash.com/photo-1579954115545-a95591f28bfc?w=800&h=1200&fit=crop',
    ingredients: ['Cacao', 'Banana', 'Milk', 'Honey'],
    category: 'recommended',
  ),
  Smoothie(
    id: '3',
    name: 'Strawberry smoothie',
    description: 'Fresh strawberries and cream',
    price: 18.00,
    imagePath: 'https://images.unsplash.com/photo-1505252585461-04db1eb84625?w=800&h=1200&fit=crop',
    ingredients: ['Strawberries', 'Cream', 'Sugar', 'Ice'],
    category: 'featured',
  ),
  Smoothie(
    id: '4',
    name: 'Mango smoothie',
    description: 'Tropical mango delight',
    price: 19.00,
    imagePath: 'https://images.unsplash.com/photo-1600271886742-f049cd451bba?w=800&h=1200&fit=crop',
    ingredients: ['Mango', 'Yogurt', 'Honey', 'Ice'],
    category: 'featured',
  ),
  Smoothie(
    id: '5',
    name: 'Green detox',
    description: 'Healthy spinach and kiwi',
    price: 22.00,
    imagePath: 'https://images.unsplash.com/photo-1610970881699-44a5587cabec?w=800&h=1200&fit=crop',
    ingredients: ['Spinach', 'Kiwi', 'Apple', 'Lime'],
    category: 'recommended',
  ),
  Smoothie(
    id: '6',
    name: 'Banana protein',
    description: 'Banana, oats & whey boost',
    price: 23.50,
    imagePath: 'https://images.unsplash.com/photo-1625093578263-d18d7d27c6b4?w=800&h=1200&fit=crop',
    ingredients: ['Banana', 'Oats', 'Whey', 'Milk'],
    category: 'energy',
  ),
  Smoothie(
    id: '7',
    name: 'Peanut butter',
    description: 'Creamy peanut delight',
    price: 24.00,
    imagePath: 'https://images.unsplash.com/photo-1600891964099-3447d836315f?w=800&h=1200&fit=crop',
    ingredients: ['Peanut butter', 'Banana', 'Milk', 'Honey'],
    category: 'protein',
  ),
  Smoothie(
    id: '8',
    name: 'Avocado glow',
    description: 'Smooth avocado blend',
    price: 25.00,
    imagePath: 'https://images.unsplash.com/photo-1587734195503-8ec5e099f3a5?w=800&h=1200&fit=crop',
    ingredients: ['Avocado', 'Spinach', 'Lime', 'Yogurt'],
    category: 'healthy',
  ),
  Smoothie(
    id: '9',
    name: 'Orange sunrise',
    description: 'Citrus morning refresh',
    price: 19.50,
    imagePath: 'https://images.unsplash.com/photo-1572451472828-068475c8d886?w=800&h=1200&fit=crop',
    ingredients: ['Orange', 'Carrot', 'Ginger', 'Ice'],
    category: 'fresh',
  ),
  Smoothie(
    id: '10',
    name: 'Dragonfruit burst',
    description: 'Exotic pitaya fusion',
    price: 26.00,
    imagePath: 'https://images.unsplash.com/photo-1603297624149-78c1907b3d47?w=800&h=1200&fit=crop',
    ingredients: ['Dragonfruit', 'Strawberry', 'Coconut water', 'Mint'],
    category: 'featured',
  ),
];
