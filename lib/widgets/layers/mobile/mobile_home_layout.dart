import 'package:dimension_machine_task/bloc/mob_hom_lay_bloc.dart';
import 'package:dimension_machine_task/bloc/mob_hom_lay_event.dart';
import 'package:dimension_machine_task/bloc/mob_hom_lay_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dimension_machine_task/service/api_service.dart';
import 'package:dimension_machine_task/widgets/layers/mobile/mobile_search_section.dart' show MobileSearchSection;
import 'package:dimension_machine_task/widgets/layers/mobile/mobile_appbar.dart';
import 'package:dimension_machine_task/widgets/common/mobile_drawer.dart';
import 'package:dimension_machine_task/widgets/layers/mobile/mobile_custom_card.dart';

class MobileHomeLayout extends StatefulWidget {
  const MobileHomeLayout({super.key});

  @override
  State<MobileHomeLayout> createState() => _MobileHomeLayoutState();
}

class _MobileHomeLayoutState extends State<MobileHomeLayout> {
  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(const FetchPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return const MobileHomeView();
  }
}

class MobileHomeView extends StatelessWidget {
  const MobileHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MobileAppBar(),
      drawer: const MobileDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            BlocBuilder<PostsBloc, PostsState>(
              buildWhen: (previous, current) =>
                  current is PostsSearching || 
                  (previous is PostsSearching && current is! PostsSearching),
              builder: (context, state) {
                bool isSearching = state is PostsSearching;
                
                return MobileSearchSection(
                  onSearch: (userId, postId) {
                    context.read<PostsBloc>().add(SearchPostsEvent(
                      userId: userId,
                      postId: postId,
                    ));
                  },
                  isLoading: isSearching,
                  onClearSearch: () {
                    context.read<PostsBloc>().add(const ClearSearchEvent());
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            
            // Search Results Info
            BlocBuilder<PostsBloc, PostsState>(
              buildWhen: (previous, current) =>
                  current is PostsLoaded ||
                  (previous is PostsLoaded && current is! PostsLoaded),
              builder: (context, state) {
                if (state is! PostsLoaded) return const SizedBox.shrink();
                
                final hasSearch = state.currentSearchQuery.isNotEmpty || 
                                 state.currentLocationQuery.isNotEmpty;
                
                if (!hasSearch) return const SizedBox.shrink();
                
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(Icons.search, size: 16, color: Colors.grey[600]),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Showing ${state.filteredPosts.length} results for "${state.currentSearchQuery.isNotEmpty ? state.currentSearchQuery : 'all'}"${state.currentLocationQuery.isNotEmpty ? ' in "${state.currentLocationQuery}"' : ''}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            
            Expanded(
              child: BlocBuilder<PostsBloc, PostsState>(
                builder: (context, state) {
                  return _buildContent(context, state);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context, PostsState state) {
    if (state is PostsInitial || state is PostsLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Loading posts...',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }

    if (state is PostsError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading posts',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.read<PostsBloc>().add(const RefreshPostsEvent());
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state is PostsSearching) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text(
              'Searching...',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      );
    }

    if (state is PostsLoaded) {
      if (state.filteredPosts.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search_off,
                size: 64,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                state.currentSearchQuery.isNotEmpty || state.currentLocationQuery.isNotEmpty
                    ? 'No results found'
                    : 'No posts found',
                style: const TextStyle(fontSize: 18),
              ),
              if (state.currentSearchQuery.isNotEmpty || state.currentLocationQuery.isNotEmpty) ...[
                const SizedBox(height: 8),
                const Text(
                  'Try adjusting your search terms',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ],
          ),
        );
      }

      return RefreshIndicator(
        onRefresh: () async {
          final bloc = context.read<PostsBloc>();
          bloc.add(const RefreshPostsEvent());
          
          // Wait for the refresh to complete by listening to state changes
          await bloc.stream.firstWhere(
            (state) => state is! PostsLoading && state is! PostsSearching,
          );
        },
        child: ListView.builder(
          itemCount: state.filteredPosts.length,
          itemBuilder: (context, index) {
            final post = state.filteredPosts[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: MobileCustomCard(
                title: post.title,
                desc: post.body,
              ),
            );
          },
        ),
      );
    }

    return const SizedBox.shrink();
  }
}