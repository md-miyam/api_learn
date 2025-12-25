import 'package:flutter/material.dart';
import 'package:new_api/ApiServices/api_services.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

final fromKey = GlobalKey<FormState>();

TextEditingController titleController = TextEditingController();
TextEditingController bodyController = TextEditingController();
TextEditingController userIdController = TextEditingController();

void controllerClean() {
  titleController.clear();
  bodyController.clear();
  userIdController.clear();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create a post"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: fromKey,
          child: Column(
            children: [
              TextFormField(
                controller: titleController,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v!.isEmpty) {
                    return "Title required";
                  } else {
                    return null;
                  }
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: TextFormField(
                  controller: bodyController,
                  decoration: InputDecoration(
                    hintText: "Body",
                    border: OutlineInputBorder(),
                  ),
                  validator: (v) {
                    if (v!.isEmpty) {
                      return "Body required";
                    } else {
                      return null;
                    }
                  },
                ),
              ),
              TextFormField(
                controller: userIdController,
                decoration: InputDecoration(
                  hintText: "User id",
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v!.isEmpty) {
                    return "User id required";
                  } else {
                    return null;
                  }
                },
              ),

              // button
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (fromKey.currentState!.validate()) {
                        ApiServices.postData(
                          titleController.text,
                          bodyController.text,
                          userIdController.text,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "Post created successfully! ${ApiServices.postData}",
                            ),
                            duration: Duration(
                              seconds: 3,
                            ), // how long it stays visible
                          ),
                        );
                        controllerClean();
                        Navigator.pop(context);
                      } else {
                        return;
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text("Create"),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
