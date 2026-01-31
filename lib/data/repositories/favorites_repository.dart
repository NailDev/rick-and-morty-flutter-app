import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/character.dart';

class FavoritesRepository {
  static const String _favoritesKey = 'favorites';
  
  Future<List<Character>> getFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_favoritesKey);
    
    if (jsonString == null || jsonString.isEmpty) {
      return [];
    }
    
    try {
      final List<dynamic> jsonList = json.decode(jsonString);
      return jsonList.map((json) => Character.fromMap(json)).toList();
    } catch (e) {
      return [];
    }
  }
  
  Future<void> addToFavorites(Character character) async {
    final favorites = await getFavorites();
    
    if (!favorites.any((c) => c.id == character.id)) {
      final updatedCharacter = Character(
        id: character.id,
        name: character.name,
        status: character.status,
        species: character.species,
        gender: character.gender,
        image: character.image,
        location: character.location,
        isFavorite: true,
      );
      favorites.add(updatedCharacter);
      await _saveFavorites(favorites);
    }
  }
  
  Future<void> removeFromFavorites(int characterId) async {
    final favorites = await getFavorites();
    favorites.removeWhere((character) => character.id == characterId);
    await _saveFavorites(favorites);
  }
  
  Future<bool> isFavorite(int characterId) async {
    final favorites = await getFavorites();
    return favorites.any((character) => character.id == characterId);
  }
  
  Future<void> _saveFavorites(List<Character> favorites) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = favorites.map((character) => character.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await prefs.setString(_favoritesKey, jsonString);
  }
}