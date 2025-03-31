import 'package:flutter/material.dart';

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
        primarySwatch: Colors.orange,
        textTheme: TextTheme(
          bodyMedium: TextStyle(fontSize: 16),
          titleLarge: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    Image.asset(
                      category['image']!,
                      height: 80,
                      width: 80,
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => Icon(Icons.image_not_supported, size: 50),
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

  final Map<String, List<Map<String, String>>> categorizedRecipes = {
    'Vegetarian': [
      {'title': 'Grilled Vegetables', 'image': 'assets/grilled_vegetables.jpg'},
      {'title': 'Stuffed Bell Peppers', 'image': 'assets/stuffed_peppers.jpg'},
      {'title': 'Caprese Salad', 'image': 'assets/caprese_salad.jpg'},
    ],
    'Vegan': [
      {'title': 'Vegan Pasta', 'image': 'assets/vegan_pasta.jpg'},
      {'title': 'Tofu Stir Fry', 'image': 'assets/tofu_stirfry.jpg'},
      {'title': 'Lentil Soup', 'image': 'assets/lentil_soup.jpg'},
    ],
    'Gluten-Free': [
      {'title': 'Gluten-Free Pancakes', 'image': 'assets/gluten_free_pancakes.jpg'},
      {'title': 'Quinoa Salad', 'image': 'assets/quinoa_salad.jpg'},
      {'title': 'Zucchini Noodles', 'image': 'assets/zucchini_noodles.jpg'},
    ],
  };

  RecipeListPage({required this.category});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> recipes = categorizedRecipes[category] ?? [];

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
  final Map<String, String> recipe;

  RecipeDetailPage({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(recipe['title']!)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
            Text("Ingredients:\n- Ingredient 1\n- Ingredient 2\n- Ingredient 3"),
            SizedBox(height: 12),
            Text("Steps:\n1. Step one\n2. Step two\n3. Step three"),
            SizedBox(height: 20),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: Icon(Icons.favorite_border),
                  label: Text("Favorite"),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Added to favorites')));
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
            )
          ],
        ),
      ),
    );
  }
}

// ---------------- Favorites Page ----------------
class FavoritesPage extends StatelessWidget {
  final List<String> favorites = ['Vegan Pasta', 'Grilled Vegetables'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Favorite Recipes")),
      body: favorites.isEmpty
          ? Center(child: Text("No favorite recipes yet!"))
          : ListView.builder(
        itemCount: favorites.length,
        itemBuilder: (_, index) {
          return ListTile(
            title: Text(favorites[index]),
            trailing: Icon(Icons.favorite, color: Colors.red),
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