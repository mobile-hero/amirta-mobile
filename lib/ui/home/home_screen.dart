import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';
import 'package:amirta_mobile/res/view/bottom_ellipse_container.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                                "Muhammad Ikhsan",
                                style: context.styleBody2.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: white,
                                ),
                              ),
                              Text(
                                "1234567890",
                                style: context.styleBody2.copyWith(
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
                  ShadowedContainer(
                    padding: const EdgeInsets.all(spaceNormal),
                    borderRadius: buttonRadius,
                    child: Row(
                      children: [
                        Image.asset(
                          imageRes('ic_panik_main_menu.png'),
                          height: 30,
                          width: 30,
                          scale: 5,
                        ),
                        const SizedBox(
                          width: spaceMedium,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Halim Baskoro',
                                style: context.styleHeadline6.copyWith(
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
                              '10',
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
                    children: [
                      Expanded(
                        child: ShadowedContainer(
                          padding: const EdgeInsets.all(spaceNormal),
                          borderRadius: buttonRadius,
                          child: Row(
                            children: [
                              Image.asset(
                                imageRes('ic_panik_main_menu.png'),
                                height: 30,
                                width: 30,
                                scale: 5,
                              ),
                              const SizedBox(
                                width: spaceMedium,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '3',
                                      style: context.styleHeadline4.copyWith(
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
                                imageRes('ic_panik_main_menu.png'),
                                height: 30,
                                width: 30,
                                scale: 5,
                              ),
                              const SizedBox(
                                width: spaceMedium,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '201',
                                      style: context.styleHeadline4.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: spaceTiny,
                                    ),
                                    Text(
                                      'Air April 2021',
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
                  const SizedBox(
                    height: spaceBig,
                  ),
                  Text(
                    'Info Harian',
                    style: context.styleHeadline6,
                  ),
                  Text(
                    'Periksa pembaruan dari setiap menu',
                    style: context.styleBody1,
                  ),
                  const SizedBox(
                    height: spaceMedium,
                  ),
                  briefItem(
                    context: context,
                    image: 'ic_pengaduan_info_harian.png',
                    title: 'Siti Zubaedah',
                    subtitle: 'Jatinegara Barat',
                    date: '13:44',
                  ),
                  const SizedBox(
                    height: spaceNormal,
                  ),
                  briefItem(
                    context: context,
                    image: 'ic_pengaduan_info_harian.png',
                    title: 'Jatinegara Kaum',
                    subtitle: 'Blok D Nomor 177',
                    date: '10:00',
                  ),
                  const SizedBox(
                    height: spaceNormal,
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
          height: 30,
          width: 30,
          scale: 5,
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
                style: context.styleHeadline6.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: context.styleBody1,
              ),
            ],
          ),
        ),
        Text(
          date,
          style: context.styleBody1,
        ),
      ],
    );
  }
}
