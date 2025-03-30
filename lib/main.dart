// ---------------- Recipe List Page ----------------
class RecipeListPage extends StatelessWidget {
  final String category;

  final List<Map<String, String>> recipes = [
    {'title': 'Grilled Vegetables', 'image': 'assets/grilled_vegetables.jpg'},
    {'title': 'Vegan Pasta', 'image': 'assets/vegan_pasta.jpg'},
    {'title': 'Gluten-Free Pancakes', 'image': 'assets/gluten_freepancakes.jpg'},
  ];

  RecipeListPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('$category Recipes')),
      body: ListView.builder(
        itemCount: recipes.length,
        itemBuilder: (, index) {
          final recipe = recipes[index];
          return ListTile(
            leading: Image.asset(
              recipe['image']!,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              errorBuilder: (, , ) => Icon(Icons.image_notsupported),
            ),
            title: Text(recipe['title']!),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: () => RecipeDetailPage(recipe: recipe)),
            ),
          );
        },
      ),
    );
  }
}