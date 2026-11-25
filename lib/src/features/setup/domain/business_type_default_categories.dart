import 'package:hotel/src/core/constants/item_form_constants.dart';
import 'package:hotel/src/features/org/domain/organization_business_type.dart';

/// Default item categories seeded during org setup, tailored to business type.
abstract final class BusinessTypeDefaultCategories {
  static const initialCategoryCount = 10;

  static const _hotel = [
    'Accommodation',
    'Supplies - Toiletries',
    'Supplies - Cleaning',
    'Supplies - Hotel Maintenance',
    'Food - Breakfast',
    'Beverages - Tea & Coffee',
    'Beverages - Water & Juice',
    'Staff & HR',
    'Other Expenses',
    'Misc / Services',
  ];

  static const _restaurant = [
    'Food - Main Course (Chicken)',
    'Food - Main Course (Veg)',
    'Food - Momo',
    'Food - Fried Rice & Noodles',
    'Food - Thali & Khaja Set',
    'Food - Snacks (Veg)',
    'Beverages - Soft Drinks',
    'Raw Materials - Vegetables',
    'Staff & HR',
    'Other Expenses',
  ];

  static const _hotelRestaurant = [
    'Accommodation',
    'Food - Main Course (Chicken)',
    'Food - Main Course (Veg)',
    'Food - Momo',
    'Food - Breakfast',
    'Food - Thali & Khaja Set',
    'Beverages - Tea & Coffee',
    'Beverages - Soft Drinks',
    'Staff & HR',
    'Other Expenses',
  ];

  static const _retail = [
    'Misc / Services',
    'Supplies - Stationery & Misc',
    'Beverages - Soft Drinks',
    'Beverages - Water & Juice',
    'Food - Snacks (Veg)',
    'Food - Snacks (Non-Veg)',
    'Supplies - Cleaning',
    'Raw Materials - Dry Goods',
    'Staff & HR',
    'Other Expenses',
  ];

  static const _cafe = [
    'Beverages - Tea & Coffee',
    'Beverages - Lassi',
    'Food - Breakfast',
    'Food - Snacks (Veg)',
    'Raw Materials - Dairy & Eggs',
    'Raw Materials - Dry Goods',
    'Raw Materials - Fruits',
    'Staff & HR',
    'Other Expenses',
    'Misc / Services',
  ];

  static const _bar = [
    'Beverages - Beer',
    'Liquors',
    'Wine',
    'Beverages - Soft Drinks',
    'Smoking',
    'Food - Snacks (Non-Veg)',
    'Hookah Supplies',
    'Staff & HR',
    'Other Expenses',
    'Misc / Services',
  ];

  static const _other = [
    'Misc / Services',
    'Beverages - Soft Drinks',
    'Beverages - Water & Juice',
    'Food - Snacks (Veg)',
    'Food - Snacks (Non-Veg)',
    'Supplies - Cleaning',
    'Supplies - Stationery & Misc',
    'Raw Materials - Dry Goods',
    'Staff & HR',
    'Other Expenses',
  ];

  static List<String> forBusinessType(String? businessType) {
    final type = OrganizationBusinessType.normalize(businessType);
    final names = switch (type) {
      OrganizationBusinessType.hotel => _hotel,
      OrganizationBusinessType.restaurant => _restaurant,
      OrganizationBusinessType.hotelRestaurant => _hotelRestaurant,
      OrganizationBusinessType.retail => _retail,
      OrganizationBusinessType.cafe => _cafe,
      OrganizationBusinessType.bar => _bar,
      OrganizationBusinessType.other => _other,
      _ => _other,
    };

    assert(
      names.length == initialCategoryCount,
      'Each business type must seed exactly $initialCategoryCount categories',
    );
    assert(
      names.every(ItemFormConstants.categories.contains),
      'Every default category must exist in ItemFormConstants.categories',
    );

    return List.unmodifiable(names);
  }
}
