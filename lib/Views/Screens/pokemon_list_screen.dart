import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pokemon_explorer/ViewModels/pokemon_list_viewmodel.dart';
import 'package:pokemon_explorer/Views/Widgets/pokemon_card.dart';

class PokemonListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<PokemonListViewModel>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Pokémon Explorer')),
      body: viewModel.isLoading
          ? const Center(child: CircularProgressIndicator())
          : viewModel.errorMessage.isNotEmpty
              ? Center(child: Text(viewModel.errorMessage))
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        onChanged: viewModel.filterPokemons,
                        decoration: const InputDecoration(
                          labelText: 'Search Pokémon',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.search),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Caught Pokémon: ${viewModel.caughtPokemons.join(', ')}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount: viewModel.filteredPokemonsList.length,
                        itemBuilder: (context, index) {
                          final pokemon = viewModel.filteredPokemonsList[index];
                          return PokemonCard(
                            name: pokemon.name,
                            url: pokemon.imageUrl,
                            isCaught:
                                viewModel.caughtPokemons.contains(pokemon.name),
                            onCatchToggle: () =>
                                viewModel.toggleCatch(pokemon.name),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
  }
}
