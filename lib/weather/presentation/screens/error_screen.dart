import 'package:flutter/material.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({
    required this.cityNameController,
    required this.error,
    required this.onRetry,
    required this.onSubmit,
    super.key,
  });

  final TextEditingController cityNameController;
  final String error;
  final void Function(String) onSubmit;
  final void Function() onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(error),
          const SizedBox(height: 20),
          TextField(
            controller: cityNameController,
            decoration: const InputDecoration(
              hintText: 'Enter City Name',
            ),
            onSubmitted: onSubmit,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: onRetry,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}
