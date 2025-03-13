import 'package:flutter/material.dart';

class FilterPanel extends StatefulWidget {
  final Function(List<String> selectedCuisines, List<String> selectedTypes, List<String> selectedOptions) onApplyFilters;

  const FilterPanel({required this.onApplyFilters, super.key});

  @override
  _FilterPanelState createState() => _FilterPanelState();
}

class _FilterPanelState extends State<FilterPanel> {
  final List<String> cuisines = ['Italien', 'Français', 'Japonais', 'Mexicain'];
  final List<String> types = ['Restaurant', 'Fast Food', 'Café', 'Bistro'];
  final List<String> options = ['Végétarien', 'Vegan', 'Sans Gluten'];

  List<String> selectedCuisines = [];
  List<String> selectedTypes = [];
  List<String> selectedOptions = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      height: 400, // Hauteur du BottomSheet
      child: Column(
        children: [
          Text('Filtres', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Expanded(child: _buildFilterList()),
          ElevatedButton(
            onPressed: () {
              widget.onApplyFilters(selectedCuisines, selectedTypes, selectedOptions);
              Navigator.pop(context); // Fermer le BottomSheet
            },
            child: Text('Appliquer les filtres'),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterList() {
    return ListView(
      children: [
        _buildCheckboxList('Type de Cuisine', cuisines, selectedCuisines),
        _buildCheckboxList('Type de Restaurant', types, selectedTypes),
        _buildCheckboxList('Options', options, selectedOptions),
      ],
    );
  }

  Widget _buildCheckboxList(String title, List<String> items, List<String> selectedList) {
    return ExpansionTile(
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      children: items.map((item) {
        return CheckboxListTile(
          title: Text(item),
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
        );
      }).toList(),
    );
  }
}
