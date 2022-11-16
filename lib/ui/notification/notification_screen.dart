import 'package:amirta_mobile/bloc/notification/notification_bloc.dart';
import 'package:amirta_mobile/data/account/user_notification.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        return NotificationBloc(context.appProvider().accountRepository)
          ..add(LoadNotification());
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('title_notification'.tr()),
          centerTitle: true,
        ),
        body: OfflineContainer(
          child: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
              return PagedListView<int, UserNotification>(
                padding: const EdgeInsets.all(spaceMedium),
                pagingController:
                    context.read<NotificationBloc>().pagingController,
                builderDelegate: PagedChildBuilderDelegate(
                  itemBuilder: (context, item, position) {
                    const unread = false;
                    return Column(
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: imgSizeMedium,
                              height: imgSizeMedium,
                              padding: const EdgeInsets.all(spaceSmall),
                              child: Image.asset(
                                imageRes('ic_notification.png'),
                                color: unread ? carrot : white,
                              ),
                              decoration: BoxDecoration(
                                color: carrot.withOpacity(unread ? 0.2 : 1.0),
                                borderRadius:
                                    BorderRadius.circular(buttonRadius),
                              ),
                            ),
                            const SizedBox(
                              width: spaceMedium,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          item.title,
                                          style: context.styleBody1.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          overflow: TextOverflow.fade,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: spaceMedium,
                                      ),
                                      Text(
                                        item.sendTimeFormatted,
                                        style: context.styleCaption,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: spaceSmall,
                                  ),
                                  Text(
                                    item.message,
                                    style: context.styleCaption
                                        .copyWith(height: 1.5),
                                    overflow: TextOverflow.fade,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: spaceBig,
                        ),
                      ],
                    );
                  },
                  noItemsFoundIndicatorBuilder: (context) {
                    return Center(
                      child: Text('txt_notification_empty'.tr()),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
