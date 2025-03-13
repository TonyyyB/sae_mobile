import 'package:flutter/material.dart';

class PickMenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final VoidCallback onFilterTap;
  final ValueChanged<String> onSearchChanged;

  const PickMenuAppBar({
    required this.searchController,
    required this.onFilterTap,
    required this.onSearchChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Container(
        height: 40,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.grey),
            SizedBox(width: 8),
            Expanded(
              child: TextField(
                controller: searchController,
                onChanged: onSearchChanged, // Met à jour la recherche
                decoration: InputDecoration(
                  hintText: 'Rechercher un restaurant...',
                  border: InputBorder.none,
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.filter_list, color: Colors.grey),
              onPressed: onFilterTap, // Ouvre les filtres
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
