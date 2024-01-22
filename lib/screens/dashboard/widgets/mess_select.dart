import 'package:admin/theme/theme_data.dart';
import 'package:flutter/material.dart';

List<int> list = [1, 2];

class MessSelectButton extends StatefulWidget {
  @override
  _MessSelectButtonState createState() => _MessSelectButtonState();
}

class _MessSelectButtonState extends State<MessSelectButton> {
  int selectedValue = list.first;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Mess menu",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: AppTheme.secondaryColor,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: DropdownButton<int>(
              value: selectedValue,
              icon: Icon(Icons.arrow_drop_down),
              iconSize: 24,
              elevation: 16,
              style: Theme.of(context).textTheme.labelMedium,
              underline: Container(
                height: 0,
                color: Colors.blue,
              ),
              onChanged: (int? newValue) {
                setState(() {
                  selectedValue = newValue!;
                });
              },
              items: list
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text("Mess $value"),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
