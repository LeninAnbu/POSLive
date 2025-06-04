import 'package:flutter/material.dart';
import 'package:posproject/Controller/SalesOrderController/SalesOrderController.dart';
import 'package:provider/provider.dart';
import '../../../../../Constant/Screen.dart';

class SearchItemsSO extends StatefulWidget {
  const SearchItemsSO({super.key});
// final List<StockSnapTModelDB>? searchedData;
//SOCon prdsrch;
  @override
  State<SearchItemsSO> createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItemsSO> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AlertDialog(
        insetPadding: const EdgeInsets.all(10),
        contentPadding: const EdgeInsets.all(0),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        content: Container(
          width: Screens.width(context),
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Container(
                    width: Screens.width(context) * 0.93,
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: const Color.fromARGB(255, 240, 235, 235)),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                    ),
                    child: TextField(
                      autofocus: true,
                      style: theme.textTheme.bodyLarge!
                          .copyWith(color: Colors.black),
                      keyboardType: TextInputType.text,
                      onChanged: (val) {
                        setState(() {
                          context.read<SOCon>().filterListSearched(val);
                        });
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.all(8),
                        hintText: "Inventories",
                        hintStyle: theme.textTheme.bodyMedium!.copyWith(),
                        suffixIcon: IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.search,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                        });
                      },
                      icon: const Icon(Icons.close))
                ],
              ),
              SizedBox(
                height: Screens.bodyheight(context) * 0.01,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount:
                        context.read<SOCon>().getfilterSearchedData.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.read<SOCon>().visibleItemList = false;
                          context
                              .read<SOCon>()
                              .onselectFst(context, theme, index);
                          setState(() {});
                        },
                        child: Card(
                          child: Container(
                              width: Screens.bodyheight(context) * 0.8,
                              padding: EdgeInsets.only(
                                top: Screens.bodyheight(context) * 0.01,
                                left: Screens.width(context) * 0.01,
                                right: Screens.width(context) * 0.01,
                                bottom: Screens.bodyheight(context) * 0.005,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                              ),
                              child: IntrinsicHeight(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        "${context.watch<SOCon>().getfilterSearchedData[index].itemcode}"),
                                    Text(
                                        "${context.watch<SOCon>().getfilterSearchedData[index].itemnameshort}"),
                                  ],
                                ),
                              )),
                        ),
                      );
                    }),
              )
            ],
          ),
        ));
  }
}
