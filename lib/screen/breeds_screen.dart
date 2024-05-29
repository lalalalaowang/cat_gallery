import 'package:cat_gallery/http/network_repository.dart';
import 'package:cat_gallery/model/breed.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class BreedsScreen extends StatefulWidget {
  const BreedsScreen({super.key});

  @override
  State<BreedsScreen> createState() => _BreedsScreenState();
}

class _BreedsScreenState extends State<BreedsScreen> {
  final List<Breed> _breeds = [];
  @override
  void initState() {
    _init();
    super.initState();
  }

  void _init() async {
    final repository = NetworkRepository();
    final List<Breed> breeds = await repository.getBreeds(limit: 20, page: 0);
    setState(() {
      _breeds.addAll(breeds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("品种"),
        ),
        body: MasonryGridView.count(
            crossAxisCount: 2,
            itemCount: _breeds.length,
            itemBuilder: (context, index) {
              return _buildBreedItem(_breeds[index]);
            }));
  }

  Widget _buildBreedItem(Breed breed) {
    return Column(
      children: [
        Image.network(breed.image.url),
        _buildBreedName(breed.name),
        _buildIntro(breed.description),
      ],
    );
  }

  Widget _buildBreedName(String name) {
    return Text(name);
  }

  Widget _buildIntro(String intro) {
    return Text(intro);
  }
}
