import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:letseat/providers/category_provider.dart';
import 'package:letseat/theme/theme_constants.dart';
import 'package:provider/provider.dart';

class AddCategoryPage extends StatefulWidget {
  AddCategoryPage({super.key});

  @override
  State<AddCategoryPage> createState() => _AddCategoryPageState();
}

class _AddCategoryPageState extends State<AddCategoryPage> {
  final titleController = TextEditingController();

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
            child: Text(
              'ADD CATEGORY',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
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
              ElevatedButton(
                onPressed: () async {
                  if (imageFile == null) {
                    setState(() {
                      imageError = "Image is required";
                    });
                  }

                  if (formKey.currentState!.validate() && imageFile != null) {
                    await context.read<CategoryProvider>().addCategory(
                        text: titleController.text, image: imageFile!);
                    context.pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: COLOR_PRIMARY,
                ),
                child: Text(
                  'ADD CATEGORY',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
