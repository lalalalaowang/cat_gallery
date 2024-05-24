import 'package:flutter/material.dart';

class CatsScreen extends StatefulWidget {
  const CatsScreen({super.key});

  @override
  State<CatsScreen> createState() => _CatsScreenState();
}

class _CatsScreenState extends State<CatsScreen> {
  String? imgUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("首页"),
      ),
      body: Column(
        children: [
          if (imgUrl != null) _buildImage(imgUrl!),
          Row(
            _buildIconButton(
              icon: "favorate.png",
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildImage(String url) {
  return Image.network(url);
}

Widget _buildIconButton({required String icon, required VoidCallback onTap}) {
  return IconButton(onPressed: onTap, icon: Image.asset("images/$icon"));
}
