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

  final List<Map<String, String>> recipes = [
    {'title': 'Grilled Vegetables', 'image': 'assets/grilled_vegetables.jpg'},
    {'title': 'Vegan Pasta', 'image': 'assets/vegan_pasta.jpg'},
    {'title': 'Gluten-Free Pancakes', 'image': 'assets/gluten_free_pancakes.jpg'},
  ];

  RecipeListPage({required this.category});

  @override
  Widget build(BuildContext context) {
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

// ---------------- Meal Planner Page ----------------
class MealPlannerPage extends StatefulWidget {
  @override
  _MealPlannerPageState createState() => _MealPlannerPageState();
}

class MealPlannerPageState extends State<MealPlannerPage> {
  final Map<String, String> mealPlan = {};
  final List<String> meals = ['Grilled Vegetables', 'Vegan Pasta', 'Gluten-Free Pancakes'];

  @override
  Widget build(BuildContext context) {
    final days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return Scaffold(
      appBar: AppBar(title: Text("Meal Planner")),
      body: ListView.builder(
        itemCount: days.length,
        itemBuilder: (, index) {
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