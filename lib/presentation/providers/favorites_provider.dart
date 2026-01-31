import 'package:flutter/material.dart';
import '../../data/repositories/favorites_repository.dart';
import '../../data/models/character.dart';

class FavoritesProvider with ChangeNotifier {
  final FavoritesRepository _repository = FavoritesRepository();
  List<Character> _favorites = [];
  String _sortBy = 'name'; // name или status
  
  List<Character> get favorites {
    final sorted = List<Character>.from(_favorites);
    
    if (_sortBy == 'name') {
      sorted.sort((a, b) => a.name.compareTo(b.name));
    } else if (_sortBy == 'status') {
      sorted.sort((a, b) => a.status.compareTo(b.status));
    }
    
    return sorted;
  }
  
  FavoritesProvider() {
    loadFavorites();
  }
  
  Future<void> loadFavorites() async {
    _favorites = await _repository.getFavorites();
    notifyListeners();
  }
  
  Future<void> removeFavorite(int characterId) async {
    await _repository.removeFromFavorites(characterId);
    await loadFavorites();
  }
  
  void sortByName() {
    _sortBy = 'name';
    notifyListeners();
  }
  
  void sortByStatus() {
    _sortBy = 'status';
    notifyListeners();
  }
}