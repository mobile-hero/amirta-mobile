import 'package:amirta_mobile/my_material.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nrkController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final roleController = TextEditingController();

  @override
  void initState() {
    final user = context.appProvider().user;
    nrkController.text = user?.userId ?? '-';
    nameController.text = user?.name ?? '-';
    emailController.text = user?.emailAddress ?? '-';
    roleController.text = user?.loginType == 0 ? 'Anggota' : '-';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, '/settings');
            },
            icon: ImageIcon(
              AssetImage(imageRes('ic_settings.png')),
              size: imgSizeNormal,
            ),
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(130),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.network(
                    "https://img.icons8.com/bubbles/2x/user.png",
                    width: 80,
                    height: 80,
                  ),
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
      body: SingleChildScrollView(
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
              isEnabled: true,
            ),
            LabeledInputField(
              emailController,
              label: "Email",
              isEnabled: false,
            ),
            LabeledInputField(
              roleController,
              label: "Jabatan",
              isEnabled: false,
            ),
            const SizedBox(
              height: spaceNormal,
            ),
            PrimaryButton(
              () {
                Navigator.pop(context);
              },
              "Simpan",
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
            ),
          ],
        ),
      ),
    );
  }
}
