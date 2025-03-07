import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_explorer/ViewModels/pokemon_list_viewmodel.dart';
import 'package:pokemon_explorer/Views/Screens/pokemon_list_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => PokemonListViewModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokémon Explorer',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PokemonListScreen(),
    );
  }
}
