import 'package:material_ui/material_ui.dart';
import 'recipe_functions.dart';

class PavlovaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/pavlova.jpg',
                width: double.infinity,
                height: 600,
                fit: BoxFit.cover,
              ),

              Container(
                color: Color(0xFFFFF7FF),
                padding: EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RecipeFunctions.title(),
                    SizedBox(height: 8),
                    RecipeFunctions.description(),
                    SizedBox(height: 12),
                    RecipeFunctions.rating(),
                    SizedBox(height: 20),
                    RecipeFunctions.recipeInfo(),
                    SizedBox(height: 12),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
