import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:dimension_machine_task/widgets/common/custom_container.dart';

class DesktopSearchSection extends StatefulWidget {
  final Function(String userId, String postId)? onSearch;
  final bool isLoading;
  final VoidCallback? onClearSearch;

  const DesktopSearchSection({
    super.key,
    this.onSearch,
    this.isLoading = false,
    this.onClearSearch,
  });

  @override
  State<DesktopSearchSection> createState() => _DesktopSearchSectionState();
}

class _DesktopSearchSectionState extends State<DesktopSearchSection> {
  final TextEditingController _userIdController = TextEditingController();
  final TextEditingController _postIdController = TextEditingController();

  bool get _hasSearchText => 
      _userIdController.text.trim().isNotEmpty || 
      _postIdController.text.trim().isNotEmpty;

  @override
  void dispose() {
    _userIdController.dispose();
    _postIdController.dispose();
    super.dispose();
  }

  void _performSearch() {
    print("🔍 DesktopSearchSection: Performing search with userId: '${_userIdController.text}', postId: '${_postIdController.text}'");
    
    if (widget.onSearch != null && !widget.isLoading) {
      widget.onSearch!(
        _userIdController.text.trim(),
        _postIdController.text.trim(),
      );
    }
  }

  void _clearSearch() {
    print("🧹 DesktopSearchSection: Clearing search fields");
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
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: _buildSearchField(
                    controller: _userIdController,
                    hintText: "Search by User ID...",
                    icon: Icons.person,
                    enabled: !widget.isLoading,
                    onSubmitted: (_) => _performSearch(),
                    keyboardType: TextInputType.number,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                Expanded(
                  flex: 2,
                  child: _buildSearchField(
                    controller: _postIdController,
                    hintText: "Search by Post ID...",
                    icon: Icons.article,
                    enabled: !widget.isLoading,
                    onSubmitted: (_) => _performSearch(),
                    keyboardType: TextInputType.number,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                _buildSearchButton(),
              ],
            ),
            
            if (_hasSearchText && !widget.isLoading) ...[
              const SizedBox(height: 16),
              Center(
                child: TextButton.icon(
                  onPressed: _clearSearch,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Clear Search'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool enabled = true,
    Function(String)? onSubmitted,
    TextInputType? keyboardType,
  }) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: enabled ? Colors.grey[50] : Colors.grey[100],
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        // Only apply number filter for number inputs
        inputFormatters: keyboardType == TextInputType.number 
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        onSubmitted: onSubmitted,
        onChanged: (value) {
          print("🔍 DesktopSearchSection: Field ${hintText} changed to: '$value'");
          setState(() {});
        },
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 14),
          suffixIcon: Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon, color: Colors.grey[600], size: 20),
              if (controller.text.isNotEmpty && enabled)
                Positioned(
                  right: 8,
                  child: GestureDetector(
                    onTap: () {
                      print("🧹 DesktopSearchSection: Clearing field ${hintText}");
                      setState(() => controller.clear());
                    },
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.clear,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: widget.isLoading ? null : _performSearch,
        style: ElevatedButton.styleFrom(
          backgroundColor: widget.isLoading 
              ? Colors.grey[300] 
              : AppConstants.secondaryColor,
          foregroundColor: Colors.white,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
        ),
        child: widget.isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : const Text(
                "Search",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
      ),
    );
  }
}