import 'package:flutter/material.dart';
import 'package:softdev_foodblog_frontend/repositories/authen_repositories.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController firstNameController = TextEditingController();
    TextEditingController lastNameController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      backgroundColor: const Color(0xFFFFA20C),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(bottom: 90.0, left: 10.0),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 28,
                              ),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                          const Expanded(
                            child: Center(
                              child: Text(
                                'ลงทะเบียน\nกับแอพของเรา !',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  height: 1.2,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(right: 16.0),
                            child: Image.asset(
                              'lib/images/burger.png',
                              width: 175,
                              height: 150,
                            ),
                          ),
                        ],
                      ),
                      // Use Flexible instead of Expanded
                      Flexible(
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(20.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 15.0),
                                  child: Text(
                                    'สมัครสมาชิก',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                buildTextFormField(
                                    'ชื่อจริง', firstNameController),
                                const SizedBox(height: 16.0),
                                buildTextFormField(
                                    'นามสกุล', lastNameController),
                                const SizedBox(height: 16.0),
                                buildTextFormField(
                                    'Username', usernameController),
                                const SizedBox(height: 16.0),
                                buildTextFormField(
                                    'Password', passwordController,
                                    obscureText: true),
                                const SizedBox(height: 16.0),
                                ElevatedButton(
                                  onPressed: () {
                                    debugPrint(
                                        "Data: ${usernameController.text} ${passwordController.text} ${firstNameController.text} ${lastNameController.text}");
                                    AuthenticationRepositories()
                                        .registerUser(
                                            usernameController.text,
                                            passwordController.text,
                                            firstNameController.text,
                                            lastNameController.text)
                                        .then((value) {
                                      if (value) {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'สมัครสมาชิกสำเร็จ'),
                                                content: const Text(
                                                    'กรุณาเข้าสู่ระบบ'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        Navigator.pushReplacementNamed(context, '/login');
                                                      },
                                                      child: const Text('ตกลง'))
                                                ],
                                              );
                                            });
                                      } else {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'สมัครสมาชิกไม่สำเร็จ'),
                                                content: const Text(
                                                    'กรุณาลองใหม่อีกครั้ง'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: const Text('ตกลง'))
                                                ],
                                              );
                                            });
                                      }
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFFA20C),
                                    foregroundColor: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    textStyle: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  child: const Text('ลงทะเบียน'),
                                ),
                                const SizedBox(
                                    height: 20), // Add space at the bottom
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildTextFormField(String label, TextEditingController controller,
      {bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      cursorColor: const Color(0xFF49454F),
      decoration: InputDecoration(
        labelText: label,
        floatingLabelBehavior: FloatingLabelBehavior.never,
        filled: true,
        fillColor: Colors.black.withOpacity(0.1),
        labelStyle: const TextStyle(
          color: Color(0xFF49454F),
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
