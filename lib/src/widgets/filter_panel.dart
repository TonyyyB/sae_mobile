import 'package:flutter/material.dart';
import 'package:sae_mobile/src/data/database_provider.dart';

class FilterPanel extends StatefulWidget {
  static Map<String, String> OPTIONS = {
    "Végétarien": "vegetarien",
    "Végan": "vegan",
    "Livraison": "delivery",
    "Accès fauteil roulant": "wheelchair",
    "Click&Collect": "takeaway",
    "Drive": "drive_through"
  };
  final Function(List<String> selectedCuisines, List<String> selectedTypes,
      List<String> selectedOptions) onApplyFilters;
  final List<String> initialSelectedCuisines;
  final List<String> initialSelectedTypes;
  final List<String> initialSelectedOptions;

  FilterPanel({
    required this.onApplyFilters,
    List<String>? selectedCuisines,
    List<String>? selectedTypes,
    List<String>? selectedOptions,
    super.key,
  })  : initialSelectedCuisines = selectedCuisines ?? [],
        initialSelectedTypes = selectedTypes ?? [],
        initialSelectedOptions = selectedOptions ?? [];

  @override
  _FilterPanelState createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  bool _isLoading = true;
  late List<String> cuisines = [];
  late List<String> types = [];
  final List<String> options = FilterPanel.OPTIONS.keys.toList();

  // Copies locales modifiables
  late List<String> _selectedCuisines;
  late List<String> _selectedTypes;
  late List<String> _selectedOptions;

  @override
  void initState() {
    super.initState();
    // Créer des copies modifiables des listes initiales
    _selectedCuisines = List<String>.from(widget.initialSelectedCuisines);
    _selectedTypes = List<String>.from(widget.initialSelectedTypes);
    _selectedOptions = List<String>.from(widget.initialSelectedOptions);

    _initData().then(
      (value) {
        setState(() {
          _isLoading = false;
        });
      },
    );
  }

  Future<void> _initData() async {
    cuisines = (await DatabaseProvider.getAllCuisines()).values.toList();
    types = (await DatabaseProvider.getAllTypes()).values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            if (_isLoading) ...[
              const Center(
                child: CircularProgressIndicator(),
              )
            ] else ...[
              _buildCheckboxList(
                  'Type de Cuisine', cuisines, _selectedCuisines),
              _buildCheckboxList('Type de Restaurant', types, _selectedTypes),
              _buildCheckboxList('Options', options, _selectedOptions),
              ElevatedButton(
                onPressed: () {
                  widget.onApplyFilters(
                      _selectedCuisines, _selectedTypes, _selectedOptions);
                },
                child: Text('Rechercher'),
              ),
            ]
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxList(
      String title, List<String> items, List<String> selectedList) {
    return Material(
      child: ExpansionTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              int crossAxisCount = (constraints.maxWidth ~/ 150).clamp(2, 4);
              double itemHeight = 70.0;
              double gridHeight =
                  (items.length / crossAxisCount).ceil() * itemHeight;
              double maxHeight = gridHeight.clamp(0, 300);

              return SizedBox(
                height: maxHeight,
                child: GridView.builder(
                  physics: AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 4),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    return Center(
                      child: CheckboxListTile(
                        title: Text(item, textAlign: TextAlign.start),
                        value: selectedList.contains(item),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value == true) {
                              selectedList.add(item);
                            } else {
                              selectedList.remove(item);
                            }
                          });
                        },
                      ),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
