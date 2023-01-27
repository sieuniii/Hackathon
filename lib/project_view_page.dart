import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'main.dart';
import 'project_service.dart';

class ProjectViewPage extends StatefulWidget {
  const ProjectViewPage({super.key});

  @override
  State<ProjectViewPage> createState() => _ProjectViewPageState();
}

class _ProjectViewPageState extends State<ProjectViewPage> {
  @override
  Widget build(BuildContext context) {
    authService.signIn;
    return Scaffold(
      backgroundColor: const Color(0xFFF4F7FC),
      appBar: AppBar(
        toolbarHeight: 100,
        elevation: 0,
        title: Text(
          '프로젝트 목록',
          style: Theme.of(context).textTheme.displayMedium,
        ),
        foregroundColor: const Color(0xFFF4F7FC),
        backgroundColor: const Color(0xFFF4F7FC),
      ),
      body: Center(
        child: Consumer<ProjectService>(
          builder: (context, projectService, _) {
            return FutureBuilder<QuerySnapshot>(
              future: projectService.read(),
              builder: (context, snapshot) {
                final docs = snapshot.data?.docs ?? [];
                return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    String name = doc.get('name');
                    String field = doc.get('field');
                    String annotation = doc.get('annotation');
                    int count = doc.get('count');
                    int reward = doc.get('reward');
                    String image = doc.get('image');
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Container(
                        width: 340,
                        height: 90,
                        margin: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          subtitle: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 0, vertical: 5),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text(name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          'assets/won.png',
                                          color: (reward < 50)
                                              ? const Color(0xFFB48D61)
                                              : (reward < 1000)
                                                  ? const Color(0xFFD7D7D7)
                                                  : const Color(0xFFECC53A),
                                        ),
                                        Text(
                                          " $reward    ",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                        Image.asset(
                                          'assets/pencil.png',
                                          color: const Color(0xFFD7D7D7),
                                        ),
                                        Text(' $annotation',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall),
                                      ],
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    (reward < 50)
                                        ? Image.asset('assets/Group40.png')
                                        : (reward < 1000)
                                            ? Image.asset('assets/Group41.png')
                                            : Image.asset('assets/Group43.png'),
                                  ],
                                ),
                                Row(
                                  children: [ Text(name,
                                            style: Theme.of(context)
                                                .textTheme
                                                .displayMedium),
                                      ],],
                                )
                              ],
                            ),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  insetPadding: const EdgeInsets.symmetric(
                                      vertical: 40, horizontal: 24),
                                  actions: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('시작하기'),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                  content: Column(
                                    children: [
                                      Text(name),
                                      const SizedBox(height: 20),
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          image,
                                          height: 300,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          const Text(
                                            "분량",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(" 사진 $count장  "),
                                          const Text(
                                            "분야 ",
                                            style:
                                                TextStyle(color: Colors.grey),
                                          ),
                                          Text(field),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                    )
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
