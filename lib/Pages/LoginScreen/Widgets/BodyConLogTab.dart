import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Constant/Screen.dart';
import '../../../Controller/LoginController/LoginController.dart';
import '../../ForgotPassword/Screens/Screens.dart';

class BodyLoginTab extends StatelessWidget {
  const BodyLoginTab({
    super.key,
    //required this.logCon,
    required this.theme,
  });

  //final LoginController logCon;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Container(
      //  color: Colors.red,
      // margin: EdgeInsets.symmetric(vertical: 10),
      height: Screens.padingHeight(context) * 0.50,
      padding: EdgeInsets.symmetric(horizontal: Screens.width(context) * 0.02),
      child: Form(
        key: context.read<LoginController>().formkey[0],
        child: Column(
          children: [
            context.watch<LoginController>().getSettingMsg.isNotEmpty
                ? SizedBox(
                    width: Screens.width(context),
                    child: Text(
                      context.watch<LoginController>().getSettingMsg,
                      style: theme.textTheme.bodyMedium
                          ?.copyWith(color: Colors.red),
                    ),
                  )
                : Container(),
            context.watch<LoginController>().getSettingMsg.isNotEmpty
                ? SizedBox(height: Screens.bodyheight(context) * 0.02)
                : const SizedBox(
                    height: 0,
                  ),
            TextFormField(
              controller: context.read<LoginController>().mycontroller[0],
              autofocus: true,
              decoration: InputDecoration(
                border: InputBorder.none,
                fillColor: Colors.grey[200],
                filled: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 3)),
                labelText: 'User',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'User Required';
                }
                return null;
              },
            ),
            SizedBox(
              height: Screens.padingHeight(context) * 0.02,
            ),
            TextFormField(
              controller: context.read<LoginController>().mycontroller[1],
              obscureText: context.read<LoginController>().getHidepassword,
              decoration: InputDecoration(
                fillColor: Colors.grey[200],
                filled: true,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.white)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                        color: Theme.of(context).primaryColor, width: 3)),
                suffixIcon: IconButton(
                  icon: context.watch<LoginController>().getHidepassword
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: () {
                    context.read<LoginController>().obsecure();
                  },
                ),
                labelText: 'Password',
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password Required';
                }
                return null;
              },
            ),
            SizedBox(
              height: Screens.padingHeight(context) * 0.01,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 90),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ForgotMainScreen()
                                  // ForgotPasswordPage(
                                  //     forgetHeight:
                                  //         Screens.bodyheight(
                                  //             context),
                                  //     forgetwidth:
                                  //         Screens.width(context)*0.5)
                                  ));
                        },
                        child: const Text(
                          'Recover Password?',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: Screens.padingHeight(context) * 0.02,
            ),
            SizedBox(
              width: Screens.width(context),
              height: Screens.padingHeight(context) * 0.06,
              child: ElevatedButton(
                onPressed: context.read<LoginController>().disableBtn == false
                    ? () {
                        context
                            .read<LoginController>()
                            .validate(context, theme);
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6),
                    )),
                child: const Text('Login'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
