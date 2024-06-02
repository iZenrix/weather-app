import 'package:flutter/material.dart';

class SearchCityField extends StatelessWidget {
  const SearchCityField({
    required this.cityNameController,
    required this.onSubmitted,
    super.key,
  });

  final TextEditingController cityNameController;
  final void Function(String) onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        width: MediaQuery.of(context).size.height * 0.4,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(99),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: TextField(
            controller: cityNameController,
            decoration: const InputDecoration(
              hintText: 'Enter City Name',
              border: InputBorder.none,
            ),
            onSubmitted: onSubmitted,
          ),
        ),
      ),
    );
  }
}
