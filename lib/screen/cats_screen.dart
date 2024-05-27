import 'package:cat_gallery/http/network_repository.dart';
import 'package:cat_gallery/model/dog_image.dart';
import 'package:flutter/material.dart';

class CatsScreen extends StatefulWidget {
  const CatsScreen({super.key});

  @override
  State<CatsScreen> createState() => _CatsScreenState();
}

class _CatsScreenState extends State<CatsScreen> {
  DogImage? dogImage;

  @override
  void initState() {
    init();
    super.initState();
  }

  void init() async {
    NetworkRepository repository = NetworkRepository();
    List<DogImage> result = await repository.searchImages(limit: 1);
    if (result.isNotEmpty) {
      setState(() {
        dogImage = result.first;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("首页"),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (dogImage != null) _buildImage(dogImage!.url),
            Row(
              children: [
                _buildIconButton(icon: "favorate.png", onPressed: () {}),
                const Spacer(),
                _buildIconButton(icon: "like.png", onPressed: () {}),
                _buildIconButton(icon: "unlike.png", onPressed: () {}),
              ],
            )
          ],
        ),
      ),
    );
  }
}

Widget _buildImage(String url) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(8),
    child: Image.network(
      url,
      fit: BoxFit.cover,
    ),
  );
}

Widget _buildIconButton(
    {required String icon, required VoidCallback onPressed}) {
  const iconSize = 25.0;
  return IconButton(
    onPressed: onPressed,
    icon: Image.asset(
      "images/$icon",
      width: iconSize,
      height: iconSize,
    ),
  );
}
