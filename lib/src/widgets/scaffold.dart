import 'package:flutter/material.dart';
import 'package:sae_mobile/config/router.dart';
import 'appbar.dart';
import 'filter_panel.dart';

class PickMenuScaffold extends StatefulWidget {
  final Widget child;
  final List<String> selectedCuisines;
  final List<String> selectedTypes;
  final List<String> selectedOptions;
  final String initialSearch;

  const PickMenuScaffold(
      {required this.child,
      this.selectedCuisines = const [],
      this.selectedTypes = const [],
      this.selectedOptions = const [],
      super.key,
      this.initialSearch = ""});

  @override
  _PickMenuScaffoldState createState() => _PickMenuScaffoldState();
}

class _PickMenuScaffoldState extends State<PickMenuScaffold> {
  late TextEditingController searchController;
  FocusNode searchFocusNode = FocusNode();
  bool showFilters = false;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController(text: widget.initialSearch);
    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        setState(() {
          showFilters = true;
        });
      }
    });
  }

  void toggleFilters() {
    setState(() {
      showFilters = !showFilters;
      if (!showFilters) {
        searchFocusNode.unfocus();
      }
    });
  }

  void applyFilters(
      List<String> cuisines, List<String> types, List<String> options) {
    setState(() {
      showFilters = false;
    });
    router.push("/search", extra: {
      "cuisines": cuisines,
      "types": types,
      "options": options,
      "search": searchController.text
    });
  }

  void closeFiltersIfNeeded() {
    if (showFilters) {
      setState(() {
        showFilters = false;
        searchFocusNode.unfocus();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PickMenuAppBar(
        searchController: searchController,
        searchFocusNode: searchFocusNode,
        onFilterTap: toggleFilters,
        onSearchChanged: (value) {
          print('Recherche : $value');
        },
        showFilters: showFilters,
      ),
      body: GestureDetector(
        onTap: closeFiltersIfNeeded,
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            if (showFilters)
              GestureDetector(
                onTap: () {},
                child: FilterPanel(
                    selectedCuisines: widget.selectedCuisines,
                    selectedTypes: widget.selectedTypes,
                    selectedOptions: widget.selectedOptions,
                    onApplyFilters: applyFilters),
              ),
            Expanded(child: widget.child),
          ],
        ),
      ),
    );
  }
}
