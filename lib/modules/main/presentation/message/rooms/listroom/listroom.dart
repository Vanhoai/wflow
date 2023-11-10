import 'package:flutter/material.dart';
import 'package:wflow/common/app/bloc.app.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/arguments_model/arguments_message.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/utils/time.util.dart';
import 'package:wflow/modules/main/domain/room/entities/room_entity.dart';
import 'package:wflow/modules/main/domain/user/entities/user_entity.dart';

class ListRoom extends StatefulWidget {
  const ListRoom({super.key, required this.listRoom});
  final List<RoomEntity> listRoom;
  @override
  State<StatefulWidget> createState() {
    return _ListRoomState();
  }
}

class _ListRoomState extends State<ListRoom> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listRoom.length,
      itemBuilder: (context, index) {
        return _room(widget.listRoom[index]);
      },
    );
  }

  Widget _room(RoomEntity room) {
    UserEntity userEntity =
        room.userCreator.id == instance.get<AppBloc>().state.userEntity.id ? room.userClient : room.userCreator;
    return InkWell(
      onTap: () {
        ArgumentsMessage argumentsMessage = ArgumentsMessage(id: room.id, userEntity: userEntity);
        Navigator.of(context).pushNamed(RouteKeys.messageScreen, arguments: argumentsMessage);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          children: [
            ClipOval(
                child: Image.network(
              userEntity.avatar.isEmpty
                  ? 'https://vtv1.mediacdn.vn/zoom/640_400/2022/3/4/avatar-jake-neytiri-pandora-ocean-1646372078251163431014-crop-16463720830272075805905.jpg'
                  : userEntity.avatar,
              fit: BoxFit.cover,
              width: 58.0,
              height: 58.0,
            )),
            const SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.7,
                    child: Text(
                      userEntity.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: FractionallySizedBox(
                          alignment: Alignment.centerLeft,
                          widthFactor: 0.7,
                          child: Text(
                            room.messages[0].message,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ),
                      Text(
                        instance.get<Time>().getHourMinute(room.messages[0].createdAt.toString()),
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.textGrey),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
