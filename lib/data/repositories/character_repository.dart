import '../api/api_client.dart';
import '../models/character.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class CharacterRepository {
  final ApiClient _apiClient = ApiClient();
  static const String _cacheKey = 'characters_cache';
  
  Future<List<Character>> getCharacters(int page) async {
    try {
      final characters = await _apiClient.getCharacters(page: page);
      await _cacheCharacters(characters, page);
      return characters;
    } catch (e) {
      return await _getCachedCharacters(page);
    }
  }
  
  Future<void> _cacheCharacters(List<Character> characters, int page) async {
    final prefs = await SharedPreferences.getInstance();
    final cache = await _getCache(prefs);
    
    for (var character in characters) {
      cache['${character.id}'] = character.toJson();
    }
    cache['last_page'] = page;
    
    await prefs.setString(_cacheKey, json.encode(cache));
  }
  
  Future<List<Character>> _getCachedCharacters(int page) async {
    final prefs = await SharedPreferences.getInstance();
    final cache = await _getCache(prefs);
    
    final cachedCharacters = cache.entries
        .where((entry) => entry.key != 'last_page')
        .map((entry) => Character.fromMap(entry.value))
        .toList();
    
    return cachedCharacters;
  }
  
  Future<Map<String, dynamic>> _getCache(SharedPreferences prefs) async {
    final jsonString = prefs.getString(_cacheKey);
    if (jsonString == null) return {};
    
    try {
      final Map<String, dynamic> cache = json.decode(jsonString);
      return cache;
    } catch (e) {
      return {};
    }
  }
}