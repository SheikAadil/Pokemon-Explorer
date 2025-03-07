import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:pokemon_explorer/Models/pokemon_info_model.dart';

class ApiService {
  static Future<List<PokemonInfoModel>> getPokemonInfo() async {
    List<PokemonInfoModel> pokemons = [];
    final response =
        await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon?limit=20'));
    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> list = jsonResponse['results'];
      for (var e in list) {
        pokemons.add(PokemonInfoModel(
          name: e['name'] ?? '',
          imageUrl: e['url'] ?? '',
        ));
      }
    }
    return pokemons;
  }
}
