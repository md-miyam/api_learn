import 'package:flutter/material.dart';
import 'package:new_api/ApiServices/api_services.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

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
        child: Column(
          children: [
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: TextFormField(
                controller: bodyController,
                decoration: InputDecoration(
                  hintText: "Body",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            TextFormField(
              controller: userIdController,
              decoration: InputDecoration(
                hintText: "User id",
                border: OutlineInputBorder(),
              ),
            ),

            // button
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ApiServices.postData(
                      titleController.text,
                      bodyController.text,
                      userIdController.text,
                    );
                    controllerClean();
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Text("Create"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
