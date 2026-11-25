import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:hotel/src/core/widget/app_bar_ios_back_button.dart';
import 'package:hotel/src/core/themes/app_fonts.dart';

@RoutePage()
class RestaurantFloorPlanPage extends StatefulWidget {
  const RestaurantFloorPlanPage({Key? key}) : super(key: key);

  @override
  State<RestaurantFloorPlanPage> createState() => _RestaurantFloorPlanPageState();
}

class _RestaurantFloorPlanPageState extends State<RestaurantFloorPlanPage> {
  // ValueNotifier to store selected item
  final ValueNotifier<Map<String, dynamic>?> selectedItem = ValueNotifier(null);

  @override
  void dispose() {
    selectedItem.dispose();
    super.dispose();
  }

  void _selectItem(String type, int number) {
    selectedItem.value = {
      'type': type,
      'number': number,
      'label': type == 'outdoor' ? 'Outdoor' : '$type $number',
    };

    // You can navigate to another page with this selection
    print('Selected: ${selectedItem.value}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: Text('Select Location'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: const AppBarIosBackButton(color: Colors.black),
      ),
      body: ValueListenableBuilder<Map<String, dynamic>?>(
        valueListenable: selectedItem,
        builder: (context, selected, child) {
          return Column(
            children: [
              // Selected Item Display
              if (selected != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.purple[100],
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.purple[300]!, width: 2),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.check_circle, color: Colors.purple[700]),
                      const SizedBox(width: 12),
                      Text(
                        'Selected: ${selected['label']}',
                        style: AppFonts.interStyle(
                          color: Colors.purple[900],
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Tables Section
                      _buildSectionHeader('Tables'),
                      const SizedBox(height: 12),
                      _buildTablesGrid(selected),
                      const SizedBox(height: 24),

                      // Rooms Section
                      _buildSectionHeader('Private Rooms'),
                      const SizedBox(height: 12),
                      _buildRoomsGrid(selected),
                      const SizedBox(height: 24),

                      // Outdoor Section
                      _buildSectionHeader('Outdoor Seating'),
                      const SizedBox(height: 12),
                      _buildOutdoorSection(selected),
                    ],
                  ),
                ),
              ),

              // Continue Button
              if (selected != null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to next page with selected value
                      // You can access selected item via selectedItem.value
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple[700],
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Continue',
                      style: AppFonts.interStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: AppFonts.interStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF2C3E50),
      ),
    );
  }

  Widget _buildTablesGrid(Map<String, dynamic>? selected) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        int tableNumber = index + 1;
        bool isSelected = selected != null &&
            selected['type'] == 'Table' &&
            selected['number'] == tableNumber;

        return _buildSelectableCard(
          tableNumber.toString(),
          'Table',
          tableNumber,
          isSelected,
        );
      },
    );
  }

  Widget _buildRoomsGrid(Map<String, dynamic>? selected) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1.5,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        int roomNumber = index + 1;
        bool isSelected = selected != null &&
            selected['type'] == 'Room' &&
            selected['number'] == roomNumber;

        return _buildSelectableCard(
          roomNumber.toString(),
          'Room',
          roomNumber,
          isSelected,
        );
      },
    );
  }

  Widget _buildOutdoorSection(Map<String, dynamic>? selected) {
    bool isSelected = selected != null && selected['type'] == 'outdoor';

    return GestureDetector(
      onTap: () => _selectItem('outdoor', 0),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 24),
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple[600] : Colors.teal[400],
          borderRadius: BorderRadius.circular(12),
          border: isSelected
              ? Border.all(color: Colors.purple[800]!, width: 3)
              : null,
          boxShadow: [
            BoxShadow(
              color: (isSelected ? Colors.purple : Colors.teal).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(
              Icons.deck,
              color: Colors.white,
              size: 32,
            ),
            const SizedBox(height: 8),
            Text(
              'Outdoor',
              style: AppFonts.interStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectableCard(
      String label,
      String type,
      int number,
      bool isSelected,
      ) {
    return GestureDetector(
      onTap: () => _selectItem(type, number),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.purple[600] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.purple[800]! : Colors.grey[300]!,
            width: isSelected ? 3 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? Colors.purple.withOpacity(0.3)
                  : Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            label,
            style: AppFonts.interStyle(
              color: isSelected ? Colors.white : Colors.grey[800],
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}