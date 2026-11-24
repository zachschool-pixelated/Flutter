import 'package:material_ui/material_ui.dart';

class RecipeFunctions {
  static Widget title() {
    return Text(
      'Strawberry Pavlova',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  static Widget description() {
    return Text(
      'Pavlova is a meringue-based dessert named after the '
      'Russian ballerina Anna Pavlova. Pavlova features a crisp '
      'crust and soft, light inside, topped with fruit and whipped cream.',
      style: TextStyle(fontSize: 12, height: 1.4),
    );
  }

  static Widget rating() {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '★★★★☆',
            style: TextStyle(color: Colors.yellow, fontSize: 20),
          ),
          SizedBox(width: 8),
          Text(
            '90 Reviews',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  static Widget info(
    IconData icon,
    String label,
    String value,
  ) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Colors.amber),
          SizedBox(height: 6),
          Text(label,
              style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 4),
          Text(value),
        ],
      ),
    );
  }

  static Widget recipeInfo() {
    return Row(
      children: [
        info(Icons.timer_outlined, 'PREP', '25 min'),
        info(Icons.restaurant, 'COOK', '1 gr'),
        info(Icons.people_outline, 'FEEDS', '4-6 hrs'),
      ],
    );
  }
}
