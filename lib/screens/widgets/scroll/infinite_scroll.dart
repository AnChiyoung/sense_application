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
  }

  @override
  dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.outOfRange ||
        _scrollController.position.pixels >= _scrollController.position.maxScrollExtent) {
      _fetchData();
    }

    // if (!widget.isLoading) {
    //   widget.onScroll(_scrollController.position.userScrollDirection == ScrollDirection.forward);
    // }
  }

  Future<void> _fetchData() async {
    if (!widget.isLoading) {
      await widget.onFetchData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragStart: (details) => {widget.onScroll(false)},
      onVerticalDragUpdate: (details) {
        // Calculate the new position immediately in response to the drag.
        double scale = 2.0; // This scale factor can be adjusted to control sensitivity
        double newPosition = _scrollController.position.pixels - details.primaryDelta! * scale;
        _scrollController
            .jumpTo(newPosition.clamp(0.0, _scrollController.position.maxScrollExtent));
      },
      onVerticalDragEnd: (details) {
        // When the drag ends, we apply some additional inertia
        double velocity =
            details.primaryVelocity! * 0.2; // Adjust the multiplier to control the inertia effect
        double targetPosition = _scrollController.position.pixels - velocity;

        if (targetPosition < 0 || targetPosition > _scrollController.position.maxScrollExtent) {
          // If the target position is out of range, use a bounce effect.
          targetPosition = targetPosition.clamp(0.0, _scrollController.position.maxScrollExtent);
        }

        _scrollController.animateTo(
          targetPosition,
          duration:
              const Duration(milliseconds: 500), // Adjust timing to simulate natural deceleration
          curve: Curves.decelerate, // This curve gives a natural "slow down" effect
        );

        widget.onScroll(true);
      },
      child: SingleChildScrollView(
          controller: _scrollController,
          physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
          child: Column(
            children: [
              widget.child,
              if (widget.isLoading)
                const Padding(
                  padding: EdgeInsets.only(top: 16, bottom: 16),
                  child: CircularProgressIndicator(),
                ),
            ],
          )),
    );
  }
}
