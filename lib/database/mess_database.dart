import 'package:admin/main.dart';
import 'package:admin/models/mess_menu_model.dart';
import 'package:flutter/material.dart';

class MessDatabase extends ChangeNotifier{

  void setMess(int mess){
    int messNo = mess;
    notifyListeners();
  }

  Future<Meal> getMeals(int day, int mess) async{
    late Meal mealData;
    dynamic data = await supabase.from('mess').select().eq('mess_no', mess).eq('day', DateTime.now().weekday).single();

    mealData = Meal(
      messNo: data['mess_no'],
      day: data['day'],
      breakfast: data['breakfast'],
      lunch: data['lunch'],
      dinner: data['dinner'],
      timing: data['timings']
    );
    return mealData;
  }

  Future<List<MealsListData>> getMessData(int day, int messNo) async{
    List<MealsListData> allMeals=[];
    final Meal data = await getMeals(day, messNo);

    allMeals.addAll([
      MealsListData(
        imagePath: 'assets/fitness_app/breakfast.png',
        titleTxt: 'Breakfast',
        timing: data.timing["breakfast"].toString()+" am",
        meals: <String>[...data.breakfast.toString().split(', ')],
        startColor: '#FA7D82',
        endColor: '#FFB295',
      ),
      MealsListData(
        imagePath: 'assets/fitness_app/lunch.png',
        titleTxt: 'Lunch',
        timing: data.timing["lunch"].toString()+" pm",
        meals: <String>[...data.lunch.toString().split(', ')],
        startColor: '#738AE6',
        endColor: '#5C5EDD',
      ),
      MealsListData(
        imagePath: 'assets/fitness_app/dinner.png',
        titleTxt: 'Dinner',
        timing: data.timing["dinner"].toString()+" pm",
        meals: <String>[...data.dinner.toString().split(', ')],
        startColor: '#6F72CA',
        endColor: '#1E1466',
      ),
    ]);
  print(allMeals);
    return allMeals;
  }

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
    //   timing: data.timing["breakfast"].toString()    //   meals: <String>['Recommend:', '800 kcal'],
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
    //   timing: data.timing["breakfast"].toString()    //   meals: <String>['Recommend:', '703 kcal'],
    //   startColor: '#6F72CA',
    //   endColor: '#1E1466',
    // ),
  ];
}