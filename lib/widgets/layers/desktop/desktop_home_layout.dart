import 'package:dimension_machine_task/bloc/mob_hom_lay_bloc.dart';
import 'package:dimension_machine_task/bloc/mob_hom_lay_event.dart';
import 'package:dimension_machine_task/bloc/mob_hom_lay_state.dart';
import 'package:dimension_machine_task/screen/profile_screen.dart';
import 'package:dimension_machine_task/widgets/common/responsive_profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dimension_machine_task/core/responsive_calculator.dart';
import 'package:dimension_machine_task/widgets/layers/desktop/desktop_custom_card.dart';
import 'package:dimension_machine_task/widgets/layers/desktop/desktop_search_bar.dart';
import 'package:dimension_machine_task/widgets/layers/desktop/desktop_appbar.dart';
class DesktopHomeLayout extends StatefulWidget {
  const DesktopHomeLayout({super.key});

  @override
  State<DesktopHomeLayout> createState() => _DesktopHomeLayoutState();
}

class _DesktopHomeLayoutState extends State<DesktopHomeLayout> {
  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(const FetchPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCalculator.fromContextDesktop(context);
    final horizontalPadding = responsive.screenWidth * 0.10;
    
    return Scaffold(
      appBar: const DesktopAppBar(),
      body: Padding(
        padding: EdgeInsets.only(
          left: horizontalPadding,
          right: horizontalPadding,
          top: 40.0,
          bottom: 24,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BlocBuilder<PostsBloc, PostsState>(
                    buildWhen: (previous, current) =>
                        current is PostsSearching || 
                        (previous is PostsSearching && current is! PostsSearching),
                    builder: (context, state) {
                      bool isSearching = state is PostsSearching;
                      
                      return DesktopSearchSection(
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
                  const SizedBox(height: 32),
                  
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
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          children: [
                            Icon(Icons.search, size: 20, color: Colors.grey[600]),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                'Showing ${state.filteredPosts.length} results for "${state.currentSearchQuery.isNotEmpty ? state.currentSearchQuery : 'all'}"${state.currentLocationQuery.isNotEmpty ? ' in "${state.currentLocationQuery}"' : ''}',
                                style: TextStyle(
                                  fontSize: 16,
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
                        return _buildContent(context, state, responsive);
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 24),
            
            Expanded(
              flex: 3,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => ProfileScreen(),));
                },                
                child: ResponsiveProfileContainer(
                  screenHeight: responsive.screenHeight,
                  screenWidth: responsive.screenWidth,
                  fontScale: responsive.fontScale,
                  responsiveFontLarge: responsive.responsiveFontLarge,
                  responsiveFontMedium: responsive.responsiveFontMedium,
                  responsiveFontSmall: responsive.responsiveFontSmall,
                  responsiveFontExtraSmall: responsive.responsiveFontExtraSmall,
                  isDesktop: true,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context, 
    PostsState state, 
    ResponsiveCalculator responsive
  ) {
    if (state is PostsInitial || state is PostsLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 24),
            Text(
              'Loading posts...',
              style: TextStyle(fontSize: 18),
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
              size: 80,
              color: Colors.red,
            ),
            const SizedBox(height: 24),
            Text(
              'Error loading posts',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
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
            SizedBox(height: 24),
            Text(
              'Searching...',
              style: TextStyle(fontSize: 18),
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
                size: 80,
                color: Colors.grey,
              ),
              const SizedBox(height: 24),
              Text(
                state.currentSearchQuery.isNotEmpty || state.currentLocationQuery.isNotEmpty
                    ? 'No results found'
                    : 'No posts found',
                style: const TextStyle(fontSize: 20),
              ),
              if (state.currentSearchQuery.isNotEmpty || state.currentLocationQuery.isNotEmpty) ...[
                const SizedBox(height: 12),
                const Text(
                  'Try adjusting your search terms',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ],
            ],
          ),
        );
      }

      return RefreshIndicator(
        color: Colors.amber,
        onRefresh: () async {
          final bloc = context.read<PostsBloc>();
          bloc.add(const RefreshPostsEvent());
          
          await bloc.stream.firstWhere(
            (state) => state is! PostsLoading && state is! PostsSearching,
          );
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * 0.6,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: state.filteredPosts.map((post) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: JobCard(
                        title: post.title,
                        desc: post.body,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}