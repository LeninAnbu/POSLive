import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/LoginController/LoginController.dart';
import 'package:provider/provider.dart';

import '../../../ForgotPassword/Screens/Screens.dart';

class BodyContainerMob extends StatelessWidget {
  const BodyContainerMob({
    super.key, //required this.logCon
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Builder(builder: (context) {
      return Builder(builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(
              vertical: Screens.padingHeight(context) * 0.02,
              horizontal: Screens.width(context) * 0.03),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Form(
                key: context.read<LoginController>().formkey[0],
                child: Column(
                  children: <Widget>[
                    context.read<LoginController>().getSettingMsg.isNotEmpty
                        ? SizedBox(
                            width: Screens.width(context),
                            child: Text(
                              context.watch<LoginController>().getSettingMsg,
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(color: Colors.red),
                            ),
                          )
                        : Container(),
                    context.read<LoginController>().getSettingMsg.isNotEmpty
                        ? SizedBox(height: Screens.bodyheight(context) * 0.02)
                        : const SizedBox(
                            height: 0,
                          ),
                    SizedBox(
                      width: Screens.width(context), //* 0.80,

                      child: TextFormField(
                        controller:
                            context.read<LoginController>().mycontroller[0],
                        autofocus: true,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          fillColor: Colors.grey[200],
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 3)),
                          labelText: 'User',
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'User Required';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.02,
                    ),
                    SizedBox(
                      width: Screens.width(context), // * 0.80,
                      child: TextFormField(
                        controller:
                            context.read<LoginController>().mycontroller[1],
                        obscureText:
                            context.read<LoginController>().getHidepassword,
                        decoration: InputDecoration(
                          fillColor: Colors.grey[200],
                          filled: true,
                          border: InputBorder.none,
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide:
                                  const BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                  color: Theme.of(context).primaryColor,
                                  width: 3)),
                          suffixIcon: IconButton(
                            icon:
                                context.read<LoginController>().getHidepassword
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
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 30),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: ((context) =>
                                          const ForgotMainScreen())));
                            },
                            child: const Text(
                              'Recover Password?',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Screens.bodyheight(context) * 0.02,
                    ),
                    SizedBox(
                      width: Screens.width(context), // * 0.80,
                      child: ElevatedButton(
                        onPressed: () {
                          context
                              .read<LoginController>()
                              .validate(context, theme);
                        },
                        style: ElevatedButton.styleFrom(
                            fixedSize: const Size(400, 50),
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
            ],
          ),
        );
      });
    });
  }
}
