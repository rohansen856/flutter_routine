class Meal {
  int? messNo;
  int? day;
  String? breakfast;
  String? lunch;
  String? dinner;
  dynamic timing;

  Meal({
    this.messNo,
    this.day,
    this.breakfast,
    this.lunch,
    this.dinner,
    this.timing,
  });
}

class MealsListData {
  MealsListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.meals,
    this.timing,
  });

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  List<String>? meals;
  String? timing;

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/breakfast.png',
      titleTxt: 'Breakfast',
      timing: "",
      meals: <String>['Bread,', 'Peanut butter,', 'Apple'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/lunch.png',
      titleTxt: 'Lunch',
      timing: "",
      meals: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    // MealsListData(
    //   imagePath: 'assets/fitness_app/snack.png',
    //   titleTxt: 'Snack',
    //   timing: ""    //   meals: <String>['Recommend:', '800 kcal'],
    //   startColor: '#FE95B6',
    //   endColor: '#FF5287',
    // ),
    MealsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      titleTxt: 'Dinner',
      timing: "",
      meals: <String>['Recommend:', '703 kcal'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
    // MealsListData(
    //   imagePath: 'assets/fitness_app/dinner.png',
    //   titleTxt: 'Dinner',
    //   timing: ""    //   meals: <String>['Recommend:', '703 kcal'],
    //   startColor: '#6F72CA',
    //   endColor: '#1E1466',
    // ),
  ];
}
