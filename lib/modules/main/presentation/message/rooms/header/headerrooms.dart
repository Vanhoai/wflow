import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:wflow/configuration/constants.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/modules/main/presentation/message/rooms/header/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/message/rooms/header/bloc/event.dart';
import 'package:wflow/modules/main/presentation/message/rooms/header/bloc/state.dart';

class HeaderRooms extends StatefulWidget {
  const HeaderRooms({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HeaderRoomsState();
  }
}

class _HeaderRoomsState extends State<HeaderRooms> {
  FocusNode focusNode = FocusNode();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HeaderRoomsBloc, HeaderRoomState>(
      builder: (context, state) {
        return Material(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.horizontal,
                  child: child,
                );
              },
              child: !state.showSearch
                  ? Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Text(
                            'Message',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            context.read<HeaderRoomsBloc>().add(ShowSearchEvent(show: true));
                          },
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              AppConstants.search,
                              height: 22,
                              width: 22,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        InkWell(
                          onTap: () {},
                          borderRadius: BorderRadius.circular(25),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              AppConstants.moreOutline,
                              height: 22,
                              width: 22,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(
                      child: TextFormField(
                        focusNode: focusNode,
                        autofocus: true,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 1,
                        decoration: InputDecoration(
                          prefixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 2, top: 2, right: 5, left: 5),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: SvgPicture.asset(
                                    AppConstants.search,
                                    height: 20,
                                    width: 20,
                                    colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.srcIn),
                                  ),
                                ),
                              )),
                          suffixIcon: Padding(
                              padding: const EdgeInsets.only(bottom: 2, top: 2, right: 5, left: 5),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(50),
                                child: Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: SvgPicture.asset(
                                    AppConstants.remove,
                                    height: 20,
                                    width: 20,
                                    colorFilter: const ColorFilter.mode(Colors.black26, BlendMode.srcIn),
                                  ),
                                ),
                              )),
                          hintText: 'Tìm kiếm',
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(vertical: -5),
                          hintStyle: Theme.of(context).textTheme.titleLarge,
                          focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.black26, width: 1.0),
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                            borderSide: BorderSide(color: Colors.black26, width: 1.0),
                          ),
                        ),
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}
