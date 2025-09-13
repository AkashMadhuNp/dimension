import 'package:dimension_machine_task/widgets/common/custom_container.dart';
import 'package:dimension_machine_task/widgets/common/search_bar.dart';
import 'package:dimension_machine_task/widgets/common/search_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MobileSearchSection extends StatefulWidget {
  final Function(String userId, String postId)? onSearch;
  final bool isLoading;
  final VoidCallback? onClearSearch;

  const MobileSearchSection({
    Key? key,
    this.onSearch,
    this.isLoading = false,
    this.onClearSearch,
  }) : super(key: key);

  @override
  State<MobileSearchSection> createState() => _MobileSearchSectionState();
}

class _MobileSearchSectionState extends State<MobileSearchSection> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _postIdController = TextEditingController();
  final FocusNode _userIdFocusNode = FocusNode();
  final FocusNode _postIdFocusNode = FocusNode();

  bool get _hasSearchText => 
      _userIdController.text.trim().isNotEmpty || 
      _postIdController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _userIdController.dispose();
    _postIdController.dispose();
    _userIdFocusNode.dispose();
    _postIdFocusNode.dispose();
    super.dispose();
  }

  void _performSearch() {
    print("🔍 MobileSearchSection: Performing search with userId: '${_userIdController.text}', postId: '${_postIdController.text}'");
    
    if (widget.onSearch != null && !widget.isLoading) {
      _userIdFocusNode.unfocus();
      _postIdFocusNode.unfocus();
      
      widget.onSearch!(
        _userIdController.text.trim(),
        _postIdController.text.trim(),
      );
    }
  }

  void _clearSearch() {
    print("🧹 MobileSearchSection: Clearing search fields");
    setState(() {
      _userIdController.clear();
      _postIdController.clear();
    });
    
    if (widget.onClearSearch != null) {
      widget.onClearSearch!();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8, bottom: 12, top: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User ID Search Field
            Stack(
              children: [
                CustomSearchBar(
                  controller: _userIdController,
                  focusNode: _userIdFocusNode,
                  hinttxt: "Search by User ID", 
                  icon: Icons.person,
                  enabled: !widget.isLoading,
                  onChanged: (value) {
                    print("🔍 MobileSearchSection: User ID changed to: '$value'");
                    setState(() {});
                  },
                  onSubmitted: (_) => _performSearch(),
                  keyboardType: TextInputType.number,
                  //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                // Clear button overlay for user ID field
                if (_userIdController.text.isNotEmpty)
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: widget.isLoading 
                            ? null 
                            : () {
                                print("🧹 MobileSearchSection: Clearing User ID field");
                                setState(() => _userIdController.clear());
                              },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.clear,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 10),
            
            // Post ID Search Field
            Stack(
              children: [
                CustomSearchBar(
                  controller: _postIdController,
                  focusNode: _postIdFocusNode,
                  hinttxt: "Search by Post ID", 
                  icon: Icons.article,
                  enabled: !widget.isLoading,
                  onChanged: (value) {
                    print("🔍 MobileSearchSection: Post ID changed to: '$value'");
                    setState(() {});
                  },
                  onSubmitted: (_) => _performSearch(),
                  keyboardType: TextInputType.number,
                  //inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                // Clear button overlay for post ID field
                if (_postIdController.text.isNotEmpty)
                  Positioned(
                    right: 8,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: GestureDetector(
                        onTap: widget.isLoading 
                            ? null 
                            : () {
                                print("🧹 MobileSearchSection: Clearing Post ID field");
                                setState(() => _postIdController.clear());
                              },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade300,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.clear,
                            size: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),
            
            Center(
              child: SearchButton(
                height: 50,
                width: 180,
                onPressed: widget.isLoading ? null : _performSearch,
                isLoading: widget.isLoading,
              ),
            ),
            
            if (_hasSearchText && !widget.isLoading)
              Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Center(
                  child: TextButton.icon(
                    onPressed: _clearSearch,
                    icon: const Icon(Icons.refresh, size: 18),
                    label: const Text('Clear Search'),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.grey.shade600,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}