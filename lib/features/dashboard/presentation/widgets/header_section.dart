import 'package:flutter/material.dart';

import 'month_filter_drop_down.dart';

class HeaderSection extends StatelessWidget {
  final String? filterMonth;
  final ValueChanged<String?> onFilterChanged;

  const HeaderSection({
    super.key,
    this.filterMonth,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Row(
          children: [
            CircleAvatar(
              radius: 22,
              backgroundImage: NetworkImage(
                'https://plus.unsplash.com/premium_photo-1690086519096-0594592709d3?fm=jpg&q=60&w=3000&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NXx8ZmVtYWxlJTIwYXZhdGFyfGVufDB8fDB8fHww',
              ),
            ),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good Morning',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Shihab Rahman',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
        // Month dropdown
        MonthFilterDropdown( value: filterMonth,
          onChanged: onFilterChanged,),
      ],
    );
  }
}
