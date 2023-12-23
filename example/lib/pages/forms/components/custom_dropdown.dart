import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mainform/pages/forms/main_form/main_form_reducer.dart';
import 'package:mainform/store/app_store.dart';


class CustomDropdownWithSearch extends StatefulWidget {
  final List<String> items;
  final String itemName;
  final int dState;

  const CustomDropdownWithSearch({
    Key? key,
    required this.items,
    required this.itemName,
    required this.dState,
  }) : super(key: key);

  @override
  _CustomDropdownWithSearchState createState() => _CustomDropdownWithSearchState();
}

class _CustomDropdownWithSearchState extends State<CustomDropdownWithSearch> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<GlobalState, MainFormState>(
      converter: (appState) => appState.state.appState.mainFormState,
      builder: (context, mainFormState) {
        return GestureDetector(
          onTap: () => _showItemsList(context),
          child: AbsorbPointer(
            child: Padding(padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                controller: 
                  widget.dState == 0 
                    ? TextEditingController(text: mainFormState.mainFormModel!.driverName)
                    : widget.dState == 1
                      ? TextEditingController(text: mainFormState.mainFormModel!.truckVin)
                      : TextEditingController(text: mainFormState.mainFormModel!.trailerNumber),
                decoration: InputDecoration(
                  labelText: widget.itemName,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _showItemsList(BuildContext context) {
    List<String> filteredItems = widget.items ?? [];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: SizedBox(
            width: 300,
            height: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: 'Search',
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: searchController.text.isNotEmpty 
                        ? IconButton(
                            onPressed: () {
                              searchController.clear();
                              filteredItems = widget.items ?? [];
                              (context as Element).markNeedsBuild();
                            },
                            icon: Icon(Icons.clear) 
                          )
                        : null,
                    ),
                    onChanged: (String value) {
                      filteredItems = (widget.items ?? []).where((item) {
                        final itemLower = item.toLowerCase();
                        final searchLower = value.toLowerCase();
                        return itemLower.contains(searchLower);
                      }).toList();
                      (context as Element).markNeedsBuild();
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return ListTile(
                        title: Text(item),
                        onTap: () {
                          Navigator.of(context).pop();
                          setState(() {
                            searchController.text = item;
                            print("selectedItem from controller: ${searchController.text}");
                            if (widget.dState == 0) {
                              StoreProvider.of<GlobalState>(context).dispatch(UpdateDriverName(searchController.text));
                              print('selectedItem from state: ${StoreProvider.of<GlobalState>(context).state.appState.mainFormState.mainFormModel!.driverName}');
                            } else if (widget.dState == 1) {
                              StoreProvider.of<GlobalState>(context).dispatch(UpdateVINNumber(searchController.text));
                              print('selectedItem from state: ${StoreProvider.of<GlobalState>(context).state.appState.mainFormState.mainFormModel!.truckVin}');
                            } else if (widget.dState == 2) {
                              StoreProvider.of<GlobalState>(context).dispatch(UpdateTrailerNumber(searchController.text));
                              print('selectedItem from state: ${StoreProvider.of<GlobalState>(context).state.appState.mainFormState.mainFormModel!.trailerNumber}');
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}