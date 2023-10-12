import 'package:flutter/material.dart';

class HeaderAvatarWidget extends StatefulWidget {
  const HeaderAvatarWidget({super.key});

  @override
  State<HeaderAvatarWidget> createState() => _HeaderAvatarWidgetState();
}

class _HeaderAvatarWidgetState extends State<HeaderAvatarWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.only(top: 13, left: 20, right: 20),
      sliver: SliverToBoxAdapter(
        child: SizedBox(
          height: 230,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 180,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    'https://picsum.photos/200/300',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    radius: 48,
                    backgroundImage: NetworkImage(
                      'https://picsum.photos/200/300',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
