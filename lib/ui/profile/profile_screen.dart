import 'dart:io';

import 'package:amirta_mobile/bloc/profile/photo/photo_profile_bloc.dart';
import 'package:amirta_mobile/bloc/profile/profile_bloc.dart';
import 'package:amirta_mobile/my_material.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nrkController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final roleController = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  XFile? file;
  
  @override
  void initState() {
    final user = context.appProvider().user;
    nrkController.text = user?.userId ?? '-';
    nameController.text = user?.name ?? '-';
    emailController.text = user?.emailAddress ?? '-';
    roleController.text = user?.loginType == 0 ? 'Anggota' : '-';
    super.initState();
  }

  void takePhoto() async {
    final result = await _picker.pickImage(
      source: ImageSource.camera,
    );
    if (result != null) {
      final path = result.path;
      print(path);
      setState(() {
        file = result;
      });
      context
        .read<PhotoProfileBloc>()
        .add(UploadPhoto(file!));
    }
  }

  Widget imageProfile(ImageProvider provider) {
    return InkWell(
      onTap: takePhoto,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Image(
          image: provider,
          width: 80,
          height: 80,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) {
          return ProfileBloc(
            context.appProvider().accountRepository,
            context.appProvider(),
          );
        }),
        BlocProvider(create: (context) {
          return PhotoProfileBloc(
            context.appProvider().uploadImageRepository,
            context.appProvider(),
          );
        })
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
          centerTitle: true,
          actions: [
            OfflineContainer(
              offlineChild: SizedBox(),
              child: IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/settings');
                },
                icon: ImageIcon(
                  AssetImage(imageRes('ic_settings.png')),
                  size: imgSizeNormal,
                ),
              ),
            )
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(150),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OfflineContainer(
                    offlineChild: Icon(
                      Icons.account_circle_rounded,
                      size: 80,
                      color: white,
                    ),
                    child: BlocConsumer<PhotoProfileBloc, PhotoProfileState>(
                      listener: (context, state) {
                        if (state is PhotoProfileSuccess) {
                          final phone =
                              context.appProvider().user!.mobilePhoneNumber;
                          context
                              .read<ProfileBloc>()
                              .add(SaveAccount(phone, emailController.text));
                          setState(() {
                            file = null;
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is PhotoProfileLoading) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: white,
                            ),
                          );
                        }
                        if (file != null) {
                          return imageProfile(
                            FileImage(File(file!.path)),
                          );
                        }
                        if (state is PhotoProfileSuccess) {
                          return imageProfile(
                            NetworkImage(state.url),
                          );
                        }
                        final user = context.appProvider().user;
                        if (user?.photo != null &&
                            user?.photo?.isEmpty == false) {
                          return imageProfile(
                            NetworkImage(
                              user!.photo!.photoProfileUrl,
                            ),
                          );
                        }
                        return Icon(
                          Icons.account_circle_rounded,
                          size: 80,
                          color: white,
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    height: spaceMedium,
                  ),
                  Text(
                    nameController.text,
                    style: context.styleBody2.copyWith(
                      fontWeight: FontWeight.bold,
                      color: white,
                    ),
                  ),
                  Text(
                    nrkController.text,
                    style: context.styleBody2.copyWith(
                      color: white.withOpacity(0.5),
                    ),
                  ),
                  const SizedBox(
                    height: spaceMedium,
                  ),
                ],
              ),
            ),
          ),
        ),
        body: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccess) {
              setState(() {
                emailController.text = context.appProvider().user!.emailAddress;
              });
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(spaceMedium),
              child: Column(
                children: [
                  LabeledInputField(
                    nrkController,
                    label: "Nomor NRK",
                    isEnabled: false,
                  ),
                  LabeledInputField(
                    nameController,
                    label: "Nama",
                    isEnabled: false,
                  ),
                  LabeledInputField(
                    emailController,
                    label: "Email",
                    isEnabled: true,
                  ),
                  LabeledInputField(
                    roleController,
                    label: "Jabatan",
                    isEnabled: false,
                  ),
                  const SizedBox(
                    height: spaceNormal,
                  ),
                  OfflineContainer(
                    offlineChild: SizedBox(),
                    child: PrimaryButton(
                      () {
                        if (file != null) {
                          context
                              .read<PhotoProfileBloc>()
                              .add(UploadPhoto(file!));
                        } else {
                          final phone =
                              context.appProvider().user!.mobilePhoneNumber;
                          context
                              .read<ProfileBloc>()
                              .add(SaveAccount(phone, emailController.text));
                        }
                      },
                      "Simpan",
                      isLoading: state is ProfileLoading,
                    ),
                  ),
                  LogoutButton(
                    () async {
                      await context.appProvider().clearData();
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login',
                        (route) => false,
                      );
                    },
                    "Keluar",
                    isEnabled: !(state is ProfileLoading),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
