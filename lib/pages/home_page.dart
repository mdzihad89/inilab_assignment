import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:inilabs_assignment/pages/repo_details_page.dart';
import '../controller/github_api_controller.dart';


class HomePage extends StatefulWidget {
  final String username;
  const HomePage({super.key, required this.username});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GithubApiController githubApiController = Get.put(GithubApiController());
  bool showListView = false;


  @override
  void initState() {
    githubApiController.fetchRepos(widget.username);
    githubApiController.fetchUser(widget.username);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child:  Column(
            children: [
              Obx(() {
                if (githubApiController.isLoadingUserData.value) {
                  return const Center(child: CircularProgressIndicator());
                } else {
              return
                Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                githubApiController
                                .userModel.value.avatarUrl
                                .toString()),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  githubApiController.userModel.value.name ?? "No USer Name",
                                  style: const TextStyle(
                                      fontSize: 23,
                                      fontWeight: FontWeight.bold),
                                ),

                                Text(
                                  githubApiController.userModel.value.login??"No Name",
                                  style: const TextStyle(fontSize: 19),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                        const EdgeInsets.only(top: 20.0, bottom: 10),
                        child: Text(
                          githubApiController.userModel.value.bio ?? "No Bio",
                          style: const TextStyle(fontSize: 20),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.apartment,
                            size: 25,
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.only(left: 5.0, right: 30),
                            child: Text(
                              githubApiController.userModel.value.company ??
                                  "No Company",
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),

                          const Icon(
                            Icons.location_on_outlined,
                            size: 25,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                              githubApiController.userModel.value.location ?? "No Location",
                              style: const TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 11.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.link,
                              size: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                githubApiController.userModel.value.blog ??
                                    "No Blog Site",
                                style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.person_outline_sharp,
                              size: 25,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5.0),
                              child: Text(
                                githubApiController.userModel.value.followers
                                    .toString(),
                                style: const TextStyle(fontSize: 17),
                              ),
                            ),
                            const Text(
                              ' followers  .  ',
                              style: TextStyle(fontSize: 17),
                            ),
                            Text(
                              githubApiController.userModel.value.following
                                  .toString(),
                              style: const TextStyle(fontSize: 17),
                            ),
                            const Text(
                              ' following',
                              style: TextStyle(fontSize: 17),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Repositories',
                              style: TextStyle(fontSize: 20),
                            ),
                            Text(
                              githubApiController.userModel.value.publicRepos.toString() ,
                              style: const TextStyle(fontSize: 20),
                            ),
                            Switch(
                                value: showListView,
                                onChanged: (val) {
                                  setState(() {
                                    showListView = val;
                                  });
                                }),

                            Obx(
                                  () => DropdownButton(
                                value: githubApiController.selectedSortingOption.value,
                                items: githubApiController.sortingOption.map<DropdownMenuItem<String>>((String option) {
                                  return DropdownMenuItem<String>(
                                    value: option,
                                    child: Text(option),
                                  );
                                }).toList(),
                                onChanged: (String? value) {
                                  githubApiController.selectedSortingOption.value = value!;
                                  githubApiController.sortRepositories();
                                },
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                }
              }),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: Obx(() {
                  if (githubApiController.isLoadingRepo.value) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return showListView
                        ? ListView.builder(
                      itemCount: githubApiController.reposList.length,
                      itemBuilder: (context, index) {
                        var repo = githubApiController.reposList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) => RepoDetailsPage(
                                  repositoryModel: repo),
                            ));
                          },
                          child: ListTile(
                              title: Text(repo.name.toString())),
                        );
                      },
                    )
                        : StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      itemCount: githubApiController.reposList.length,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      itemBuilder: (context, index) {
                        var repo = githubApiController.reposList[index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                              builder: (context) => RepoDetailsPage(
                                  repositoryModel: repo),
                            ));
                          },
                          child: ListTile(
                              title: Text(repo.name.toString())),
                        );
                      },
                      staggeredTileBuilder: (index) =>
                      const StaggeredTile.fit(1),
                    );
                  }
                }),
              ),
            ],
          )

        )
    );
  }
}
