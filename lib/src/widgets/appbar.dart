import 'package:flutter/material.dart';
import 'package:sae_mobile/config/colors.dart';
import 'package:sae_mobile/config/images.dart';

class PickMenuAppBar extends StatelessWidget implements PreferredSizeWidget {
  final TextEditingController searchController;
  final FocusNode searchFocusNode;
  final VoidCallback onFilterTap;
  final ValueChanged<String> onSearchChanged;
  final bool showFilters;

  const PickMenuAppBar({
    required this.searchController,
    required this.searchFocusNode,
    required this.onFilterTap,
    required this.onSearchChanged,
    required this.showFilters,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppBar(
          toolbarHeight: 80,
          backgroundColor: PickMenuColors.appBar,
          title: Container(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              spacing: 20.5,
              children: [
                Image(
                  image: PickMenuImages.logo,
                  height: 42,
                  width: 92,
                ),
                Expanded(
                  child: TextField(
                      focusNode: searchFocusNode,
                      controller: searchController,
                      onChanged: onSearchChanged,
                      decoration: InputDecoration(
                        hintText: 'Rechercher',
                        border: InputBorder.none,
                        suffixIcon: Icon(Icons.search,
                            color: PickMenuColors.iconsColor),
                      )),
                ),
                IconButton(
                  icon: Icon(
                    Icons.account_circle_outlined,
                    color: PickMenuColors.iconsColor,
                    size: 40,
                  ),
                  onPressed: () {},
                  padding: EdgeInsets.all(0),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
