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
  List<String> selectedCuisines = [];
  List<String> selectedTypes = [];
  List<String> selectedOptions = [];
  String searchText = '';

  void openFilterPanel() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FilterPanel(
          onApplyFilters: (cuisines, types, options) {
            setState(() {
              selectedCuisines = cuisines;
              selectedTypes = types;
              selectedOptions = options;
            });

            print('Filtres appliqués :');
            print('Cuisines : $selectedCuisines');
            print('Types : $selectedTypes');
            print('Options : $selectedOptions');
          },
        );
      },
    );
  }

  void updateSearch(String value) {
    setState(() {
      searchText = value;
    });

    // 🔥 Ici tu peux appeler ton API ou filtrer une liste locale
    print('Recherche : $searchText');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PickMenuAppBar(
        searchController: searchController,
        onFilterTap: openFilterPanel,
        onSearchChanged: updateSearch,
      ),
      body: widget.child, // Le contenu de la page reste fixe
    );
  }
}
