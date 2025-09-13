import 'package:dimension_machine_task/core/responsive_calculator.dart';
import 'package:dimension_machine_task/model/post_model.dart';
import 'package:dimension_machine_task/service/api_service.dart';
import 'package:dimension_machine_task/widgets/layers/desktop/desktop_custom_card.dart';
import 'package:dimension_machine_task/widgets/layers/desktop/desktop_search_bar.dart';
import 'package:flutter/material.dart';
import 'package:dimension_machine_task/widgets/common/responsive_profile_card.dart';
import 'package:dimension_machine_task/widgets/layers/desktop/desktop_appbar.dart';

class DesktopHomeLayout extends StatefulWidget {
  const DesktopHomeLayout({super.key});

  @override
  State<DesktopHomeLayout> createState() => _DesktopHomeLayoutState();
}

class _DesktopHomeLayoutState extends State<DesktopHomeLayout> {
  final ApiService _apiService = ApiService();
  List<Post> _posts = [];
  List<Post> _filteredPosts = [];
  bool _isLoading = true;
  bool _isSearching = false;
  String? _errorMessage;
  String _currentSearchQuery = '';
  String _currentLocationQuery = '';

  @override
  void initState() {
    super.initState();
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final posts = await _apiService.fetchPosts();
      
      setState(() {
        _posts = posts;
        _filteredPosts = posts;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
      print('Error fetching posts: $e');
    }
  }

  Future<void> _refreshPosts() async {
    await _fetchPosts();
  }

  Future<void> _performSearch(String userId, String postId) async {
    setState(() {
      _isSearching = true;
      _errorMessage = null;
    });

    try {
      await Future.delayed(const Duration(milliseconds: 800));

      if (userId.isEmpty && postId.isEmpty) {
        setState(() {
          _filteredPosts = _posts;
          _isSearching = false;
          _currentSearchQuery = '';
          _currentLocationQuery = '';
        });
        return;
      }

      final filteredResults = _posts.where((post) {
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

      setState(() {
        _filteredPosts = filteredResults;
        _isSearching = false;
        _currentSearchQuery = userId; // Store for display purposes
        _currentLocationQuery = postId; // Store for display purposes
      });

    } catch (e) {
      setState(() {
        _errorMessage = 'Search failed: ${e.toString()}';
        _isSearching = false;
      });
    }
  }

  void _clearSearch() {
    setState(() {
      _filteredPosts = _posts;
      _currentSearchQuery = '';
      _currentLocationQuery = '';
      _errorMessage = null;
    });
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
                  DesktopSearchSection(
                    onSearch: _performSearch,
                    isLoading: _isSearching,
                    onClearSearch: _clearSearch,
                  ),
                  const SizedBox(height: 32),
                  
                  // Search Results Info
                  if (_currentSearchQuery.isNotEmpty || _currentLocationQuery.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: [
                          Icon(Icons.search, size: 20, color: Colors.grey[600]),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Showing ${_filteredPosts.length} results for "${_currentSearchQuery.isNotEmpty ? _currentSearchQuery : 'all'}"${_currentLocationQuery.isNotEmpty ? ' in "$_currentLocationQuery"' : ''}',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  Expanded(
                    child: _buildContent(responsive),
                  ),
                ],
              ),
            ),
            
            const SizedBox(width: 24),
            
            Expanded(
              flex: 3,
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
          ],
        ),
      ),
    );
  }

  Widget _buildContent(ResponsiveCalculator responsive) {
    // Show loading during initial fetch
    if (_isLoading) {
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

    // Show error state
    if (_errorMessage != null) {
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
              _errorMessage!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: _refreshPosts,
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    // Show search overlay during search
    if (_isSearching) {
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

    // Show empty state
    if (_filteredPosts.isEmpty) {
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
              _currentSearchQuery.isNotEmpty || _currentLocationQuery.isNotEmpty
                  ? 'No results found'
                  : 'No posts found',
              style: const TextStyle(fontSize: 20),
            ),
            if (_currentSearchQuery.isNotEmpty || _currentLocationQuery.isNotEmpty) ...[
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

    // Show posts list
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _filteredPosts.map((post) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16.0),
            child: JobCard(
              title: post.title,
              desc: post.body,
            ),
          );
        }).toList(),
      ),
    );
  }
}