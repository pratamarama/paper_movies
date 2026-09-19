import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paper_movies/constants/app_padding.dart';
import 'package:paper_movies/features/movies/domain/entities/category.dart';
import 'package:paper_movies/features/movies/domain/entities/movie.dart';
import 'package:paper_movies/features/movies/presentation/blocs/movie_list_bloc.dart';
import 'package:paper_movies/features/movies/presentation/widgets/widgets.dart';

/// Created by Pratama Ramadhan on 18/09/26.

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<MovieListBloc>().add(const MovieListEvent.initial());
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: <BlocListener<MovieListBloc, MovieListState>>[
        BlocListener<MovieListBloc, MovieListState>(
          listenWhen: (MovieListState previous, MovieListState current) =>
              previous.errorMessage != current.errorMessage,
          listener: (BuildContext context, MovieListState state) {
            if (state.errorMessage.isNotEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage), backgroundColor: Colors.red),
              );
            }
          },
        ),
      ],
      child: Scaffold(
        appBar: CustomAppBar.title(context, title: 'Paper Movies'),
        body: BlocBuilder<MovieListBloc, MovieListState>(
          buildWhen: (MovieListState previous, MovieListState current) => previous.movieList != current.movieList,
          builder: (BuildContext context, MovieListState state) {
            final List<Movie> movieList = state.movieList;
            return Column(
              children: <Widget>[
                const SizedBox(height: kPaddingSm),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPaddingSm),
                  child: CustomSearchBar(
                    onChanged: (String text) => context.read<MovieListBloc>().add(MovieListEvent.search(text: text)),
                    controller: _searchController,
                    hintText: 'Search movie title',
                  ),
                ),
                const SizedBox(height: kPaddingMd),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: kPaddingSm),
                  child: Row(
                    children: <Widget>[
                      const Expanded(
                        child: Text(
                          'Filter by Rating',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2C2C2C),
                          ),
                        ),
                      ),
                      Text(
                        'Totals = ${movieList.length}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF4B4B4B),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: kPaddingSm),
                SizedBox(
                  height: 42,
                  child: BlocBuilder<MovieListBloc, MovieListState>(
                    buildWhen: (MovieListState previous, MovieListState current) =>
                        previous.categoryList != current.categoryList,
                    builder: (BuildContext context, MovieListState state) {
                      final List<Category> categoryList = state.categoryList;
                      final Category? selectedCategory = categoryList.firstWhereOrNull(
                        (Category element) => element.activeStatus,
                      );

                      return ListView(
                        padding: const EdgeInsets.symmetric(horizontal: kPaddingSm),
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        children: categoryList.map((Category category) {
                          final bool isSelected = category == selectedCategory;

                          return CategoryChip(
                            isSelected: isSelected,
                            category: category,
                            onSelected: () {
                              context.read<MovieListBloc>().add(
                                MovieListEvent.filter(categoryIndex: categoryList.indexOf(category)),
                              );
                            },
                          );
                        }).toList(),
                      );
                    },
                  ),
                ),

                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<MovieListBloc>().add(const MovieListEvent.initial());
                    },
                    child: Builder(
                      builder: (BuildContext context) {
                        final bool isListEmpty = movieList.isEmpty;
                        final int itemCount = isListEmpty ? 1 : movieList.length;

                        return ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: kPaddingSm, vertical: kPaddingMd),
                          shrinkWrap: true,
                          itemCount: itemCount,
                          itemBuilder: (BuildContext context, int index) {
                            if (isListEmpty) {
                              return const _EmptyPlaceholder();
                            }

                            final Movie movie = movieList[index];
                            return MovieCard(movie: movie);
                          },
                          separatorBuilder: (_, _) => const SizedBox(height: 8),
                        );
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _EmptyPlaceholder extends StatelessWidget {
  const _EmptyPlaceholder();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Icon(Icons.movie_outlined, size: 52, color: Colors.grey),
        SizedBox(height: 12),
        Text(
          'No movies found',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Try another title or filter',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
