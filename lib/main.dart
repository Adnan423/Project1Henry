import 'package:flutter/material.dart';

class FavoriteManager {
  static final FavoriteManager _instance = FavoriteManager._internal();
  factory FavoriteManager() => _instance;
  FavoriteManager._internal();

  final List<Map<String, dynamic>> _favorites = [];

  List<Map<String, dynamic>> get favorites => _favorites;

  void addFavorite(Map<String, dynamic> recipe) {
    if (!_favorites.any((r) => r['title'] == recipe['title'])) {
      _favorites.add(recipe);
    }
  }

  void removeFavorite(String title) {
    _favorites.removeWhere((r) => r['title'] == title);
  }

  bool isFavorite(String title) {
    return _favorites.any((r) => r['title'] == title);
  }
}

void main() {
  runApp(RecipeApp());
}

class RecipeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Recipe & Meal Planner',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFFDF6F0),
        primarySwatch: Colors.deepOrange,
        primaryColor: Colors.deepOrange,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepOrange,
          titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          iconTheme: IconThemeData(color: Colors.white),
          elevation: 4,
        ),
        cardTheme: CardTheme(
          color: Colors.white,
          elevation: 4,
          shadowColor: Colors.orange.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16, color: Colors.black87),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.deepOrange),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepOrange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

// ---------------- Home Screen ----------------
class HomeScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'title': 'Vegetarian', 'image': 'assets/vegetarian.jpg'},
    {'title': 'Vegan', 'image': 'assets/vegan.jpg'},
    {'title': 'Gluten-Free', 'image': 'assets/gluten_free.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe & Meal Planner')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: categories.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => RecipeListPage(category: category['title']!),
                  ),
                );
              },
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        category['image']!,
                        height: 80,
                        width: 80,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported, size: 50),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(category['title']!, style: Theme.of(context).textTheme.titleLarge),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        currentIndex: 0, // Optional if you want highlighting
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today), label: "Planner"),
        ],
        onTap: (index) {
          if (index == 1) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => FavoritesPage()));
          } else if (index == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => MealPlannerPage()));
          }
        },
      ),
    );
  }
}

// ---------------- Recipe List Page ----------------
class RecipeListPage extends StatelessWidget {
  final String category;

  final Map<String, List<Map<String, dynamic>>> categorizedRecipes = {
    'Vegetarian': [
      {
        'title': 'Grilled Vegetables',
        'image': 'assets/grilled_vegetables.jpg',
        'ingredients': ['Zucchini', 'Bell Peppers', 'Olive Oil'],
        'steps': ['Slice veggies', 'Brush with oil', 'Grill for 10 mins'],
      },
      {
        'title': 'Stuffed Bell Peppers',
        'image': 'assets/stuffed_peppers.jpg',
        'ingredients': ['Bell Peppers', 'Rice', 'Tomato Sauce'],
        'steps': ['Cut peppers', 'Stuff with rice', 'Bake 25 mins'],
      },
      {
        'title': 'Caprese Salad',
        'image': 'assets/caprese_salad.jpg',
        'ingredients': ['Tomatoes', 'Mozzarella', 'Basil'],
        'steps': ['Slice ingredients', 'Layer them', 'Drizzle balsamic'],
      },
    ],
    'Vegan': [
      {
        'title': 'Vegan Pasta',
        'image': 'assets/vegan_pasta.jpg',
        'ingredients': ['Pasta', 'Tomatoes', 'Garlic'],
        'steps': ['Cook pasta', 'Make tomato sauce', 'Combine & serve'],
      },
      {
        'title': 'Tofu Stir Fry',
        'image': 'assets/tofu_stirfry.jpg',
        'ingredients': ['Tofu', 'Soy Sauce', 'Mixed Veggies'],
        'steps': ['Fry tofu', 'Add veggies', 'Stir in soy sauce'],
      },
      {
        'title': 'Lentil Soup',
        'image': 'assets/lentil_soup.jpg',
        'ingredients': ['Lentils', 'Carrots', 'Onions'],
        'steps': ['Sauté veggies', 'Add lentils & broth', 'Simmer 30 mins'],
      },
    ],
    'Gluten-Free': [
      {
        'title': 'Gluten-Free Pancakes',
        'image': 'assets/gluten_free_pancakes.jpg',
        'ingredients': ['GF Flour', 'Milk', 'Egg'],
        'steps': ['Mix ingredients', 'Pour batter', 'Flip when bubbly'],
      },
      {
        'title': 'Quinoa Salad',
        'image': 'assets/quinoa_salad.jpg',
        'ingredients': ['Quinoa', 'Cucumber', 'Lemon Juice'],
        'steps': ['Cook quinoa', 'Chop veggies', 'Mix & chill'],
      },
      {
        'title': 'Zucchini Noodles',
        'image': 'assets/zucchini_noodles.jpg',
        'ingredients': ['Zucchini', 'Garlic', 'Olive Oil'],
        'steps': ['Spiral zucchini', 'Sauté garlic', 'Add zucchini & toss'],
      },
    ],
  };

  RecipeListPage({required this.category});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> recipes = categorizedRecipes[category] ?? [];

    return Scaffold(
      appBar: AppBar(title: Text('$category Recipes')),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (_, index) {
          final recipe = recipes[index];
          return ListTile(
            leading: Image.asset(
              recipe['image']!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported),
            ),
            title: Text(recipe['title']!),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => RecipeDetailPage(recipe: recipe)),
            ),
          );
        },
      ),
    );
  }
}

// ---------------- Recipe Detail Page ----------------
class RecipeDetailPage extends StatelessWidget {
final Map<String, dynamic> recipe;

RecipeDetailPage({required this.recipe});

@override
Widget build(BuildContext context) {
  final List<String> ingredients = List<String>.from(recipe['ingredients'] ?? []);
  final List<String> steps = List<String>.from(recipe['steps'] ?? []);

  return Scaffold(
    appBar: AppBar(title: Text(recipe['title']!)),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: ListView(
        children: [
          Image.asset(
            recipe['image']!,
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported, size: 100),
          ),
          SizedBox(height: 16),
          Text(recipe['title']!, style: Theme.of(context).textTheme.titleLarge),
          SizedBox(height: 12),
          Text("Ingredients:", style: TextStyle(fontWeight: FontWeight.bold)),
          ...ingredients.map((item) => Text('- $item')).toList(),
          SizedBox(height: 12),
          Text("Steps:", style: TextStyle(fontWeight: FontWeight.bold)),
          ...steps.asMap().entries.map((e) => Text('${e.key + 1}. ${e.value}')).toList(),
          SizedBox(height: 20),
          Row(
            children: [
              ElevatedButton.icon(
                icon: Icon(Icons.favorite),
                label: Text("Favorite"),
                onPressed: () {
                  FavoriteManager().addFavorite(recipe);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${recipe['title']} added to favorites')),
                  );
                },
              ),
              SizedBox(width: 12),
              ElevatedButton.icon(
                icon: Icon(Icons.calendar_today),
                label: Text("Add to Plan"),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => MealPlannerPage()));
                },
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
}


// ---------------- Favorites Page ----------------
class FavoritesPage extends StatefulWidget {
  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  @override
  Widget build(BuildContext context) {
    final favorites = FavoriteManager().favorites;

    return Scaffold(
      appBar: AppBar(title: Text("Favorite Recipes")),
      body: favorites.isEmpty
          ? Center(child: Text("No favorite recipes yet!"))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (_, index) {
          final recipe = favorites[index];
          return ListTile(
            leading: Image.asset(
              recipe['image']!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported),
            ),
            title: Text(recipe['title']!),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                setState(() {
                  FavoriteManager().removeFavorite(recipe['title']!);
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => RecipeDetailPage(recipe: recipe),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

// ---------------- Meal Planner Page ----------------
class MealPlannerPage extends StatefulWidget {
  @override
  _MealPlannerPageState createState() => _MealPlannerPageState();
}

class _MealPlannerPageState extends State<MealPlannerPage> {
  final Map<String, String> mealPlan = {};
  final List<String> meals = [
    'Grilled Vegetables',
    'Stuffed Bell Peppers',
    'Caprese Salad',
    'Vegan Pasta',
    'Tofu Stir Fry',
    'Lentil Soup',
    'Gluten-Free Pancakes',
    'Quinoa Salad',
    'Zucchini Noodles',
  ];

  @override
  Widget build(BuildContext context) {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return Scaffold(
      appBar: AppBar(title: Text("Meal Planner")),
      body: ListView.builder(
        itemCount: days.length,
        itemBuilder: (_, index) {
          final day = days[index];
          return ListTile(
            title: Text(day),
            subtitle: Text(mealPlan[day] ?? "No meal selected"),
            trailing: DropdownButton<String>(
              hint: Text("Select"),
              value: mealPlan[day],
              items: meals.map((meal) {
                return DropdownMenuItem(value: meal, child: Text(meal));
              }).toList(),
              onChanged: (value) {
                setState(() {
                  mealPlan[day] = value!;
                });
              },
            ),
          );
        },
      ),
    );
  }
}