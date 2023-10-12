import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/core/routes/keys.dart';
import 'package:wflow/core/theme/colors.dart';
import 'package:wflow/core/utils/time.util.dart';
import 'package:wflow/core/widgets/style/textfieldstyle.dart';
import 'package:wflow/modules/main/presentation/message/rooms/header/bloc/bloc.dart';
import 'package:wflow/modules/main/presentation/message/rooms/header/bloc/event.dart';

class Room {
  final String image;
  final String name;
  final String lastMessage;
  final String createAt;

  Room({required this.image, required this.name, required this.lastMessage, required this.createAt});
}

List<Room> Data = [
  Room(
      image: "https://thanhlapdoanhnghiepvn.vn/wp-content/uploads/2018/08/c8727ed17ccbc2050a29c97fa9215ae0.jpeg",
      name: "FPT telecome",
      lastMessage: "Xin chao?",
      createAt: DateTime.now().toString()),
  Room(
      image: "https://upload.wikimedia.org/wikipedia/commons/4/44/210604_%EA%B3%A0%EC%9C%A4%EC%A0%95%282%29.jpg",
      name: "KHỐI CÔNG NGHỆ THÔNG TIN - VIETTEL TELECOM",
      lastMessage: "Xin chao?",
      createAt: DateTime.now().toString()),
  Room(
      image: "https://upload.wikimedia.org/wikipedia/commons/4/44/210604_%EA%B3%A0%EC%9C%A4%EC%A0%95%282%29.jpg",
      name: "FPT telecome",
      lastMessage: "Xin chao? Cái ngành này trong éo ổn lắm cậu nhỉ? Hay là mình lấy vợ giàu",
      createAt: DateTime.now().toString()),
  Room(
      image: "https://upload.wikimedia.org/wikipedia/commons/4/44/210604_%EA%B3%A0%EC%9C%A4%EC%A0%95%282%29.jpg",
      name: "FPT telecome aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaâ",
      lastMessage: "Xin chao?",
      createAt: DateTime.now().toString()),
  Room(
      image: "https://upload.wikimedia.org/wikipedia/commons/4/44/210604_%EA%B3%A0%EC%9C%A4%EC%A0%95%282%29.jpg",
      name: "FPT telecome",
      lastMessage: "Xin chao?",
      createAt: DateTime.now().toString()),
  Room(
      image: "https://upload.wikimedia.org/wikipedia/commons/4/44/210604_%EA%B3%A0%EC%9C%A4%EC%A0%95%282%29.jpg",
      name: "FPT telecome",
      lastMessage: "Xin chao?",
      createAt: DateTime.now().toString()),
  Room(
      image: "https://upload.wikimedia.org/wikipedia/commons/4/44/210604_%EA%B3%A0%EC%9C%A4%EC%A0%95%282%29.jpg",
      name: "FPT telecome",
      lastMessage: "Xin chao?",
      createAt: DateTime.now().toString()),
  Room(
      image: "https://upload.wikimedia.org/wikipedia/commons/4/44/210604_%EA%B3%A0%EC%9C%A4%EC%A0%95%282%29.jpg",
      name: "FPT telecome",
      lastMessage: "Xin chao?",
      createAt: DateTime.now().toString()),
  Room(
      image: "https://upload.wikimedia.org/wikipedia/commons/4/44/210604_%EA%B3%A0%EC%9C%A4%EC%A0%95%282%29.jpg",
      name: "FPT telecome",
      lastMessage: "Xin chao?",
      createAt: DateTime.now().toString()),
  Room(
      image: "https://upload.wikimedia.org/wikipedia/commons/4/44/210604_%EA%B3%A0%EC%9C%A4%EC%A0%95%282%29.jpg",
      name: "FPT telecome",
      lastMessage: "Xin chao?",
      createAt: DateTime.now().toString()),
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
    return Listener(
        onPointerDown: (PointerDownEvent event) {
          FocusManager.instance.primaryFocus?.unfocus();
          if (!context.read<HeaderRoomsBloc>().state.showSearch) return;
          context.read<HeaderRoomsBloc>().add(ShowSearchEvent(show: false));
        },
        child: ListView.builder(
            itemCount: Data.length,
            itemBuilder: (context, index) {
              return _room(Data[index]);
            }));
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
                      style: textTitle(size: 18, fontWeight: FontWeight.w500),
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
                            style: textTitle(size: 14, fontWeight: FontWeight.w400, colors: AppColors.fadeText),
                          ),
                        ),
                      ),
                      Text(
                        instance.get<Time>().getHourMinute(room.createAt),
                        overflow: TextOverflow.ellipsis,
                        style: textTitle(size: 12, fontWeight: FontWeight.w400, colors: AppColors.fadeText),
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
