import 'package:dimension_machine_task/core/responsive_calculator.dart';
import 'package:dimension_machine_task/model/post_model.dart';
import 'package:dimension_machine_task/service/api_service.dart';
import 'package:dimension_machine_task/widgets/layers/tablet/tablet_profile_conatiner.dart';
import 'package:flutter/material.dart';
import 'package:dimension_machine_task/widgets/layers/tablet/tablet_appbar.dart';
import 'package:dimension_machine_task/widgets/layers/tablet/tablet_custom_card.dart';
import 'package:dimension_machine_task/widgets/layers/tablet/tablet_search_bar.dart';

class TabletHomeLayout extends StatefulWidget {
  const TabletHomeLayout({super.key});

  @override
  State<TabletHomeLayout> createState() => _TabletHomeLayoutState();
}

class _TabletHomeLayoutState extends State<TabletHomeLayout> {
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
        _currentSearchQuery = userId;
        _currentLocationQuery = postId;
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
                  SearchBartablet(
                    onSearch: _performSearch,
                    isLoading: _isSearching,
                    onClearSearch: _clearSearch,
                  ),
                  const SizedBox(height: 20),
                  
                  // Search Results Info
                  if (_currentSearchQuery.isNotEmpty || _currentLocationQuery.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        children: [
                          Icon(Icons.search, size: 18, color: Colors.grey[600]),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              'Showing ${_filteredPosts.length} results for "${_currentSearchQuery.isNotEmpty ? _currentSearchQuery : 'all'}"${_currentLocationQuery.isNotEmpty ? ' in "$_currentLocationQuery"' : ''}',
                              style: TextStyle(
                                fontSize: responsiveFontSmall,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  
                  Expanded(
                    child: _buildContent(
                      fontScale, 
                      responsiveFontDefault, 
                      responsiveIconSize, 
                      responsiveFontTiny
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

  Widget _buildContent(double fontScale, double responsiveFontDefault, 
                       double responsiveIconSize, double responsiveFontTiny) {
    // Show loading during initial fetch
    if (_isLoading) {
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
    if (_errorMessage != null) {
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
              _errorMessage!,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: responsiveFontDefault),
            ),
            const SizedBox(height: 16),
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
            SizedBox(height: 16),
            Text(
              'Searching...',
              style: TextStyle(fontSize: 16),
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
              size: 60,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              _currentSearchQuery.isNotEmpty || _currentLocationQuery.isNotEmpty
                  ? 'No results found'
                  : 'No posts found',
              style: TextStyle(fontSize: responsiveFontDefault * 1.2),
            ),
            if (_currentSearchQuery.isNotEmpty || _currentLocationQuery.isNotEmpty) ...[
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

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _filteredPosts.map((post) {
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
    );
  }
}