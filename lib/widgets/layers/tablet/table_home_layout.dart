import 'package:dimension_machine_task/bloc/mob_hom_lay_bloc.dart';
import 'package:dimension_machine_task/bloc/mob_hom_lay_event.dart';
import 'package:dimension_machine_task/bloc/mob_hom_lay_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dimension_machine_task/core/responsive_calculator.dart';
import 'package:dimension_machine_task/widgets/layers/tablet/tablet_profile_conatiner.dart';
import 'package:dimension_machine_task/widgets/layers/tablet/tablet_appbar.dart';
import 'package:dimension_machine_task/widgets/layers/tablet/tablet_custom_card.dart';
import 'package:dimension_machine_task/widgets/layers/tablet/tablet_search_bar.dart';

class TabletHomeLayout extends StatefulWidget {
  const TabletHomeLayout({super.key});

  @override
  State<TabletHomeLayout> createState() => _TabletHomeLayoutState();
}

class _TabletHomeLayoutState extends State<TabletHomeLayout> {
  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(const FetchPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    final responsive = ResponsiveCalculator.fromContext(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    
    const double baseFontSizeLarge = 14.0;
    const double baseFontSizeMedium = 13.0;
    const double baseFontSizeSmall = 12.0;
    const double baseFontSizeExtraSmall = 11.0;
    const double baseFontSizeDefault = 12.0; 
    const double baseFontSizeTiny = 10.0;
    
    double fontScale = 1.0;
    if (screenWidth < 840) {
      fontScale = 0.9; 
    } else if (screenWidth < 1200) {
      fontScale = 1.0; 
    } else if (screenWidth < 1600) {
      fontScale = 1.1; 
    } else {
      fontScale = 1.2; 
    }
    
    final double responsiveFontLarge = baseFontSizeLarge * fontScale;
    final double responsiveFontMedium = baseFontSizeMedium * fontScale;
    final double responsiveFontSmall = baseFontSizeSmall * fontScale;
    final double responsiveFontExtraSmall = baseFontSizeExtraSmall * fontScale;
    final double responsiveFontDefault = baseFontSizeDefault * fontScale;
    final double responsiveFontTiny = baseFontSizeTiny * fontScale;
    final double responsiveIconSize = 12.0 * fontScale;
    
    return Scaffold(
      appBar: const TabletAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                      
                      return SearchBartablet(
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
                  const SizedBox(height: 20),
                  
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
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          children: [
                            Icon(Icons.search, size: 18, color: Colors.grey[600]),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Showing ${state.filteredPosts.length} results for "${state.currentSearchQuery.isNotEmpty ? state.currentSearchQuery : 'all'}"${state.currentLocationQuery.isNotEmpty ? ' in "${state.currentLocationQuery}"' : ''}',
                                style: TextStyle(
                                  fontSize: responsiveFontSmall,
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
                        return _buildContent(
                          context,
                          state,
                          fontScale, 
                          responsiveFontDefault, 
                          responsiveIconSize, 
                          responsiveFontTiny
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 16),
            
            Expanded(
              flex: 3,
              child: TableProfileConatiner(
                screenHeight: screenHeight, 
                screenWidth: screenWidth, 
                fontScale: fontScale, 
                responsiveFontLarge: responsiveFontLarge, 
                responsiveFontMedium: responsiveFontMedium, 
                responsiveFontSmall: responsiveFontSmall, 
                responsiveFontExtraSmall: responsiveFontExtraSmall
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
    double fontScale, 
    double responsiveFontDefault, 
    double responsiveIconSize, 
    double responsiveFontTiny
  ) {
    // Show loading during initial fetch
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

    // Show error state
    if (state is PostsError) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 60,
              color: Colors.red,
            ),
            const SizedBox(height: 16),
            Text(
              'Error loading posts',
              style: TextStyle(
                fontSize: responsiveFontDefault * 1.3,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              state.message,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: responsiveFontDefault),
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

    // Show search overlay during search
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

    // Handle loaded state
    if (state is PostsLoaded) {
      // Show empty state
      if (state.filteredPosts.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.search_off,
                size: 60,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                state.currentSearchQuery.isNotEmpty || state.currentLocationQuery.isNotEmpty
                    ? 'No results found'
                    : 'No posts found',
                style: TextStyle(fontSize: responsiveFontDefault * 1.2),
              ),
              if (state.currentSearchQuery.isNotEmpty || state.currentLocationQuery.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  'Try adjusting your search terms',
                  style: TextStyle(
                    fontSize: responsiveFontDefault, 
                    color: Colors.grey
                  ),
                ),
              ],
            ],
          ),
        );
      }

      // Show posts with refresh capability
      return RefreshIndicator(
        onRefresh: () async {
          final bloc = context.read<PostsBloc>();
          bloc.add(const RefreshPostsEvent());
          
          // Wait for the refresh to complete by listening to state changes
          await bloc.stream.firstWhere(
            (state) => state is! PostsLoading && state is! PostsSearching,
          );
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: state.filteredPosts.map((post) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 12.0),
                child: TabletCustomCard(
                  desc: post.body,
                  title: post.title,
                  fontScale: fontScale,
                  responsiveFontDefault: responsiveFontDefault,
                  responsiveIconSize: responsiveIconSize,
                  responsiveFontTiny: responsiveFontTiny,
                ),
              );
            }).toList(),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}