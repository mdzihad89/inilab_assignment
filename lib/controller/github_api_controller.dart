import 'package:get/get.dart';

import '../model/user_model.dart';
import '../services/api_services.dart';

class GithubApiController extends GetxController{
  var isLoadingUserData = true.obs;
  var userModel=User().obs;
  final ApiServices _apiService = ApiServices();

  var isLoadingRepo = true.obs;
  final List<String> sortingOption=['Name', 'Date'];
  RxString selectedSortingOption='Name'.obs;
  var reposList = [].obs;

  void fetchUser(String name) async {
    try {
      isLoadingUserData(true);
      var user = await _apiService.getUser(name);
      if (user != null) {
        userModel.value = user;
      }
    }
    finally {
      isLoadingUserData(false);
    }
  }


  void fetchRepos(String name) async {
    try {
      isLoadingRepo(true);
      var products = await _apiService.fetchRepos(name);
      if (products != null) {
        reposList.value = products;
      }
    }

    finally {
      isLoadingRepo(false);
    }

  }

  void sortRepositories() {
    if (selectedSortingOption.value == 'Name') {
      reposList.sort((a, b) => a.name.compareTo(b.name));
    } else if (selectedSortingOption.value == 'Date') {
      reposList.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    }
  }


}