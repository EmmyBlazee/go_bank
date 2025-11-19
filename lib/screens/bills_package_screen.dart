import 'package:flutter/material.dart';
import 'package:go_bank/app_routes.dart';
import '../colors.dart';

class BillsPackageScreen extends StatefulWidget {
  final Map<String, dynamic> selectedCategory;
  final Map<String, String> selectedProvider;

  const BillsPackageScreen({
    super.key,
    required this.selectedCategory,
    required this.selectedProvider,
  });

  @override
  State<BillsPackageScreen> createState() => _BillsPackageScreenState();
}

class _BillsPackageScreenState extends State<BillsPackageScreen> {
  List<Map<String, dynamic>> _packages = [];

  @override
  void initState() {
    super.initState();
    _initializePackages();
  }

  void _initializePackages() {
    switch (widget.selectedCategory['name']) {
      case 'Cable TV':
        if (widget.selectedProvider['name'] == 'DSTV') {
          _packages = [
            {
              'name': 'DSTV Padi',
              'price': 1850,
              'description': 'Entertainment package'
            },
            {
              'name': 'DSTV Yanga',
              'price': 2565,
              'description': 'Complete entertainment'
            },
            {
              'name': 'DSTV Confam',
              'price': 4615,
              'description': 'Family entertainment'
            },
            {
              'name': 'DSTV Compact',
              'price': 7900,
              'description': 'Premium channels'
            },
            {
              'name': 'DSTV Compact Plus',
              'price': 12400,
              'description': 'More premium channels'
            },
            {
              'name': 'DSTV Premium',
              'price': 18400,
              'description': 'All channels'
            },
          ];
        } else if (widget.selectedProvider['name'] == 'GOTV') {
          _packages = [
            {
              'name': 'GOTV Smallie',
              'price': 800,
              'description': 'Basic entertainment'
            },
            {
              'name': 'GOTV Jinja',
              'price': 1900,
              'description': 'More channels'
            },
            {
              'name': 'GOTV Jolli',
              'price': 2460,
              'description': 'Family package'
            },
            {
              'name': 'GOTV Max',
              'price': 3200,
              'description': 'Premium package'
            },
            {
              'name': 'GOTV Supa',
              'price': 5000,
              'description': 'All GOTV channels'
            },
          ];
        } else if (widget.selectedProvider['name'] == 'StarTimes') {
          _packages = [
            {'name': 'Nova', 'price': 900, 'description': 'Basic package'},
            {'name': 'Basic', 'price': 1300, 'description': 'Standard package'},
            {'name': 'Smart', 'price': 1900, 'description': 'Premium package'},
            {
              'name': 'Classic',
              'price': 2600,
              'description': 'Complete package'
            },
            {'name': 'Unique', 'price': 3800, 'description': 'All channels'},
          ];
        }
        break;
      case 'Electricity':
        _packages = [
          {
            'name': 'Prepaid Meter',
            'price': 0,
            'description': 'Pay as you go'
          },
          {
            'name': 'Postpaid Meter',
            'price': 0,
            'description': 'Monthly billing'
          },
        ];
        break;
      case 'Internet':
        if (widget.selectedProvider['name'] == 'Spectranet') {
          _packages = [
            {'name': '1 Month', 'price': 0, 'description': 'Custom amount'},
            {'name': '3 Months', 'price': 0, 'description': 'Custom amount'},
            {'name': '6 Months', 'price': 0, 'description': 'Custom amount'},
            {'name': '12 Months', 'price': 0, 'description': 'Custom amount'},
          ];
        }
        break;
      case 'Water':
        _packages = [
          {
            'name': 'Water Bill Payment',
            'price': 0,
            'description': 'Custom amount'
          },
        ];
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.selectedProvider['name']!),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 32),
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      widget.selectedProvider['logo']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.primary,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.selectedProvider['name']!,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      'Choose Package',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 32),
            const Text(
              'Select Package',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Choose your preferred package',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: _packages.length,
                itemBuilder: (context, index) {
                  final package = _packages[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      title: Text(
                        package['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      subtitle: Text(
                        package['description'],
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                      trailing: package['price'] > 0
                          ? Text(
                              '₦${package['price']}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: AppColors.primary,
                              ),
                            )
                          : const Text(
                              'Custom',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey,
                              ),
                            ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.billsSmartcard,
                          arguments: {
                            'selectedCategory': widget.selectedCategory,
                            'selectedProvider': widget.selectedProvider,
                            'selectedPackage': package
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
