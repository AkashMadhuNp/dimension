// lib/bloc/posts/posts_event.dart
import 'package:equatable/equatable.dart';

abstract class PostsEvent extends Equatable {
  const PostsEvent();

  @override
  List<Object?> get props => [];
}

class FetchPostsEvent extends PostsEvent {
  const FetchPostsEvent();
}

class RefreshPostsEvent extends PostsEvent {
  const RefreshPostsEvent();
}

class SearchPostsEvent extends PostsEvent {
  final String userId;
  final String postId;

  const SearchPostsEvent({
    required this.userId,
    required this.postId,
  });

  @override
  List<Object?> get props => [userId, postId];
}

class ClearSearchEvent extends PostsEvent {
  const ClearSearchEvent();
}