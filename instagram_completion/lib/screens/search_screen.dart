import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:instagram_completion/utils/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late final TextEditingController _searchController = TextEditingController();
  bool isShowUser = false;

  @override
  void dispose() {
    super.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mobileBackgroundColor,
        title: TextFormField(
          controller: _searchController,
          onFieldSubmitted: (value) {
            setState(() {
              if (value.isNotEmpty) {
                isShowUser = true;
              }
              if (value.isEmpty) {
                isShowUser = false;
              }
            });
          },
          decoration: InputDecoration(
            isDense: true,
            hintText: "Search",
            contentPadding: const EdgeInsets.all(10),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(13),
              borderSide: const BorderSide(width: 0, style: BorderStyle.none),
            ),
            filled: true,
            fillColor: Colors.grey.shade900,
          ),
        ),
      ),
      body: isShowUser
          ? FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .where(
                    'username',
                    isGreaterThanOrEqualTo: _searchController.text,
                  )
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.builder(
                  itemCount: (snapshot.data as dynamic).docs.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        (snapshot.data! as dynamic).docs[index]['photoUrl'],
                      ),
                    ),
                    title: Text(
                      (snapshot.data! as dynamic).docs[index]['username'],
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      (snapshot.data! as dynamic).docs[index]['email'],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                );
              },
            )
          : FutureBuilder(
              future: FirebaseFirestore.instance.collection('posts').get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting ||
                    !snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var length = (snapshot.data as dynamic).docs.length;
                print("search screen length: $length");
                return StaggeredGrid.count(
                  crossAxisCount: 3,
                  mainAxisSpacing: 3,
                  crossAxisSpacing: 3,
                  children: [
                    for (int i = 0;
                        i < (snapshot.data as dynamic).docs.length;
                        i++)
                      StaggeredGridTile.count(
                        crossAxisCellCount: 1,
                        mainAxisCellCount: 1,
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                (snapshot.data! as dynamic).docs[i]['postUrl'],
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
    );
  }
}
