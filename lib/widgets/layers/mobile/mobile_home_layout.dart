import 'package:dimension_machine_task/service/api_service.dart';
import 'package:dimension_machine_task/widgets/layers/mobile/mobile_search_section.dart' show MobileSearchSection;
import 'package:flutter/material.dart';
import 'package:dimension_machine_task/widgets/layers/mobile/mobile_appbar.dart';
import 'package:dimension_machine_task/widgets/common/mobile_drawer.dart';
import 'package:dimension_machine_task/widgets/layers/mobile/mobile_custom_card.dart';
import 'package:dimension_machine_task/model/post_model.dart';

class MobileHomeLayout extends StatefulWidget {
  const MobileHomeLayout({super.key});

  @override
  State<MobileHomeLayout> createState() => _MobileHomeLayoutState();
}

class _MobileHomeLayoutState extends State<MobileHomeLayout> {
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
    return Scaffold(
      appBar: const MobileAppBar(),
      drawer: const MobileDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            MobileSearchSection(
              onSearch: _performSearch,
              isLoading: _isSearching,
              onClearSearch: _clearSearch,
            ),
            const SizedBox(height: 10),
            
            // Search Results Info
            if (_currentSearchQuery.isNotEmpty || _currentLocationQuery.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  children: [
                    Icon(Icons.search, size: 16, color: Colors.grey[600]),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Showing ${_filteredPosts.length} results for "${_currentSearchQuery.isNotEmpty ? _currentSearchQuery : 'all'}"${_currentLocationQuery.isNotEmpty ? ' in "$_currentLocationQuery"' : ''}',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            
            Expanded(
              child: _buildContent(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContent() {
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

    if (_errorMessage != null) {
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
              _errorMessage!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
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

    if (_filteredPosts.isEmpty) {
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
              _currentSearchQuery.isNotEmpty || _currentLocationQuery.isNotEmpty
                  ? 'No results found'
                  : 'No posts found',
              style: const TextStyle(fontSize: 18),
            ),
            if (_currentSearchQuery.isNotEmpty || _currentLocationQuery.isNotEmpty) ...[
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
      onRefresh: _refreshPosts,
      child: ListView.builder(
        itemCount: _filteredPosts.length,
        itemBuilder: (context, index) {
          final post = _filteredPosts[index];
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
}