import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:wflow/common/injection.dart';
import 'package:wflow/common/localization.dart';
import 'package:wflow/core/widgets/shared/shared.dart';
import 'package:wflow/modules/main/domain/user/entities/notification_entity.dart';
import 'package:wflow/modules/main/domain/user/user_usecase.dart';
import 'package:wflow/modules/main/presentation/personal/notification/bloc/bloc.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return BlocProvider<NotificationBloc>(
      create: (context) => NotificationBloc(userUseCase: instance.call<UserUseCase>())
        ..add(const GetNotification(page: 1, pageSize: 1000)),
      lazy: true,
      child: CommonScaffold(
        isSafe: true,
        appBar: AppBarCenterWidget(
          center: Text(instance.call<AppLocalization>().translate('notification') ?? 'Notification'),
        ),
        body: Builder(builder: (context) {
          return BlocConsumer<NotificationBloc, NotificationState>(
            bloc: BlocProvider.of<NotificationBloc>(context),
            buildWhen: (previous, current) => true,
            listener: (context, state) {},
            listenWhen: (previous, current) => true,
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async => BlocProvider.of<NotificationBloc>(context).add(const RefreshNotification()),
                child: ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemBuilder: (context, index) {
                    final NotificationEntity notification = state.notifications[index];
                    final date = DateFormat('dd/MM/yyyy').format(DateTime.parse(notification.createdAt.toString()));
                    final time = DateFormat('HH:mm:ss').format(DateTime.parse(notification.createdAt.toString()));

                    return Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      elevation: 2,
                      color: themeData.colorScheme.background,
                      surfaceTintColor: themeData.colorScheme.background,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.notifications),
                        title: Text(notification.title),
                        subtitle: Text(notification.body),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(date),
                            Text(time),
                          ],
                        ),
                        onTap: () {},
                        enableFeedback: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                      ),
                    );
                  },
                  itemCount: state.notifications.length,
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
