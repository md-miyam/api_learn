import 'package:flutter/material.dart';
import 'package:new_api/ApiServices/api_services.dart';

class PostDetailsScreen extends StatelessWidget {
  final String postId;

  const PostDetailsScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios_new)),
        title: Text("ID : $postId"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: ApiServices.fetchSinglePost(postId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No data found'));
            } else {
              final data = snapshot.data!;
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${data.firstName} ${data.maidenName} ${data.lastName}"),
                    Text("Age : ${data.age.toString()}"),
                    Text("Gender : ${data.gender}"),
                    Text("Email : ${data.email}"),
                    Text("Phone : ${data.phone.toString()}"),
                    Text("Username : ${data.username}"),
                    Text("Password : ${data.password}"),
                    Text("BirthDate : ${data.birthDate}"),
                    Text("BloodGroup : ${data.bloodGroup}"),
                    Text("Height : ${data.height.toString()}"),
                    Text("Weight : ${data.weight.toString()}"),
                    Text("EyeColor : ${data.eyeColor}"),
                    Image.network(data.image),
                  ],
                ),
              );
            }
          }),
    );
  }
}