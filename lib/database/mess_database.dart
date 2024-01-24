import 'package:admin/main.dart';
import 'package:admin/models/mess_menu_model.dart';
import 'package:flutter/material.dart';

class MessDatabase extends ChangeNotifier{

  Future<Meal> getMeals({int day=1, int? mess=1}) async{
    late Meal mealData;
    dynamic data = await supabase.from('mess').select().eq('mess_no', 2).eq('day', DateTime.now().weekday).single();

    mealData = Meal(
      messNo: data['mess_no'],
      day: data['day'],
      breakfast: data['breakfast'],
      lunch: data['lunch'],
      dinner: data['dinner']  
    );
    return mealData;
  }

  Future<List<MealsListData>> getMessData() async{
    List<MealsListData> allMeals=[];
    final Meal data = await getMeals(day: 1, mess: 1);

    allMeals.addAll([
      MealsListData(
        imagePath: 'assets/fitness_app/breakfast.png',
        titleTxt: 'Breakfast',
        kacl: 525,
        meals: <String>[...data.breakfast.toString().split(', ')],
        startColor: '#FA7D82',
        endColor: '#FFB295',
      ),
      MealsListData(
        imagePath: 'assets/fitness_app/lunch.png',
        titleTxt: 'Lunch',
        kacl: 602,
        meals: <String>[...data.lunch.toString().split(', ')],
        startColor: '#738AE6',
        endColor: '#5C5EDD',
      ),
      MealsListData(
        imagePath: 'assets/fitness_app/dinner.png',
        titleTxt: 'Dinner',
        kacl: 602,
        meals: <String>[...data.dinner.toString().split(', ')],
        startColor: '#6F72CA',
        endColor: '#1E1466',
      ),
    ]);
  
    return allMeals;
  }

  static List<MealsListData> tabIconsList = <MealsListData>[
    MealsListData(
      imagePath: 'assets/fitness_app/breakfast.png',
      titleTxt: 'Breakfast',
      kacl: 525,
      meals: <String>['Bread,', 'Peanut butter,', 'Apple'],
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
    MealsListData(
      imagePath: 'assets/fitness_app/lunch.png',
      titleTxt: 'Lunch',
      kacl: 602,
      meals: <String>['Salmon,', 'Mixed veggies,', 'Avocado'],
      startColor: '#738AE6',
      endColor: '#5C5EDD',
    ),
    // MealsListData(
    //   imagePath: 'assets/fitness_app/snack.png',
    //   titleTxt: 'Snack',
    //   kacl: 0,
    //   meals: <String>['Recommend:', '800 kcal'],
    //   startColor: '#FE95B6',
    //   endColor: '#FF5287',
    // ),
    MealsListData(
      imagePath: 'assets/fitness_app/dinner.png',
      titleTxt: 'Dinner',
      kacl: 602,
      meals: <String>['Recommend:', '703 kcal'],
      startColor: '#6F72CA',
      endColor: '#1E1466',
    ),
    // MealsListData(
    //   imagePath: 'assets/fitness_app/dinner.png',
    //   titleTxt: 'Dinner',
    //   kacl: 0,
    //   meals: <String>['Recommend:', '703 kcal'],
    //   startColor: '#6F72CA',
    //   endColor: '#1E1466',
    // ),
  ];
}