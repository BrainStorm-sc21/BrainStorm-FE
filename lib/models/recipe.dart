class Recipe {
  List<String> recipeFoods;

  Recipe({
    required this.recipeFoods,
  });

  // class to json
  Map<String, List<String>> toJson() {
    final Map<String, List<String>> data = <String, List<String>>{};
    data['foodList'] = recipeFoods;
    return data;
  }

  // class from json
  factory Recipe.fromJson(Map<List<String>, dynamic> json) {
    return Recipe(
      recipeFoods: json['foodList'],
    );
  }
}
