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
          height: 260,
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 210,
                  width: MediaQuery.of(context).size.width,
                  child: Image.network(
                    'https://images.pexels.com/photos/9663326/pexels-photo-9663326.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
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
                      'https://images.pexels.com/photos/9663326/pexels-photo-9663326.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
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
