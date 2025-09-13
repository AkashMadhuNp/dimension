import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dimension_machine_task/core/app_constant.dart';
import 'package:dimension_machine_task/widgets/common/custom_container.dart';

class SearchBartablet extends StatefulWidget {
  final Function(String userId, String postId)? onSearch;
  final bool isLoading;
  final VoidCallback? onClearSearch;

  const SearchBartablet({
    super.key,
    this.onSearch,
    this.isLoading = false,
    this.onClearSearch,
  });

  @override
  State<SearchBartablet> createState() => _SearchBartabletState();
}

class _SearchBartabletState extends State<SearchBartablet> {
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
    print("🔍 SearchBartablet: Performing search with userId: '${_userIdController.text}', postId: '${_postIdController.text}'");
    
    if (widget.onSearch != null && !widget.isLoading) {
      widget.onSearch!(
        _userIdController.text.trim(),
        _postIdController.text.trim(),
      );
    }
  }

  void _clearSearch() {
    print("🧹 SearchBartablet: Clearing search fields");
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
    return Column(
      children: [
        CustomContainer(
          width: MediaQuery.of(context).size.width * 0.6,
          height: MediaQuery.of(context).size.width * 0.10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6 * 0.35,
                  height: 45,
                  child: _buildSearchField(
                    controller: _userIdController,
                    hintText: "Search by User ID...",
                    icon: Icons.person,
                    enabled: !widget.isLoading,
                    onSubmitted: (_) => _performSearch(),
                    keyboardType: TextInputType.number,
                  ),
                ),

                const SizedBox(width: 12),

                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6 * 0.35,
                  height: 45,
                  child: _buildSearchField(
                    controller: _postIdController,
                    hintText: "Search by Post ID...",
                    icon: Icons.article,
                    enabled: !widget.isLoading,
                    onSubmitted: (_) => _performSearch(),
                    keyboardType: TextInputType.number,
                  ),
                ),

                const SizedBox(width: 12),

                SizedBox(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.6 * 0.20,
                  child: _buildSearchButton(),
                )
              ],
            ),
          ),
        ),
        
        if (_hasSearchText && !widget.isLoading) ...[
          const SizedBox(height: 12),
          Center(
            child: TextButton.icon(
              onPressed: _clearSearch,
              icon: const Icon(Icons.refresh, size: 16),
              label: const Text('Clear Search', style: TextStyle(fontSize: 12)),
              style: TextButton.styleFrom(
                foregroundColor: Colors.grey.shade600,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
            ),
          ),
        ],
      ],
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
      decoration: BoxDecoration(
        color: enabled ? Colors.grey[50] : Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        keyboardType: keyboardType,
        inputFormatters: keyboardType == TextInputType.number 
            ? [FilteringTextInputFormatter.digitsOnly]
            : null,
        onSubmitted: onSubmitted,
        onChanged: (value) {
          print("🔍 SearchBartablet: Field ${hintText} changed to: '$value'");
          setState(() {});
        },
        style: const TextStyle(fontSize: 13),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 12),
          suffixIcon: Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon, color: Colors.grey[600], size: 18),
              if (controller.text.isNotEmpty && enabled)
                Positioned(
                  right: 6,
                  child: GestureDetector(
                    onTap: () {
                      print("🧹 SearchBartablet: Clearing field ${hintText}");
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
                        size: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        ),
      ),
    );
  }

  Widget _buildSearchButton() {
    return ElevatedButton(
      onPressed: widget.isLoading ? null : _performSearch,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.isLoading 
            ? Colors.grey[300] 
            : AppConstants.secondaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: widget.isLoading
          ? const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          : const Text(
              "Search",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
    );
  }
}