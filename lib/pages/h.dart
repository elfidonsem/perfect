import 'package:flutter/material.dart';
import 'package:perfect/models/app_user.dart';
import 'package:perfect/services/auth_service.dart';
import 'package:perfect/services/user_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // ignore: non_constant_identifier_names
  final auth_user = AuthService().auth;
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Perfect'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              setState(() async {
                await AuthService().logout();
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: UserService().getAllUsers,
          builder: (context, snapshot) {
            return ListView.builder(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                if (snapshot.hasData && snapshot.data != null) {
                  final currentIndex = snapshot.data![index];
                  return Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      // leading: CircleAvatar(
                      //   backgroundImage: NetworkImage(
                      //     auth_user.currentUser!.photoURL!,
                      //   ),
                      // ),
                      title: Text(currentIndex.name),
                      subtitle: Text(currentIndex.email),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () async {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text("Mettre a jour"),
                                    content: Column(
                                      children: [
                                        TextField(
                                          controller: nameController,
                                          decoration: const InputDecoration(
                                            labelText: 'Nom',
                                          ),
                                        ),
                                      ],
                                    ),

                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          setState(() async {
                                            final appUser = AppUser(
                                              name: nameController.text.trim(),
                                              uid: auth_user.currentUser!.uid,
                                              email:
                                                  auth_user.currentUser!.email!,
                                              age: "45",
                                            );
                                            await UserService().updateUser(
                                              appUser,
                                            );
                                          });
                                        },
                                        child: Text("Mettre a jour"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            icon: Icon(Icons.edit),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() async {
                                await UserService().deleteUser(
                                  auth_user.currentUser!.uid,
                                );
                              });
                            },
                            icon: Icon(Icons.delete),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                if (snapshot.data!.isEmpty) {
                  return Center(child: Text("Aucunne donnée"));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                return Center(child: Text("Une erreur "));
              },
            );
          },
        ),
      ),
    );
  }
}
