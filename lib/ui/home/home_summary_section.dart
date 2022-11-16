import 'package:amirta_mobile/bloc/dashboard/dashboard_bloc.dart';
import 'package:amirta_mobile/bloc/dashboard/panic/latest_panic_bloc.dart';
import 'package:amirta_mobile/my_material.dart';

class HomeSummarySection extends StatelessWidget {
  HomeSummarySection({Key? key}) : super(key: key);

  final dateTime = DateTime.now();
  final dateFormat = DateFormat('MMMM y', 'id');

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashboardBloc, DashboardState>(
      listener: (context, state) async {
        if (state is DashboardSuccess) {
          context.read<LatestPanicBloc>().add(LoadLatestPanic());
        }
        if (state is DashboardTokenExpired) {
          await context.appProvider().clearData();
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.login,
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        if (state is DashboardLoading || state is DashboardInitial) {
          return const MyProgressIndicator();
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
                      height: imgSizeBig,
                      width: imgSizeBig,
                    ),
                    const SizedBox(
                      width: spaceMedium,
                    ),
                    BlocBuilder<LatestPanicBloc, LatestPanicState>(
                      builder: (context, state) {
                        if (state is LatestPanicLoading) {
                          return const Expanded(
                            child: Center(
                              child: CircularProgressIndicator(
                                color: egyptian,
                              ),
                            ),
                          );
                        }

                        if (state is LatestPanicSuccess &&
                            state.pengaduan != null) {
                          return Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.pengaduan!.complainantName,
                                  style: context.styleBody1.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  state.pengaduan!.rusunName,
                                  style: context.styleCaption,
                                ),
                                const SizedBox(
                                  height: spaceMedium,
                                ),
                                Text(
                                  state.pengaduan!.receivedDtimeHomeFormatted,
                                  style: context.styleCaption,
                                ),
                              ],
                            ),
                          );
                        }

                        return Expanded(
                          child: Text(
                            'txt_msg_relax_okay'.tr(),
                            style: context.styleCaption,
                          ),
                        );
                      },
                    ),
                    Column(
                      children: [
                        Text(
                          state.dashboard.totalPanicButton.toString(),
                          style: context.styleHeadline1.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: spaceTiny,
                        ),
                        Text(
                          'txt_panic_data'.tr(),
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
              ShadowedContainer(
                padding: const EdgeInsets.all(spaceNormal),
                borderRadius: buttonRadius,
                child: Row(
                  children: [
                    Image.asset(
                      imageRes('ic_pengaduan_info_harian.png'),
                      height: imgSizeBig,
                      width: imgSizeBig,
                    ),
                    const SizedBox(
                      width: spaceMedium,
                    ),
                    Text(
                      'title_pengaduan'.tr(),
                      style: context.styleBody1,
                    ),
                    const Spacer(),
                    Text(
                      state.dashboard.totalComplaint.toString(),
                      style: context.styleHeadline4.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: spaceMedium,
              ),
              ShadowedContainer(
                padding: const EdgeInsets.all(spaceNormal),
                borderRadius: buttonRadius,
                child: Row(
                  children: [
                    Image.asset(
                      imageRes('ic_air_info_harian.png'),
                      height: imgSizeBig,
                      width: imgSizeBig,
                    ),
                    const SizedBox(
                      width: spaceMedium,
                    ),
                    Text(
                      'txt_water_date'.tr(args: [dateFormat.format(dateTime)]),
                      style: context.styleBody1,
                    ),
                    const Spacer(),
                    Text(
                      state.dashboard.totalUncollectedMeterPdam.toString(),
                      style: context.styleHeadline4.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }

        return const Center(
          child: Text('Gagal Mengambil Data Dashboard'),
        );
      },
    );
  }
}
