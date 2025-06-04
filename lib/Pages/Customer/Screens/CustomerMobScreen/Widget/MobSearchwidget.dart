import 'package:flutter/material.dart';

import '../../../../../Controller/CustomerController/CustomerController.dart';

class MobSearchWidget extends StatefulWidget {
  MobSearchWidget(
      {super.key,
      required this.stChCon,
      required this.searchHeight,
      required this.searchWidth});
  CustomerController stChCon;
  double searchHeight;
  double searchWidth;

  @override
  State<MobSearchWidget> createState() => _MobSearchWidgetState();
}

class _MobSearchWidgetState extends State<MobSearchWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: widget.searchHeight,
      width: widget.searchWidth,
      padding: EdgeInsets.only(
          top: widget.searchHeight * 0.01,
          left: widget.searchHeight * 0.01,
          right: widget.searchHeight * 0.01,
          bottom: widget.searchHeight * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
              alignment: Alignment.center,
              width: widget.searchWidth * 1,
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color.fromARGB(255, 240, 235, 235)),
                borderRadius: BorderRadius.circular(3),
                color: Colors.grey.withOpacity(0.01),
              ),
              child: TextFormField(
                style: theme.textTheme.bodyMedium,
                onChanged: (v) {
                  widget.stChCon.filterListSearched(v);
                },
                cursorColor: Colors.grey,
                controller: widget.stChCon.mycontroller[0],
                onEditingComplete: () {},
                decoration: InputDecoration(
                  filled: false,
                  hintText: 'Search Here..',
                  hintStyle:
                      theme.textTheme.bodyMedium?.copyWith(color: Colors.grey),
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  suffixIcon: IconButton(
                    icon: const Icon(
                      Icons.search,
                      color: Colors.grey,
                    ),
                    onPressed: () async {},
                    color: theme.primaryColor,
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 10,
                  ),
                ),
              )),
          SizedBox(
            height: widget.searchHeight * 0.01,
          ),
          Expanded(
            child: widget.stChCon.listbool == true &&
                    widget.stChCon.filtercustomerList.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : widget.stChCon.listbool == false &&
                        widget.stChCon.filtercustomerList.isEmpty
                    ? const Text("Does Not Have data..!!")
                    : ListView.builder(
                        itemCount: widget.stChCon.filtercustomerList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              setState(() {
                                widget.stChCon.callAddresstReportapi(widget
                                    .stChCon
                                    .filtercustomerList[index]
                                    .customerCode!);
                                widget.stChCon.tappage.animateToPage(
                                    ++widget.stChCon.tappageIndex,
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.linearToEaseOut);

                                widget.stChCon.listPasss(
                                    widget.stChCon.filtercustomerList[index]);
                              });
                            },
                            child: Card(
                              child: Container(
                                padding: EdgeInsets.only(
                                  top: widget.searchHeight * 0.01,
                                  left: widget.searchHeight * 0.01,
                                  right: widget.searchHeight * 0.01,
                                  bottom: widget.searchHeight * 0.01,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "${widget.stChCon.filtercustomerList[index].customerCode}",
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(
                                                  fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: widget.searchHeight * 0.01,
                                        ),
                                        SizedBox(
                                            width: widget.searchWidth * 0.4,
                                            child: Text(
                                              "${widget.stChCon.filtercustomerList[index].customername}",
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.grey),
                                            )),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${widget.stChCon.filtercustomerList[index].phoneno1}",
                                          style: theme.textTheme.bodyMedium
                                              ?.copyWith(color: Colors.grey),
                                        ),
                                        SizedBox(
                                          height: widget.searchHeight * 0.01,
                                        ),
                                        Container(
                                            alignment: Alignment.centerRight,
                                            child: Text(
                                              "${widget.stChCon.filtercustomerList[index].emalid}",
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                      color: Colors.grey),
                                            )),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
          )
        ],
      ),
    );
  }
}
