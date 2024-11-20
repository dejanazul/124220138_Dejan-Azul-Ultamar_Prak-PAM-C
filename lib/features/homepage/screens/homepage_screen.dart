import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:hive/hive.dart';
import 'package:responsi_124220138_prak_mobile/features/homepage/controllers/homepage_controller.dart';
import 'package:responsi_124220138_prak_mobile/features/homepage/models/homepage_model.dart';
import 'package:responsi_124220138_prak_mobile/repo/api_detail.dart';
import 'package:responsi_124220138_prak_mobile/repo/api_service.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final HomepageController homepageController = Get.find();
    var sessionBox = Hive.box('session');
    String? loggedInUser = sessionBox.get('loggedInUser');
    final ApiService apiService = ApiService();
    final imageUrl = 'https://restaurant-api.dicoding.dev/images/small/';

    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Hai, $loggedInUser!')),
        ),
        body: FutureBuilder<List<HomepageModel>>(
          future: apiService.fetchListHomepage('list', HomepageModel.fromJson),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text("Error: ${snapshot.error}"));
            } else if (!snapshot.hasData) {
              return const Center(child: Text("No News Available!"));
            } else {
              final listes = snapshot.data!;
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: listes.length,
                      itemBuilder: (context, index) {
                        final list = listes[index];
                        return InkWell(
                          onTap: () {
                            Get.to(() => ApiDetail(id: list.id));
                          },
                          child: SizedBox(
                            height: 350,
                            child: Card(
                              margin: const EdgeInsets.all(8.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  side: const BorderSide(color: Colors.black)),
                              child: Container(
                                width: 300,
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        '$imageUrl/${list.pictureId}',
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null) {
                                            return child;
                                          }
                                          return SizedBox(
                                            height: 200,
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()),
                                          );
                                        },
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          return Container(
                                            height: 200,
                                            width: 300,
                                            color: Colors.grey[300],
                                            child: const Center(
                                              child: Icon(
                                                Icons.broken_image,
                                                size: 50,
                                                color: Colors.grey,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text(
                                      list.name,
                                      textAlign: TextAlign.center,
                                    ),
                                    Align(
                                        alignment: Alignment.centerRight,
                                        child: Icon(Icons.arrow_forward)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  //logout
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: FilledButton(
                          onPressed: () {
                            homepageController.logout();
                          },
                          child: const Text("Logout")),
                    ),
                  )
                ],
              );
            }
          },
        ));
  }
}
