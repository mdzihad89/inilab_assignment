import 'package:flutter/material.dart';

import '../model/repository_model.dart';

class RepoDetailsPage extends StatefulWidget {
  final RepositoryModel repositoryModel;
   RepoDetailsPage({super.key, required this.repositoryModel});

  @override
  State<RepoDetailsPage> createState() => _RepoDetailsPageState();
}

class _RepoDetailsPageState extends State<RepoDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.repositoryModel.name ?? "",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  widget.repositoryModel.fullName ?? "",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              widget.repositoryModel.description ?? "",
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
