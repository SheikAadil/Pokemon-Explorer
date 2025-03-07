import 'package:flutter/material.dart';

class PokemonCard extends StatelessWidget {
  final String name;
  final String url;
  final bool isCaught;
  final VoidCallback onCatchToggle;

  const PokemonCard({
    Key? key,
    required this.name,
    required this.url,
    required this.isCaught,
    required this.onCatchToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(url, height: 100, width: 100),
          Text(name, style: const TextStyle(fontSize: 18)),
          ElevatedButton(
            onPressed: onCatchToggle,
            child: Text(isCaught ? 'Release' : 'Catch'),
          ),
        ],
      ),
    );
  }
}
