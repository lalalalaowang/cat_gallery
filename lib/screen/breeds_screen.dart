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
  int _pageNumber = 1;
  final _pageSize = 10;
  final List<Breed> _breeds = [];
  final _scrollContorller = ScrollController();

  bool _isRefreshing = false;
  bool _isLoadingMore = false;
  bool _hasMore = true;

  @override
  void initState() {
    _init();
    _scrollContorller.addListener(() {
      if (_scrollContorller.position.pixels ==
          _scrollContorller.position.maxScrollExtent) _loadingMore();
    });
    super.initState();
  }

  void _init() async {
    final repository = NetworkRepository();
    final List<Breed> breeds =
        await repository.getBreeds(limit: _pageSize, page: _pageNumber);
    setState(() {
      _breeds.addAll(breeds);
    });
  }

  Future<void> _loadingMore() async {
    if (_isRefreshing || _isLoadingMore || !_hasMore) return;
    final respository = NetworkRepository();
    setState(() {
      _isLoadingMore = true;
    });
    final breeds =
        await respository.getBreeds(limit: _pageSize, page: _pageNumber + 1);
    setState(() {
      _isLoadingMore = false;
      _breeds.addAll(breeds);
      _pageNumber++;
      _hasMore = _pageSize == breeds.length;
    });
  }

  Future<void> _onFresh() async {
    if (_isRefreshing || _isLoadingMore) return;
    final repository = NetworkRepository();
    setState(() {
      _isRefreshing = true;
    });
    final breeds = await repository.getBreeds(limit: _pageSize, page: 1);
    setState(() {
      _breeds.clear();
      _breeds.addAll(breeds);
      _isRefreshing = false;
      _pageNumber = 1;
      if (!_hasMore) _hasMore = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("品种"),
        ),
        body: _buildBreedGrid());
  }

  Widget _buildBreedGrid() {
    return RefreshIndicator(
      onRefresh: _onFresh,
      child: Column(
        children: [
          Expanded(
            child: MasonryGridView.count(
                crossAxisCount: 2,
                itemCount: _breeds.length,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                controller: _scrollContorller,
                itemBuilder: (context, index) {
                  return _buildBreedItem(_breeds[index]);
                }),
          ),
          if (_isLoadingMore)
            Container(
                height: 80,
                alignment: Alignment.center,
                child: const Text("加载中...")),
          if (!_hasMore)
            Container(
                height: 80,
                alignment: Alignment.center,
                child: const Text("到底了哦")),
        ],
      ),
    );
  }

  Widget _buildBreedItem(Breed breed) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (breed.image != null) _buildImage(breed.image!.url),
          const SizedBox(height: 5),
          _buildBreedName(breed.name),
          _buildIntro(breed.temperament ?? ""),
        ],
      ),
    );
  }

  Widget _buildImage(String url) {
    return ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(4)),
        child: Stack(children: [
          Image.network(url),
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
                icon: Image.asset(
                  "images/favorate.png",
                  width: 18,
                  height: 18,
                ),
                onPressed: () {}),
          ),
        ]));
  }

  Widget _buildBreedName(String name) {
    return Text(
      name,
      style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
    );
  }

  Widget _buildIntro(String intro) {
    return Text(intro);
  }
}
