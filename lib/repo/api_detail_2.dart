import 'package:flutter/material.dart';
import 'package:responsi_124220138_prak_mobile/features/homepage/models/homepage_model.dart';
import 'package:responsi_124220138_prak_mobile/repo/api_service.dart';

class ApiDetail2<T> extends StatelessWidget {
  final String menu;
  final String id;
  final T Function(Map<String, dynamic>) fromJson;

  const ApiDetail2(
      {super.key,
      required this.menu,
      required this.id,
      required this.fromJson});

  @override
  Widget build(BuildContext context) {
    final imageUrl = 'https://restaurant-api.dicoding.dev/images/small/14';

    final ApiService apiService = ApiService();
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder<T>(
        future: apiService.fetchDetail(menu, id, fromJson),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData) {
            return const Center(child: Text("No Detail Found"));
          } else {
            final detail = snapshot.data!;
            if (detail is HomepageModel) {
              return Column(
                children: [
                  ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      child: Image.network(
                        imageUrl,
                        height: 500,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )),
                  SizedBox(
                    height: 16,
                  ),
                  Text(detail.name),
                ],
              );
            } else {
              return const Text("Unknown Data Type");
            }
          }
        },
      ),
    );
  }
}
