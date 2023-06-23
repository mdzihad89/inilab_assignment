
import 'package:dio/dio.dart';
import '../model/repository_model.dart';
import '../model/user_model.dart';

class ApiServices {
  final Dio _dio;
  ApiServices() : _dio = Dio(BaseOptions(baseUrl: 'https://api.github.com/'));

   Future<User?> getUser(String name) async {
   try{
     final response = await _dio.get('users/$name');
     if (response.statusCode == 200) {
       final Map<String, dynamic> data = response.data;
       return User.fromJson(data);
     }
     throw Exception('Failed to fetch user data');
   }catch(e){
     throw Exception(e.toString());
   }
  }


  Future<List<RepositoryModel>?> fetchRepos(String name) async {
    try {
      final response = await _dio.get('users/$name/repos');

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = response.data;
        final List<RepositoryModel> repos = jsonData.map((json) =>
            RepositoryModel.fromJson(json)).toList();
        return repos;
      } else {
        throw Exception('Failed to fetch repository data');
      }
    }catch(e){
      throw Exception(e.toString());
    }
  }




}