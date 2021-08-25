import 'package:amirta_mobile/my_material.dart';
import 'package:amirta_mobile/res/resources.dart';

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
    nrkController.text = '1234567890';
    nameController.text = 'Muhammad Ikhsan';
    emailController.text = 'mail@gmail.com';
    roleController.text = 'Anggota';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        centerTitle: true,
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
              isEnabled: false,
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
              () {
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
