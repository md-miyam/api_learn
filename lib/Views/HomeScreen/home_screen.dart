import 'package:flutter/material.dart';
import 'package:new_api/ApiServices/api_services.dart';
import 'package:new_api/model/post_model.dart';
import '../PostDetailsScreen/post_details_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("API"),
        centerTitle: true,
      ),
      body: FutureBuilder<List<PostModel>?>(
        future: ApiServices.fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No data found"));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final data = snapshot.data![index];
                return InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailsScreen( postId: data.id.toString(),),));
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    elevation: 3,
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(data.image),
                      ),
                      title: Text("${data.firstName} ${data.maidenName} ${data.lastName}"),
                      // subtitle: Text("Size: ${data.height}x${data.height}"),
                      trailing: Text("ID: ${data.id}"),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
