import 'package:flutter/material.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/utils/time.util.dart';

class Room {
  final String image;
  final String name;
  final String lastMessage;
  final String createAt;

  Room({required this.image, required this.name, required this.lastMessage, required this.createAt});
}

List<Room> data = [
  Room(
    image:
        'https://images.pexels.com/photos/18070630/pexels-photo-18070630/free-photo-of-tuy-t-hoang-hon-th-i-trang-b-bi-n.jpeg?auto=compress&cs=tinysrgb&w=1600&lazy=load',
    name: 'Trần Văn Hoài',
    lastMessage: 'Nay đi chơi không mậy ??',
    createAt: DateTime.now().toString(),
  ),
];

class ListRoom extends StatefulWidget {
  const ListRoom({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ListRoomState();
  }
}

class _ListRoomState extends State<ListRoom> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        return _room(data[index]);
      },
    );
  }

  Widget _room(Room room) {
    return InkWell(
      onTap: () {
        print(room.name);
        Navigator.of(context).pushNamed(RouteKeys.messageScreen);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          children: [
            ClipOval(
                child: Image.network(
              room.image,
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
                      room.name,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge,
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
                            room.lastMessage,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                      Text(
                        instance.get<Time>().getHourMinute(room.createAt),
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
