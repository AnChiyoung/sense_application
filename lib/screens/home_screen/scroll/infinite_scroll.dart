import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class InfiniteScroll extends StatefulWidget {
  final bool isLoading;
  final Widget child;
  final Future<void> Function() onFetchData;
  final Function(bool isShow) onScroll;
  const InfiniteScroll(
      {super.key,
      required this.child,
      required this.onFetchData,
      this.isLoading = false,
      required this.onScroll});

  @override
  State<InfiniteScroll> createState() => _InfiniteScrollState();
}

class _InfiniteScrollState extends State<InfiniteScroll> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    // _fetchData();
  }

  @override
  dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.outOfRange &&
        _scrollController.position.userScrollDirection == ScrollDirection.reverse) {
      _fetchData();
    }

    if (!widget.isLoading) {
      widget.onScroll(_scrollController.position.userScrollDirection == ScrollDirection.forward);
    }
  }

  Future<void> _fetchData() async {
    if (!widget.isLoading) {
      await widget.onFetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            widget.child,
            if (widget.isLoading) const CircularProgressIndicator(),
          ],
        ));
  }
}
