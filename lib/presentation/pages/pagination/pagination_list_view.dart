import 'package:flutter/material.dart';

class PaginatedListView<T> extends StatefulWidget {
  const PaginatedListView({
    super.key,
    required this.items,
    required this.hasMore,
    required this.isLoadingMore,
    required this.onLoadMore,
    required this.onRefresh,
    required this.onRetry,
    required this.itemBuilder,
    this.errorMessage,
    this.emptyBuilder,
  });

  final List<T> items;
  final bool hasMore;
  final bool isLoadingMore;
  final String? errorMessage;
  final VoidCallback onLoadMore;
  final VoidCallback onRetry;
  final Future<void> Function() onRefresh;
  final Widget Function(BuildContext context, T item, int index) itemBuilder;
  final WidgetBuilder? emptyBuilder;

  @override
  State<PaginatedListView<T>> createState() => _PaginatedListViewState<T>();
}

class _PaginatedListViewState<T> extends State<PaginatedListView<T>> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onScroll);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Load the next page when the user is within 200px of the bottom
  void _onScroll() {
    final position = _controller.position;
    if (position.pixels >= position.maxScrollExtent - 200) {
      widget.onLoadMore();
    }
  }

  // If the (filtered) list is too short to scroll, keep loading pages
  void _fillIfNeeded() {
    if (!mounted ||
        !widget.hasMore ||
        widget.isLoadingMore ||
        widget.errorMessage != null) {
      return;
    }
    final notScrollable = widget.items.isEmpty ||
        (_controller.hasClients && _controller.position.maxScrollExtent <= 0);
    if (notScrollable) widget.onLoadMore();
  }

  // Lets pull-to-refresh work on non-list content (empty / error views)
  Widget _scrollable(Widget child) {
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: SizedBox(height: 350, child: child),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => _fillIfNeeded());

    // No items to show
    if (widget.items.isEmpty) {
      if (widget.errorMessage != null) {
        return _scrollable(
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: widget.onRetry,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        );
      }
      if (!widget.hasMore) {
        return _scrollable(
          widget.emptyBuilder?.call(context) ??
              const Center(child: Text('No data')),
        );
      }
      // Filters removed everything loaded so far, but more pages exist
      return const Center(child: CircularProgressIndicator());
    }

    // Normal list: items + 1 footer
    return RefreshIndicator(
      onRefresh: widget.onRefresh,
      child: ListView.builder(
        controller: _controller,
        physics: const AlwaysScrollableScrollPhysics(),
        itemCount: widget.items.length + 1,
        itemBuilder: (context, index) {
          if (index < widget.items.length) {
            return widget.itemBuilder(context, widget.items[index], index);
          }

          // Footer
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: widget.errorMessage != null
                  ? TextButton(
                onPressed: widget.onRetry,
                child: const Text('Retry'),
              )
                  : widget.hasMore
                  ? const CircularProgressIndicator()
                  : const Text('No more data'),
            ),
          );
        },
      ),
    );
  }
}