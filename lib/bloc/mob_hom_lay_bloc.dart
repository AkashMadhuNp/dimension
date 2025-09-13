import 'package:dimension_machine_task/bloc/mob_hom_lay_event.dart';
import 'package:dimension_machine_task/bloc/mob_hom_lay_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dimension_machine_task/service/api_service.dart';
import 'package:dimension_machine_task/model/post_model.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final ApiService _apiService;

  PostsBloc({ApiService? apiService})
      : _apiService = apiService ?? ApiService(),
        super(const PostsInitial()) {
    on<FetchPostsEvent>(_onFetchPosts);
    on<RefreshPostsEvent>(_onRefreshPosts);
    on<SearchPostsEvent>(_onSearchPosts);
    on<ClearSearchEvent>(_onClearSearch);
  }

  Future<void> _onFetchPosts(
    FetchPostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    try {
      emit(const PostsLoading());
      
      final posts = await _apiService.fetchPosts();
      
      emit(PostsLoaded(
        posts: posts,
        filteredPosts: posts,
      ));
    } catch (e) {
      emit(PostsError(
        message: e.toString(),
      ));
    }
  }

  Future<void> _onRefreshPosts(
    RefreshPostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    try {
      final currentState = state;
      List<Post> currentPosts = [];
      List<Post> currentFilteredPosts = [];
      String currentSearchQuery = '';
      String currentLocationQuery = '';

      if (currentState is PostsLoaded) {
        currentPosts = currentState.posts;
        currentFilteredPosts = currentState.filteredPosts;
        currentSearchQuery = currentState.currentSearchQuery;
        currentLocationQuery = currentState.currentLocationQuery;
      } else if (currentState is PostsError) {
        currentPosts = currentState.posts;
        currentFilteredPosts = currentState.filteredPosts;
        currentSearchQuery = currentState.currentSearchQuery;
        currentLocationQuery = currentState.currentLocationQuery;
      }

      // Don't emit loading state during refresh - this prevents infinite loading
      final posts = await _apiService.fetchPosts();
      
      // If there's an active search, reapply it
      List<Post> filteredPosts = posts;
      if (currentSearchQuery.isNotEmpty || currentLocationQuery.isNotEmpty) {
        filteredPosts = _filterPosts(posts, currentSearchQuery, currentLocationQuery);
      }
      
      emit(PostsLoaded(
        posts: posts,
        filteredPosts: filteredPosts,
        currentSearchQuery: currentSearchQuery,
        currentLocationQuery: currentLocationQuery,
      ));
    } catch (e) {
      final currentState = state;
      if (currentState is PostsLoaded || currentState is PostsError) {
        List<Post> posts = [];
        List<Post> filteredPosts = [];
        String searchQuery = '';
        String locationQuery = '';

        if (currentState is PostsLoaded) {
          posts = currentState.posts;
          filteredPosts = currentState.filteredPosts;
          searchQuery = currentState.currentSearchQuery;
          locationQuery = currentState.currentLocationQuery;
        } else if (currentState is PostsError) {
          posts = currentState.posts;
          filteredPosts = currentState.filteredPosts;
          searchQuery = currentState.currentSearchQuery;
          locationQuery = currentState.currentLocationQuery;
        }

        emit(PostsError(
          message: e.toString(),
          posts: posts,
          filteredPosts: filteredPosts,
          currentSearchQuery: searchQuery,
          currentLocationQuery: locationQuery,
        ));
      } else {
        emit(PostsError(message: e.toString()));
      }
    }
  }

  Future<void> _onSearchPosts(
    SearchPostsEvent event,
    Emitter<PostsState> emit,
  ) async {
    final currentState = state;
    List<Post> posts = [];

    if (currentState is PostsLoaded) {
      posts = currentState.posts;
    } else if (currentState is PostsError) {
      posts = currentState.posts;
    } else {
      return; // Can't search without posts
    }

    emit(PostsSearching(
      posts: posts,
      currentFilteredPosts: currentState is PostsLoaded 
          ? currentState.filteredPosts 
          : (currentState is PostsError ? currentState.filteredPosts : []),
    ));

    try {
      // Add artificial delay to simulate search processing
      await Future.delayed(const Duration(milliseconds: 800));

      List<Post> filteredResults;
      
      if (event.userId.isEmpty && event.postId.isEmpty) {
        filteredResults = posts;
      } else {
        filteredResults = _filterPosts(posts, event.userId, event.postId);
      }

      emit(PostsLoaded(
        posts: posts,
        filteredPosts: filteredResults,
        currentSearchQuery: event.userId,
        currentLocationQuery: event.postId,
      ));
    } catch (e) {
      emit(PostsError(
        message: 'Search failed: ${e.toString()}',
        posts: posts,
        filteredPosts: currentState is PostsLoaded 
            ? currentState.filteredPosts 
            : (currentState is PostsError ? currentState.filteredPosts : []),
      ));
    }
  }

  void _onClearSearch(
    ClearSearchEvent event,
    Emitter<PostsState> emit,
  ) {
    final currentState = state;
    List<Post> posts = [];

    if (currentState is PostsLoaded) {
      posts = currentState.posts;
    } else if (currentState is PostsError) {
      posts = currentState.posts;
    } else {
      return;
    }

    emit(PostsLoaded(
      posts: posts,
      filteredPosts: posts,
      currentSearchQuery: '',
      currentLocationQuery: '',
    ));
  }

  List<Post> _filterPosts(List<Post> posts, String userId, String postId) {
    return posts.where((post) {
      bool userIdMatch = true;
      bool postIdMatch = true;

      if (userId.isNotEmpty) {
        try {
          final searchUserId = int.parse(userId);
          userIdMatch = post.userId == searchUserId;
        } catch (e) {
          userIdMatch = false;
        }
      }

      if (postId.isNotEmpty) {
        try {
          final searchPostId = int.parse(postId);
          postIdMatch = post.id == searchPostId;
        } catch (e) {
          postIdMatch = false;
        }
      }

      return userIdMatch && postIdMatch;
    }).toList();
  }
}