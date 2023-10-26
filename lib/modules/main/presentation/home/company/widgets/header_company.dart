import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/widgets/custom/circular_avatar_touch/circular_avatar_touch.dart';
import 'package:wflow/modules/main/presentation/home/company/bloc/my_company_bloc.dart';

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
    final ThemeData themeData = Theme.of(context);
    return BlocBuilder<MyCompanyBloc, MyCompanyState>(
      bloc: instance.call<MyCompanyBloc>(),
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              CircularAvatarTouch(
                height: 60,
                width: 60,
                onTap: () {},
                imageUrl: state.companyEntity.logo,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      state.companyEntity.name,
                      style: themeData.textTheme.displayLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
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
              ),
            ],
          ),
        );
      },
    );
  }
}
