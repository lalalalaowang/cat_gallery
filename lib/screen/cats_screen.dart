import 'package:cat_gallery/http/network_repository.dart';
import 'package:cat_gallery/model/dog_image.dart';
import 'package:cat_gallery/widget/loading_dialog.dart';
import 'package:cat_gallery/widget/tips_dialog.dart';
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

  void _switchToNextImg() async {
    NetworkRepository repository = NetworkRepository();
    _showLoadingDialog();
    List<DogImage> result = await repository.searchImages(limit: 1);
    _hideDialog();
    if (result.isNotEmpty) {
      setState(() {
        dogImage = result.first;
      });
    }
  }

  void _addToFavorites(String imgId) async {
    final repository = NetworkRepository();
    _showLoadingDialog();
    final result = await repository.addToFavorites(imgId: imgId);
    _hideDialog();
    if (result) {
      _showTips("收藏成功");
      _switchToNextImg();
    } else {
      _showTips("收藏失败");
    }
  }

  void _voteImg(String imgId, bool value) async {
    final repository = NetworkRepository();
    _showLoadingDialog();
    final result = await repository.voteImg(imgId: imgId, value: value);
    _hideDialog();

    if (result) {
      _showTips(value ? "点赞成功" : "点赞失败");
      _switchToNextImg();
    } else {
      _showTips("操作失败");
    }
  }

  void _showTips(String content) {
    showDialog(
        context: context,
        builder: (context) {
          return TipsDialog(content: content);
        });
  }

  void _showLoadingDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return const LoadingDialog();
        });
  }

  void _hideDialog() {
    Navigator.of(context).pop();
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
                _buildIconButton(
                    icon: "favorate.png",
                    onPressed: () {
                      _addToFavorites(dogImage!.id);
                    }),
                const Spacer(),
                _buildIconButton(
                    icon: "like.png",
                    onPressed: () {
                      _voteImg(dogImage!.id, true);
                    }),
                _buildIconButton(
                    icon: "unlike.png",
                    onPressed: () {
                      _voteImg(dogImage!.id, false);
                    }),
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
