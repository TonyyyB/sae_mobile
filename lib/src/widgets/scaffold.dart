import 'package:flutter/material.dart';
import 'appbar.dart';
import 'filter_panel.dart';

class PickMenuScaffold extends StatefulWidget {
  final Widget child;

  const PickMenuScaffold({required this.child, super.key});

  @override
  _PickMenuScaffoldState createState() => _PickMenuScaffoldState();
}

class _PickMenuScaffoldState extends State<PickMenuScaffold> {
  TextEditingController searchController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  bool showFilters = false;
  List<String> selectedCuisines = [];
  List<String> selectedTypes = [];
  List<String> selectedOptions = [];

  @override
  void initState() {
    super.initState();
    searchFocusNode.addListener(() {
      if (searchFocusNode.hasFocus) {
        setState(() {
          showFilters =
              true; // Afficher les filtres dès qu'on clique dans le champ de recherche
        });
      }
    });
  }

  void toggleFilters() {
    setState(() {
      showFilters = !showFilters;
      if (!showFilters) {
        searchFocusNode.unfocus(); // Fermer les filtres et enlever le focus
      }
    });
  }

  void applyFilters(
      List<String> cuisines, List<String> types, List<String> options) {
    setState(() {
      selectedCuisines = cuisines;
      selectedTypes = types;
      selectedOptions = options;
      showFilters = false;
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
        onTap:
            closeFiltersIfNeeded, // Fermer les filtres si on clique en dehors
        behavior: HitTestBehavior.opaque,
        child: Column(
          children: [
            if (showFilters)
              GestureDetector(
                onTap:
                    () {}, // Empêche la fermeture en cliquant sur les filtres
                child: FilterPanel(onApplyFilters: applyFilters),
              ),
            Expanded(child: widget.child), // Contenu principal
          ],
        ),
      ),
    );
  }
}
