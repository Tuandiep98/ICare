class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.kacl = 0,
    this.carb = 0,
    this.protein = 0,
    this.fat = 0,
    this.id,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String> meals;
  int kacl,id,carb,protein,fat;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/breakfast.png',
      titleTxt: 'Bữa sáng',
      kacl: 0,
      carb: 0,
      protein: 0,
      fat: 0,
      meals: <String>[],
      startColor: '#85F54E',
      endColor: '#7EA6F8',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/lunch.png',
      titleTxt: 'Bữa trưa',
      kacl: 0,
      carb: 0,
      protein: 0,
      fat: 0,
      meals: <String>[],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/snack.png',
      titleTxt: 'Ăn vặt',
      kacl: 0,
      carb: 0,
      protein: 0,
      fat: 0,
      meals: <String>[],
      startColor: '#FE95B6',
      endColor: '#FF5287',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      titleTxt: 'Bữa tối',
      kacl: 0,
      carb: 0,
      protein: 0,
      fat: 0,
      meals: <String>[],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
  ];
}
