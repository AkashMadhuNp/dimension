import 'package:equatable/equatable.dart';
import 'package:dimension_machine_task/model/post_model.dart';

abstract class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object?> get props => [];
}

class PostsInitial extends PostsState {
  const PostsInitial();
}

class PostsLoading extends PostsState {
  const PostsLoading();
}

class PostsLoaded extends PostsState {
  final List<Post> posts;
  final List<Post> filteredPosts;
  final String currentSearchQuery;
  final String currentLocationQuery;

  const PostsLoaded({
    required this.posts,
    required this.filteredPosts,
    this.currentSearchQuery = '',
    this.currentLocationQuery = '',
  });

  @override
  List<Object?> get props => [
        posts,
        filteredPosts,
        currentSearchQuery,
        currentLocationQuery,
      ];

  PostsLoaded copyWith({
    List<Post>? posts,
    List<Post>? filteredPosts,
    String? currentSearchQuery,
    String? currentLocationQuery,
  }) {
    return PostsLoaded(
      posts: posts ?? this.posts,
      filteredPosts: filteredPosts ?? this.filteredPosts,
      currentSearchQuery: currentSearchQuery ?? this.currentSearchQuery,
      currentLocationQuery: currentLocationQuery ?? this.currentLocationQuery,
    );
  }
}

class PostsSearching extends PostsState {
  final List<Post> posts;
  final List<Post> currentFilteredPosts;

  const PostsSearching({
    required this.posts,
    required this.currentFilteredPosts,
  });

  @override
  List<Object?> get props => [posts, currentFilteredPosts];
}

class PostsError extends PostsState {
  final String message;
  final List<Post> posts;
  final List<Post> filteredPosts;
  final String currentSearchQuery;
  final String currentLocationQuery;

  const PostsError({
    required this.message,
    this.posts = const [],
    this.filteredPosts = const [],
    this.currentSearchQuery = '',
    this.currentLocationQuery = '',
  });

  @override
  List<Object?> get props => [
        message,
        posts,
        filteredPosts,
        currentSearchQuery,
        currentLocationQuery,
      ];
}