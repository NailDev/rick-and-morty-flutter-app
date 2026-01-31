import 'package:flutter/material.dart';
import '../../data/repositories/character_repository.dart';
import '../../data/repositories/favorites_repository.dart';
import '../../data/models/character.dart';

class CharacterProvider with ChangeNotifier {
  final CharacterRepository _characterRepository = CharacterRepository();
  final FavoritesRepository _favoritesRepository = FavoritesRepository();
  
  final List<Character> _characters = [];
  bool _isLoading = false;
  bool _hasMore = true;
  int _currentPage = 1;
  
  List<Character> get characters => _characters;
  bool get isLoading => _isLoading;
  bool get hasMore => _hasMore;
  
  CharacterProvider() {
    loadCharacters();
  }
  
  Future<void> loadCharacters() async {
    if (_isLoading || !_hasMore) return;
    
    _isLoading = true;
    notifyListeners();
    
    try {
      final newCharacters = await _characterRepository.getCharacters(_currentPage);
      
      if (newCharacters.isEmpty) {
        _hasMore = false;
      } else {
        // Обновляем статусы избранного
        for (var character in newCharacters) {
          character.isFavorite = await _favoritesRepository.isFavorite(character.id);
        }
        
        // Добавляем только уникальные персонажи
        final existingIds = _characters.map((c) => c.id).toSet();
        final uniqueNewCharacters = newCharacters
            .where((character) => !existingIds.contains(character.id))
            .toList();
        
        _characters.addAll(uniqueNewCharacters);
        _currentPage++;
      }
    } catch (e) {
      print('Error loading characters: $e');
    }
    
    _isLoading = false;
    notifyListeners();
  }
  
  Future<void> toggleFavorite(Character character) async {
    final index = _characters.indexWhere((c) => c.id == character.id);
    
    if (index != -1) {
      if (character.isFavorite) {
        await _favoritesRepository.removeFromFavorites(character.id);
      } else {
        await _favoritesRepository.addToFavorites(character);
      }
      
      _characters[index] = Character(
        id: character.id,
        name: character.name,
        status: character.status,
        species: character.species,
        gender: character.gender,
        image: character.image,
        location: character.location,
        isFavorite: !character.isFavorite,
      );
      
      notifyListeners();
    }
  }
  
  Future<void> refresh() async {
    _characters.clear();
    _currentPage = 1;
    _hasMore = true;
    _isLoading = false;
    await loadCharacters();
  }
}