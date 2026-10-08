class PageResult<T> {
  const PageResult({
    required this.items,
    required this.cursor, // opaque: DocumentSnapshot, int offset, etc.
    required this.hasMore,
  });

  final List<T> items;
  final Object? cursor;
  final bool hasMore;
}