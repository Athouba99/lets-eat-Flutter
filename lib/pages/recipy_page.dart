import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'package:letseat/models/recipies_model.dart';
import 'package:letseat/providers/recipes_provider.dart';

import '../providers/category_provider.dart';

class RecipyPage extends StatelessWidget {
  final RecipesModel recipy;
  const RecipyPage({
    Key? key,
    required this.recipy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          // automaticallyImplyLeading: false,
          // leading: Builder(
          //   builder: (BuildContext context) {
          //     return IconButton(
          //       icon: const Icon(Icons.menu),
          //       onPressed: () {
          //         Scaffold.of(context).openDrawer();
          //       },
          //       tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
          //     );
          //   },
          // ),
          actions: [
            ElevatedButton(
              onPressed: () {
                context.push('/signup');
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(121, 255, 153, 0),
                padding: EdgeInsets.symmetric(horizontal: 0.5, vertical: 0.5),
                textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text("Signup"),
            ),
            SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {
                context.push('/signin');
              },
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(121, 255, 153, 0),
                padding: EdgeInsets.symmetric(horizontal: 0.5, vertical: 0.5),
                textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
              child: Text("Signin"),
            ),
          ],
          title: Center(
            child: Text(
              'LETS EAT',
              style:
                  TextStyle(fontSize: 30, color: Color.fromARGB(255, 1, 5, 23)),
            ),
          ),
        ),
      ),
      body: Column(children: [
        Card(
          color: Color.fromARGB(255, 225, 232, 141),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              "Recipes",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: context.watch<AmericanFoodProvider>().categories.length,
            itemBuilder: (context, index) => Card(
              color: Color.fromARGB(255, 225, 232, 141),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                            radius: 50,
                            foregroundImage: AssetImage(
                              context
                                  .watch<AmericanFoodProvider>()
                                  .categories[index]
                                  .image,
                            )),
                        Spacer(),
                        Text(
                          context
                              .watch<AmericanFoodProvider>()
                              .categories[index]
                              .text,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
