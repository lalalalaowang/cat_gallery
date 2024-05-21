import 'package:flutter/material.dart';

class BreedsScreen extends StatefulWidget {
  const BreedsScreen({super.key});

  @override
  State<BreedsScreen> createState() => _BreedsScreenState();
}

class _BreedsScreenState extends State<BreedsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("breeds"),
    );
  }
}
