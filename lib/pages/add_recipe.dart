import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letseat/models/category_model.dart';
import 'package:letseat/providers/recipe_provider.dart';
import 'package:letseat/theme/theme_constants.dart';
import 'package:provider/provider.dart';

import '../models/recipe_model_2.dart';

class AddRecipePage extends StatefulWidget {
  AddRecipePage({super.key, required this.category});

  final CategoryModel category;

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();

  final ingController = TextEditingController();

  File? imageFile;
  String? imageError;

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          backgroundColor: COLOR_PRIMARY,
          title: Center(
            child: Text('ADD RECIPE',
                style: TextStyle(fontSize: 30, color: Colors.white)),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              if (imageFile != null)
                Image.file(
                  imageFile!,
                  height: 100,
                  width: 100,
                )
              else
                Container(
                  child: Icon(Icons.image),
                  width: 100,
                  height: 100,
                ),
              ElevatedButton(
                  onPressed: () async {
                    //////////////need to install image picker package before activating the code below

                    var file = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    if (file == null) {
                      return;
                    }

                    setState(() {
                      imageFile = File(file.path);
                      imageError = null;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: COLOR_PRIMARY,
                  ),
                  child: Text("Upload Image")),
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(hintText: "Title"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required field";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: descriptionController,
                decoration: InputDecoration(hintText: "description"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required field";
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: ingController,
                decoration: InputDecoration(hintText: "ingredients"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Required field";
                  }

                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (imageFile == null) {
                      setState(() {
                        imageError = "Image is required";
                      });
                    }

                    if (formKey.currentState!.validate() && imageFile != null) {
                      await context.read<RecipeProvider>().addRecipe(
                            title: titleController.text,
                            body: descriptionController.text,
                            image: imageFile!,
                            category: widget.category.id,
                            ingredients: int.parse("1"),
                            user: int.parse("1"),
                            inputingredients: ingController.text,
                          );
                    }
                    Navigator.popUntil(
                      context,
                      ModalRoute.withName('/'),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: COLOR_PRIMARY,
                  ),
                  child: Text(
                    "ADD RECIPE",
                    style: TextStyle(fontSize: 30, color: Colors.white),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
