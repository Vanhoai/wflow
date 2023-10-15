import 'package:flutter/material.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/them.dart';
import 'package:wflow/core/widgets/custom/custom.dart';

class HeaderAvatarCompanyWidget extends StatefulWidget {
  const HeaderAvatarCompanyWidget({super.key});

  @override
  State<HeaderAvatarCompanyWidget> createState() => _HeaderAvatarCompanyWidgetState();
}

class _HeaderAvatarCompanyWidgetState extends State<HeaderAvatarCompanyWidget> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 260,
        child: Stack(
          children: [
            ClipRRect(
              child: SizedBox(
                height: 220,
                width: MediaQuery.of(context).size.width,
                child: Image.network(
                  'https://images.pexels.com/photos/9663326/pexels-photo-9663326.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: 38,
                      backgroundImage: NetworkImage(
                        'https://images.pexels.com/photos/9663326/pexels-photo-9663326.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Google (25 employees)',
                        style: themeData.textTheme.displayLarge!.merge(
                          const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          PrimaryButton(
                            label: 'Add',
                            onPressed: () {},
                            width: 85,
                            height: 30,
                          ),
                          const SizedBox(width: 10),
                          PrimaryButton(
                            label: 'Chat',
                            onPressed: () => Navigator.of(context).pushNamed(RouteKeys.chatBusinessScreen),
                            width: 85,
                            height: 30,
                          ),
                        ],
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
