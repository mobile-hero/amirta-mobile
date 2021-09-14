import 'package:amirta_mobile/bloc/dashboard/dashboard_bloc.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:amirta_mobile/res/view/bottom_ellipse_container.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final dateTime = DateTime.now();
  final dateFormat = DateFormat("MMMM y", "id");

  @override
  Widget build(BuildContext context) {
    final user = context.appProvider().user;
    return BlocProvider(
      create: (context) {
        return DashboardBloc(context.appProvider().accountRepository);
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              BottomEllipseContainer(
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
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/profile');
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              "https://img.icons8.com/bubbles/2x/user.png",
                              width: 80,
                              height: 80,
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/profile');
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  user?.name ?? "-",
                                  style: context.styleBody1.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: white,
                                  ),
                                ),
                                Text(
                                  user?.userId ?? "-",
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
                            Navigator.pushNamed(context, '/notification');
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: spaceMedium,
                    ),
                    BlocBuilder<DashboardBloc, DashboardState>(
                        builder: (context, state) {
                      if (state is DashboardLoading) {
                        return MyProgressIndicator();
                      }
                      if (state is DashboardSuccess) {
                        return Column(
                          children: [
                            ShadowedContainer(
                              padding: const EdgeInsets.all(spaceNormal),
                              borderRadius: buttonRadius,
                              child: Row(
                                children: [
                                  Image.asset(
                                    imageRes('ic_panik_info_harian.png'),
                                    height: 30,
                                    width: 30,
                                  ),
                                  const SizedBox(
                                    width: spaceMedium,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Halim Baskoro',
                                          style:
                                              context.styleBody1.copyWith(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          'Jatinegara Barat',
                                          style: context.styleCaption,
                                        ),
                                        const SizedBox(
                                          height: spaceMedium,
                                        ),
                                        Text(
                                          '10 April 2021 | 13:44',
                                          style: context.styleCaption,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Text(
                                        state.dashboard.totalPanicButton
                                            .toString(),
                                        style: context.styleHeadline1.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: spaceTiny,
                                      ),
                                      Text(
                                        'Data Panik',
                                        style: context.styleCaption,
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: spaceMedium,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: ShadowedContainer(
                                    padding: const EdgeInsets.all(spaceNormal),
                                    borderRadius: buttonRadius,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          imageRes('ic_pengaduan_info_harian.png'),
                                          height: 30,
                                          width: 30,
                                        ),
                                        const SizedBox(
                                          width: spaceMedium,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.dashboard.totalComplaint
                                                    .toString(),
                                                style: context.styleHeadline4
                                                    .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: spaceTiny,
                                              ),
                                              Text(
                                                'Pengaduan',
                                                style: context.styleCaption,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: spaceMedium,
                                ),
                                Expanded(
                                  child: ShadowedContainer(
                                    padding: const EdgeInsets.all(spaceNormal),
                                    borderRadius: buttonRadius,
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          imageRes('ic_air_info_harian.png'),
                                          height: 30,
                                          width: 30,
                                        ),
                                        const SizedBox(
                                          width: spaceMedium,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                state.dashboard
                                                    .totalUncollectedMeterPdam
                                                    .toString(),
                                                style: context.styleHeadline4
                                                    .copyWith(
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: spaceTiny,
                                              ),
                                              Text(
                                                'Air ${dateFormat.format(dateTime)}',
                                                style: context.styleCaption,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        );
                      }

                      return Center(
                        child: Text("Gagal Mengambil Data Dashboard"),
                      );
                    }),
                    const SizedBox(
                      height: spaceBig,
                    ),
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
                ),
              ),
            ],
          ),
        ),
      ),
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
