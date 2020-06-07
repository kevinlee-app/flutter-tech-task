class IngredientModel {
  final String title;
  final String useBy;
  bool isSelected = false;
  bool isExpired = false;

  IngredientModel(this.title, this.useBy);

  IngredientModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        useBy = json['use-by'];
}
