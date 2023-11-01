import 'package:flutter/material.dart';
import 'package:sense_flutter_application/views/store/store_view.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({super.key});

  @override
  State<StoreScreen> createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  @override
  Widget build(BuildContext context) {
    /// empty page
    // return StoreEmptyView();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          top: true,
          bottom: false,
          child: Column(
            children: [
              StoreHeader(),
              Expanded(
                child: SingleChildScrollView(
                  child: StoreContent())),
            ],
          ),
        ),
      ),
    );
  }
}
