import 'package:flutter/material.dart';
import 'package:posproject/Constant/Screen.dart';
import 'package:posproject/Controller/LoginController/LoginController.dart';
import 'package:provider/provider.dart';

class FooterContainer extends StatelessWidget {
  FooterContainer({
    super.key,
    required this.height,
  });
  double height;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      //  color: Colors.deepOrange,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
              onTap: () {
                context.read<LoginController>().clearController();
                context.read<LoginController>().getDeviceID();
                showDialog(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4))),
                        contentPadding: const EdgeInsets.all(0),
                        // backgroundColor: Colors.transparent,
                        insetPadding:
                            EdgeInsets.all(Screens.bodyheight(context) * 0.02),
                        content: settings(
                          context,
                        ),
                        //  AlertBox(
                        //   payMent: 'Settings',
                        //   widget: s
                        //   buttonName: "Save",
                        //   callback: () {
                        //     logCon.settingvalidate(context);
                        //   },
                        // )
                      );
                    });
              },
              child: SizedBox(
                  width: Screens.width(context) * 0.05,
                  // color: Colors.red,
                  child: const Icon(
                    Icons.settings,
                    size: 27,
                  ))),
          const Text(
            'copyright',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  settings(
    BuildContext context,
  ) {
    final theme = Theme.of(context);
    return StatefulBuilder(builder: (context, st) {
      return Container(
        padding: EdgeInsets.only(
            top: Screens.padingHeight(context) * 0.01,
            left: Screens.width(context) * 0.03,
            right: Screens.width(context) * 0.03,
            bottom: Screens.padingHeight(context) * 0.01),
        width: Screens.width(context) * 0.6,
        // color: Colors.red,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // width: Screens.width(context)*0.55,
                height: Screens.padingHeight(context) * 0.05,
                color: theme.primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: Screens.padingHeight(context) * 0.02,
                          right: Screens.padingHeight(context) * 0.02),
                      // color: Colors.red,
                      //  width: Screens.width(context) * 0.4,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Alert",
                        style: theme.textTheme.bodyMedium
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          size: Screens.padingHeight(context) * 0.025,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
              Form(
                key: context.read<LoginController>().formkey[1],
                child: Column(
                  children: [
                    // TextFormField(
                    //   controller: logCon.mycontroller[2],
                    //   decoration: InputDecoration(
                    //     hintText: 'Host',
                    //   ),
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return 'Values Required';
                    //     }
                    //   },
                    // ),

                    Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.001),
                      ),
                      child: TextFormField(
                        // autofocus: true,
                        controller:
                            context.read<LoginController>().mycontroller[2],
                        cursorColor: Colors.grey,
                        readOnly: context.read<LoginController>().isalreadyset,
                        keyboardType: TextInputType.number,
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Host';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          hintText: 'Host',
                          hintStyle: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey),
                          filled: false,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 25,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.001),
                      ),
                      child: TextFormField(
                        readOnly: true,
                        controller:
                            context.read<LoginController>().mycontroller[3],
                        cursorColor: Colors.grey,
                        keyboardType: TextInputType.number,
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Enter Device ID';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          hintText: 'Device ID',
                          hintStyle: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey),
                          filled: false,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 25,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: Screens.padingHeight(context) * 0.01,
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.001),
                      ),
                      child: TextFormField(
                        // autofocus: true,
                        controller:
                            context.read<LoginController>().mycontroller[4],
                        cursorColor: Colors.grey,
                        // readOnly: context.read<LoginController>().isalreadyset,
                        //keyboardType: TextInputType.number,
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' Enter Site Code';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          hintText: 'Site Code',
                          hintStyle: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey),
                          filled: false,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 25,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: Screens.padingHeight(context) * 0.01),
                    Container(
                      alignment: Alignment.centerRight,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(3),
                        color: Colors.grey.withOpacity(0.001),
                      ),
                      child: TextFormField(
                        // autofocus: true,
                        controller:
                            context.read<LoginController>().mycontroller[5],
                        cursorColor: Colors.grey,
                        // readOnly: context.read<LoginController>().isalreadyset,
                        //keyboardType: TextInputType.number,
                        onChanged: (v) {},
                        validator: (value) {
                          if (value!.isEmpty) {
                            return ' Enter Terminal';
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.red),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          hintText: 'Terminal',
                          hintStyle: theme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey),
                          filled: false,
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: 25,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: Screens.padingHeight(context) * 0.01),
              InkWell(
                onTap: () {
                  st(() {
                    context.read<LoginController>().settingvalidate(context);
                    //logCon.ClearSp();
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  height: Screens.padingHeight(context) * 0.045,
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                  ),
                  child: Center(
                    child: Container(
                      alignment: Alignment.center,
                      child: Text(
                        "Set",
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyLarge
                            ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
