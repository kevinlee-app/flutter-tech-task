class RecipeModel {
  final String title;
  final List ingredients;

  RecipeModel(this.title, this.ingredients);

  RecipeModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        ingredients = json['ingredients'];
}