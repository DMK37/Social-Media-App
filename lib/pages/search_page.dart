import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media/search/cubit/search_cubit.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: true,
          centerTitle: true,
          title: SizedBox(
              height: 40,
              child: Builder(builder: (context) {
                return ValueListenableBuilder(
                  valueListenable: _searchController,
                  builder: (context, value, child) {
                    return SearchBar(
                      hintText: "Search",
                      hintStyle: Theme.of(context).searchBarTheme.hintStyle,
                      leading: const Icon(Icons.search),
                      elevation: MaterialStateProperty.all(0),
                      backgroundColor:
                          Theme.of(context).searchBarTheme.backgroundColor,
                      controller: _searchController,
                      onSubmitted: (value) {
                        if (value.isNotEmpty) {
                          context.read<SearchCubit>().search(value.trim());
                        }
                      },
                      trailing: [
                        _searchController.text.isNotEmpty
                            ? IconButton(
                                icon: const Icon(Icons.clear),
                                onPressed: () {
                                  _searchController.clear();
                                },
                              )
                            : const SizedBox.shrink()
                      ],
                    );
                  },
                );
              })),
          actions: [
            BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                switch (state) {
                  case SearchLoaded():
                    return Container(
                      margin: const EdgeInsets.only(right: 8.0),
                      child: TextButton(
                        child: const Text("Cancel"),
                        onPressed: () {
                          _searchController.clear();
                          context.read<SearchCubit>().clear();
                        },
                      ),
                    );
                  default:
                    return const SizedBox.shrink();
                }
              },
            )
          ],
        ),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            switch (state) {
              case SearchInitial():
                return const SizedBox.shrink();
              case SearchLoading():
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case SearchLoaded(results: final users):
                return ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) => ListTile(
                          leading: CircleAvatar(
                            radius: 18,
                            backgroundImage:
                                NetworkImage(users[index].profileImageUrl),
                          ),
                          title: Text(users[index].username),
                          subtitle: Text(
                              "${users[index].firstName} ${users[index].lastName}"),
                          onTap: () {
                            context.push('/user/${users[index].username}');
                          },
                        ));
              case SearchError(message: final message):
                return Center(
                  child: Text(message),
                );
              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }
}
