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
];
