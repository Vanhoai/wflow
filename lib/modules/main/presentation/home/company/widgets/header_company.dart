import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class HeaderAvatarCompanyWidget extends StatefulWidget {
  const HeaderAvatarCompanyWidget({super.key});

  @override
  State<HeaderAvatarCompanyWidget> createState() => _HeaderAvatarCompanyWidgetState();
}

class _HeaderAvatarCompanyWidgetState extends State<HeaderAvatarCompanyWidget> {
  final List<String> members = [
    'https://images.pexels.com/photos/9663326/pexels-photo-9663326.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/9663326/pexels-photo-9663326.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/9663326/pexels-photo-9663326.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/9663326/pexels-photo-9663326.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/9663326/pexels-photo-9663326.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/9663326/pexels-photo-9663326.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/9663326/pexels-photo-9663326.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
    'https://images.pexels.com/photos/9663326/pexels-photo-9663326.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          const ClipRRect(
            child: CircleAvatar(
              radius: 60,
              backgroundImage: CachedNetworkImageProvider(
                'https://images.pexels.com/photos/9663326/pexels-photo-9663326.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
              ),
            ),
          ),
          const SizedBox(height: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'company@gmail.com',
                style: Theme.of(context).textTheme.displayMedium,
              ),
              Text(
                '25 member',
                style: Theme.of(context).textTheme.labelMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: members.asMap().entries.map((e) {
                  final key = e.key * -1.0;

                  return Container(
                    transform: Matrix4.translationValues(12 * key, 0, 0),
                    child: const CircleAvatar(
                      radius: 16,
                      backgroundImage: CachedNetworkImageProvider(
                        'https://images.pexels.com/photos/9663326/pexels-photo-9663326.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
