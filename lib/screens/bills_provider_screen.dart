import 'package:flutter/material.dart';
import 'package:go_bank/app_routes.dart';
import '../colors.dart';

class BillsProviderScreen extends StatefulWidget {
  final Map<String, dynamic> selectedCategory;

  const BillsProviderScreen({
    super.key,
    required this.selectedCategory,
  });

  @override
  State<BillsProviderScreen> createState() => _BillsProviderScreenState();
}

class _BillsProviderScreenState extends State<BillsProviderScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, String>> _providers = [];
  List<Map<String, String>> _filteredProviders = [];

  @override
  void initState() {
    super.initState();
    _initializeProviders();
    _filteredProviders = _providers;
    _searchController.addListener(_filterProviders);
  }

  void _initializeProviders() {
    switch (widget.selectedCategory['name']) {
      case 'Cable TV':
        _providers = [
          {'name': 'DSTV', 'logo': 'DSTV'},
          {'name': 'GOTV', 'logo': 'GOTV'},
          {'name': 'StarTimes', 'logo': 'ST'},
          {'name': 'Showmax', 'logo': 'SM'},
        ];
        break;
      case 'Electricity':
        _providers = [
          {'name': 'Eko Electricity', 'logo': 'EKO'},
          {'name': 'Ikeja Electricity', 'logo': 'IKEJA'},
          {'name': 'Abuja Electricity', 'logo': 'ABUJA'},
          {'name': 'Kano Electricity', 'logo': 'KANO'},
          {'name': 'Port Harcourt Electricity', 'logo': 'PH'},
          {'name': 'Kaduna Electricity', 'logo': 'KADUNA'},
        ];
        break;
      case 'Internet':
        _providers = [
          {'name': 'Spectranet', 'logo': 'SPECTRA'},
          {'name': 'Smile', 'logo': 'SMILE'},
          {'name': 'Swift Networks', 'logo': 'SWIFT'},
        ];
        break;
      case 'Water':
        _providers = [
          {'name': 'Lagos Water Corporation', 'logo': 'LWC'},
          {'name': 'Abuja Water Board', 'logo': 'AWB'},
        ];
        break;
    }
  }

  void _filterProviders() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProviders = _providers
          .where((provider) => provider['name']!.toLowerCase().contains(query))
          .toList();
    });
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
        title: Text(widget.selectedCategory['name']),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: widget.selectedCategory['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      widget.selectedCategory['icon'],
                      color: widget.selectedCategory['color'],
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.selectedCategory['name'],
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Choose Provider',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Select Provider',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Choose your preferred service provider',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search providers...',
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[300]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: AppColors.primary),
                  ),
                  filled: true,
                  fillColor: Colors.grey[50],
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _filteredProviders.length,
                itemBuilder: (context, index) {
                  final provider = _filteredProviders[index];
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            provider['logo']!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        provider['name']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      trailing: const Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.grey,
                        size: 16,
                      ),
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutes.billsPackage,
                          arguments: {
                            'selectedCategory': widget.selectedCategory,
                            'selectedProvider': provider
                          },
                        );
                      },
                    ),
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
