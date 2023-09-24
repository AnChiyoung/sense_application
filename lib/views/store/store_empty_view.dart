import 'package:flutter/material.dart';

/// empty page
class StoreEmptyView extends StatefulWidget {
  const StoreEmptyView({super.key});

  @override
  State<StoreEmptyView> createState() => _StoreEmptyViewState();
}

class _StoreEmptyViewState extends State<StoreEmptyView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Container(
                child: Center(
                    child: Image.asset('assets/public/loading_logo_image.png', width: 200)
                )
            )
        )
    );
  }
}