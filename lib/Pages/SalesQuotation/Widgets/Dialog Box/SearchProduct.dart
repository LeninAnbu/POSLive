import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../Constant/Screen.dart';
import '../../../../Controller/SalesQuotationController/SalesQuotationController.dart';

class SearchItemsSQ extends StatefulWidget {
  const SearchItemsSQ({super.key});

  @override
  State<SearchItemsSQ> createState() => _SearchItemsState();
}

class _SearchItemsState extends State<SearchItemsSQ> {
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
                          context
                              .read<SalesQuotationCon>()
                              .filterListSearched(val);
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
                    itemCount: context
                        .read<SalesQuotationCon>()
                        .getfilterSearchedData
                        .length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          context.read<SalesQuotationCon>().visibleItemList =
                              false;

                          context
                              .read<SalesQuotationCon>()
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
                                        "${context.watch<SalesQuotationCon>().getfilterSearchedData[index].itemcode}"),
                                    Text(
                                        "${context.watch<SalesQuotationCon>().getfilterSearchedData[index].itemnameshort}"),
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
