import 'package:amirta_mobile/bloc/dashboard/dashboard_bloc.dart';
import 'package:amirta_mobile/bloc/dashboard/panic/latest_panic_bloc.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/ui/home/home_summary_section.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final dateTime = DateTime.now();

  final dateFormat = DateFormat('MMMM y', 'id');

  @override
  Widget build(BuildContext context) {
    final user = context.appProvider().user;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return DashboardBloc(context.appProvider().accountRepository);
        }),
        BlocProvider(create: (context) {
          return LatestPanicBloc(context.appProvider().pengaduanRepository);
        }),
      ],
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              const BottomEllipseContainer(
                child: SizedBox(
                  height: 200,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(spaceBig),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: spaceMedium,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        OfflineContainer(
                          offlineChild: const Icon(
                            Icons.account_circle_rounded,
                            size: 80,
                            color: white,
                          ),
                          child: InkWell(
                            onTap: () async {
                              final _ = await Navigator.pushNamed(
                                  context, Routes.profile);
                              setState(() {});
                            },
                            child: Builder(builder: (context) {
                              final user = context.appProvider().user;
                              if (user?.photo != null &&
                                  user?.photo?.isEmpty == false) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    user!.photo!.photoProfileUrl,
                                    width: 70,
                                    height: 70,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, obj, stacktrace) {
                                      return const Icon(
                                        Icons.account_circle_rounded,
                                        size: 80,
                                        color: white,
                                      );
                                    },
                                  ),
                                );
                              }
                              return const Icon(
                                Icons.account_circle_rounded,
                                size: 80,
                                color: white,
                              );
                            }),
                          ),
                        ),
                        const SizedBox(
                          width: spaceNormal,
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () async {
                              final _ = await Navigator.pushNamed(
                                  context, Routes.profile);
                              setState(() {});
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user?.name ?? '-',
                                  style: context.styleBody1.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                  ),
                                ),
                                Text(
                                  user?.userId ?? '-',
                                  style: context.styleBody1.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: white.withOpacity(0.5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Image.asset(
                            imageRes('ic_notification.png'),
                            height: imgSizeNormal,
                            width: imgSizeNormal,
                            color: white,
                          ),
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.notification);
                          },
                        ),
                      ],
                    ),
                    OfflineContainer(
                      offlineChild: Container(
                        margin: const EdgeInsets.only(top: 120),
                        padding: const EdgeInsets.all(spaceMedium),
                        child: Center(
                          child: Text(
                            'offline_message'.tr(),
                            style: context.styleHeadline6,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      child: _createBody(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createBody(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: spaceMedium,
        ),
        HomeSummarySection(),
        const SizedBox(
          height: spaceBig,
        ),
        Visibility(
          visible: false,
          child: dailySection(context),
          replacement: const Padding(
            padding: EdgeInsets.only(top: spaceBig),
            child:
                SizedBox(), /*Center(
              child: Text(
                'Fitur Info Harian dalam pengembangan',
                style: context.styleBody1.copyWith(
                  color: grease.withOpacity(0.5),
                ),
              ),
            ),*/
          ),
        ),
      ],
    );
  }

  Widget dailySection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Info Harian',
          style: context.styleBody1.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Periksa pembaruan dari setiap menu',
          style: context.styleCaption.copyWith(
            color: grease.withOpacity(0.5),
          ),
        ),
        const SizedBox(
          height: spaceBig,
        ),
        briefItem(
          context: context,
          image: 'ic_panik_info_harian.png',
          title: 'Siti Zubaedah',
          subtitle: 'Jatinegara Barat',
          date: '13:44',
        ),
        const SizedBox(
          height: spaceMedium,
        ),
        briefItem(
          context: context,
          image: 'ic_air_info_harian.png',
          title: 'Jatinegara Kaum',
          subtitle: 'Blok D Nomor 177',
          date: '10:00',
        ),
        const SizedBox(
          height: spaceMedium,
        ),
        briefItem(
          context: context,
          image: 'ic_pengaduan_info_harian.png',
          title: 'Muhammad Ikhsan',
          subtitle: 'Sarpas, Jatinegara Barat',
          date: '13:44',
        ),
      ],
    );
  }

  Widget briefItem({
    required BuildContext context,
    required String image,
    required String title,
    required String subtitle,
    required String date,
  }) {
    return Row(
      children: [
        Image.asset(
          imageRes(image),
          height: 40,
          width: 40,
        ),
        const SizedBox(
          width: spaceMedium,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: context.styleBody1.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: context.styleCaption,
              ),
            ],
          ),
        ),
        Text(
          date,
          style: context.styleCaption,
        ),
      ],
    );
  }
}
