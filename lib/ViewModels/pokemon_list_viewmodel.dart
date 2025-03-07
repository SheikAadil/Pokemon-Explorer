import 'package:flutter/material.dart';
import 'package:pokemon_explorer/Models/pokemon_info_model.dart';
import 'package:pokemon_explorer/Services/api_services.dart';

class PokemonListViewModel extends ChangeNotifier {
  List<PokemonInfoModel> pokemonsList = [];
  List<PokemonInfoModel> filteredPokemonsList = [];
  List<String> caughtPokemons = [];
  bool isLoading = true;
  String errorMessage = '';

  PokemonListViewModel() {
    fetchInfoData();
  }

  Future<void> fetchInfoData() async {
    try {
      List<PokemonInfoModel> fetchedInfoList =
          await ApiService.getPokemonInfo();
      pokemonsList = fetchedInfoList.map((pokemon) {
        final id = pokemon.imageUrl.split('/').reversed.elementAt(1);
        final imageUrl =
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/$id.png';
        return PokemonInfoModel(name: pokemon.name, imageUrl: imageUrl);
      }).toList();
      filteredPokemonsList = List.from(pokemonsList);
      isLoading = false;
      notifyListeners();
    } catch (e) {
      errorMessage = 'Failed to load Pokémon data.';
      isLoading = false;
      notifyListeners();
    }
  }

  void toggleCatch(String name) {
    if (caughtPokemons.contains(name)) {
      caughtPokemons.remove(name);
    } else {
      caughtPokemons.add(name);
    }
    notifyListeners();
  }

  void filterPokemons(String query) {
    filteredPokemonsList = pokemonsList
        .where((pokemon) =>
            pokemon.name.toLowerCase().contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }
}
