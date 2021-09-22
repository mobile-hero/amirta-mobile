import 'package:amirta_mobile/bloc/notification/notification_bloc.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class NotificationScreen extends StatefulWidget {
  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final PagingController<int, String> _pagingController =
      PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.appendLastPage([
      'satu',
      'dua',
      'tiga',
    ]);
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
          title: Text("Notifikasi"),
          centerTitle: true,
        ),
        body: BlocBuilder<NotificationBloc, NotificationState>(
            builder: (context, state) {
          return PagedListView<int, String>(
            padding: const EdgeInsets.all(spaceMedium),
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (context, item, position) {
                return Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: imgSizeMedium,
                          height: imgSizeMedium,
                          padding: const EdgeInsets.all(spaceSmall),
                          child: Image.asset(
                            imageRes('ic_notification.png'),
                            color: position / ~2 == 0 ? carrot : white,
                          ),
                          decoration: BoxDecoration(
                            color: carrot
                                .withOpacity(position / ~2 == 0 ? 0.2 : 1.0),
                            borderRadius: BorderRadius.circular(buttonRadius),
                          ),
                        ),
                        const SizedBox(
                          width: spaceMedium,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pembaharuan Aplikasi',
                                style: context.styleBody1.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.fade,
                              ),
                              Text(
                                'Segera update aplikasi Anda',
                                style: context.styleCaption,
                                overflow: TextOverflow.fade,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: spaceMedium,
                        ),
                        Text(
                          '11:20',
                          style: context.styleCaption,
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
                  child: Text("Anda tidak memiliki notifikasi"),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
