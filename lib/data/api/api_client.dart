import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/character.dart';

class ApiClient {
  static const String _baseUrl = 'https://rickandmortyapi.com/api';
  
  Future<List<Character>> getCharacters({int page = 1}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/character?page=$page'),
      ).timeout(const Duration(seconds: 10));
      
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List;
        return results.map((json) => Character.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load characters: ${response.statusCode}');
      }
    } catch (e) {
      print('API Error: $e');
      // Возвращаем тестовые данные если API не доступно
      return _getMockCharacters(page);
    }
  }
  
  // Тестовые данные если API недоступно (20 персонажей)
  List<Character> _getMockCharacters(int page) {
    if (page == 1) {
      return [
        Character(id: 1, name: 'Rick Sanchez', status: 'Alive', species: 'Human', gender: 'Male', image: 'https://avatars.mds.yandex.net/i?id=fd013fcff1749f59952f4b25e58f5ddfed2d31a3-4481820-images-thumbs&n=13', location: 'Earth (C-137)'),
        Character(id: 2, name: 'Morty Smith', status: 'Alive', species: 'Human', gender: 'Male', image: 'https://static0.srcdn.com/wordpress/wp-content/uploads/2020/11/morty-fear-face.jpg?w=1600&h=900&fit=crop', location: 'Earth (C-137)'),
        Character(id: 3, name: 'Summer Smith', status: 'Alive', species: 'Human', gender: 'Female', image: 'https://avatars.mds.yandex.net/get-entity_search/2102351/1229010692/S600xU_2x', location: 'Earth (Replacement Dimension)'),
        Character(id: 4, name: 'Beth Smith', status: 'Alive', species: 'Human', gender: 'Female', image: 'https://avatars.mds.yandex.net/i?id=76afe80c55d88a8e35cbaf6a2e009ecd_l-12650537-images-thumbs&n=13', location: 'Earth (Replacement Dimension)'),
        Character(id: 5, name: 'Jerry Smith', status: 'Alive', species: 'Human', gender: 'Male', image: 'https://i.pinimg.com/736x/37/56/04/375604c31beb10c354b7e30c147ad15d.jpg', location: 'Earth (Replacement Dimension)'),
        Character(id: 6, name: 'Abadango Cluster Princess', status: 'Alive', species: 'Alien', gender: 'Female', image: 'https://avatars.mds.yandex.net/i?id=726e2d7685e4ecac845876f360b68583_l-8186184-images-thumbs&n=13', location: 'Abadango'),
        Character(id: 7, name: 'Abradolf Lincler', status: 'unknown', species: 'Human', gender: 'Male', image: 'https://i.imgur.com/gBRiCv4.jpeg?fb', location: 'Testicle Monster dimension'),
        Character(id: 8, name: 'Adjudicator Rick', status: 'Dead', species: 'Human', gender: 'Male', image: 'https://ipfs.io/ipfs/QmPfR76uhBDCZsicEWAxsmnRF2RWE5Zmihc6eAF7Kk9a1r', location: 'Citadel of Ricks'),
        Character(id: 9, name: 'Agency Director', status: 'Dead', species: 'Human', gender: 'Male', image: 'https://avatars.mds.yandex.net/i?id=38627a3b7647e953b2b1c8bb612431c3122cf355-17021924-images-thumbs&n=13', location: 'Earth (Replacement Dimension)'),
        Character(id: 10, name: 'Alan Rails', status: 'Dead', species: 'Human', gender: 'Male', image: 'https://avatars.mds.yandex.net/i?id=a05f27bde992239fb8a1b0e374864124_l-5240761-images-thumbs&n=13', location: "Worldender's lair"),
        Character(id: 11, name: 'Albert Einstein', status: 'Dead', species: 'Human', gender: 'Male', image: 'https://i.redd.it/g79egf4bnm5z.png', location: 'Earth (Replacement Dimension)'),
        Character(id: 12, name: 'Alexander', status: 'Dead', species: 'Human', gender: 'Male', image: 'https://avatars.mds.yandex.net/i?id=1a6531dced01caf246e335973b57f170_sr-12923036-images-thumbs&n=13', location: 'Anatomy Park'),
        Character(id: 13, name: 'Alien Googah', status: 'unknown', species: 'Alien', gender: 'unknown', image: 'https://avatars.mds.yandex.net/i?id=5678050e396cf4b68277a3c70f81463c1babf3f9-5204674-images-thumbs&n=13', location: 'Earth (Replacement Dimension)'),
        Character(id: 14, name: 'Alien Morty', status: 'unknown', species: 'Alien', gender: 'Male', image: 'https://static.wikia.nocookie.net/characters/images/c/cf/Alien_Morty.jpeg/revision/latest?cb=20200105140141', location: 'Citadel of Ricks'),
        Character(id: 15, name: 'Alien Rick', status: 'unknown', species: 'Alien', gender: 'Male', image: 'https://avatars.mds.yandex.net/i?id=dc2b62d803b3d3a2c80ee5fab0243816_l-12184992-images-thumbs&n=13', location: 'Citadel of Ricks'),
        Character(id: 16, name: 'Amish Cyborg', status: 'Dead', species: 'Alien', gender: 'Male', image: 'https://images-cdn.9gag.com/photo/axgR2nL_700b.jpg', location: 'Earth (Replacement Dimension)'),
        Character(id: 17, name: 'Annie', status: 'Alive', species: 'Human', gender: 'Female', image: 'https://avatars.mds.yandex.net/i?id=e48eaa7d5d9da7de462b7d71ec7beb83_l-5235019-images-thumbs&n=13', location: 'Anatomy Park'),
        Character(id: 18, name: 'Antenna Morty', status: 'Alive', species: 'Human', gender: 'Male', image: 'https://avatars.mds.yandex.net/i?id=d85d361537bbfee46590fa8adb6b6ffc74ecd389-7744452-images-thumbs&n=13', location: 'Citadel of Ricks'),
        Character(id: 19, name: 'Antenna Rick', status: 'unknown', species: 'Human', gender: 'Male', image: 'https://avatars.mds.yandex.net/i?id=81dc0dd6b84dd73e966a9af5a7eda4c5_l-5300097-images-thumbs&n=13', location: 'unknown'),
        Character(id: 20, name: 'Ants in my Eyes Johnson', status: 'unknown', species: 'Human', gender: 'Male', image: 'https://avatars.mds.yandex.net/i?id=b303c72b14c454acb66d23d9391e199a_l-5324628-images-thumbs&n=13', location: 'Interdimensional Cable'),
      ];
    } else if (page == 2) {
      return [
        Character(id: 21, name: 'Aqua Morty', status: 'unknown', species: 'Humanoid', gender: 'Male', image: 'https://avatars.mds.yandex.net/i?id=c72264cdb6faac831bd9fa763cbf09dd6cf6b76c-4272017-images-thumbs&n=13', location: 'Citadel of Ricks'),
        Character(id: 22, name: 'Aqua Rick', status: 'unknown', species: 'Humanoid', gender: 'Male', image: 'https://avatars.mds.yandex.net/i?id=1197331f6b0e8b1b6f582c68274fe546bccdfcbe-5233099-images-thumbs&n=13', location: 'Citadel of Ricks'),
        Character(id: 23, name: 'Arcade Alien', status: 'unknown', species: 'Alien', gender: 'Male', image: 'https://avatars.mds.yandex.net/i?id=6c10fd0a8cd4e2aeee465168f30c07272db68e9d-5875861-images-thumbs&n=13', location: 'Immortality Field Resort'),
        Character(id: 24, name: 'Armagheadon', status: 'Alive', species: 'Alien', gender: 'Male', image: 'https://i.ytimg.com/vi/L0WA11s380I/maxresdefault.jpg', location: 'Signus 5 Expanse'),
        Character(id: 25, name: 'Armothy', status: 'Dead', species: 'unknown', gender: 'Male', image: 'https://avatars.mds.yandex.net/i?id=dd92612e9b24bf42c5bb8f9a30a759db_l-4961046-images-thumbs&n=13', location: 'Post-Apocalyptic Earth'),
        Character(id: 26, name: 'Arthricia', status: 'Alive', species: 'Alien', gender: 'Female', image: 'https://i.pinimg.com/originals/02/c7/a1/02c7a1af5000697674636d81e39862da.jpg', location: 'Purge Planet'),
        Character(id: 27, name: 'Artist Morty', status: 'Alive', species: 'Human', gender: 'Male', image: 'https://i.pinimg.com/originals/02/c7/a1/02c7a1af5000697674636d81e39862da.jpg', location: 'Citadel of Ricks'),
        Character(id: 28, name: 'Attila Starwar', status: 'Alive', species: 'Human', gender: 'Male', image: 'https://avatars.mds.yandex.net/i?id=6bd13cbaa666161c0bc8068a41cef22b4d13f800-13213257-images-thumbs&n=13', location: 'Interdimensional Cable'),
        Character(id: 29, name: 'Baby Legs', status: 'Alive', species: 'Human', gender: 'Male', image: 'https://i.ytimg.com/vi/-o0Qp5J_Oo8/maxresdefault.jpg?sqp=-oaymwEmCIAKENAF8quKqQMa8AEB-AH-CYAC0AWKAgwIABABGGUgWCg8MA8=&amp;rs=AOn4CLAjTRKzwYxruOY01DU6JReiokKjJQ', location: 'Interdimensional Cable'),
        Character(id: 30, name: 'Baby Poopybutthole', status: 'Alive', species: 'Poopybutthole', gender: 'Male', image: 'https://i.ytimg.com/vi/YRqtVaekU3E/maxres2.jpg?sqp=-oaymwEoCIAKENAF8quKqQMcGADwAQH4AbYIgAKAD4oCDAgAEAEYSyBfKGUwDw==&amp;rs=AOn4CLDiccBe4wwJQILspcFZLKB9e78orw', location: 'unknown'),
        Character(id: 31, name: 'Baby Wizard', status: 'Dead', species: 'Alien', gender: 'Male', image: 'https://i.imgur.com/3JBEwMV_d.webp?maxwidth=760&fidelity=grand', location: 'Earth (Replacement Dimension)'),
        Character(id: 32, name: 'Bearded Lady', status: 'Dead', species: 'Alien', gender: 'Female', image: 'https://static.wikia.nocookie.net/rickandmorty/images/4/47/Lucy.JPG/revision/latest?cb=20140415064550', location: 'Earth (Replacement Dimension)'),
        Character(id: 33, name: 'Beebo', status: 'Dead', species: 'Alien', gender: 'Male', image: 'https://static.wikia.nocookie.net/rickandmorty/images/9/96/Beebo.png/revision/latest?cb=20210127084617', location: 'Venzenulon 7'),
        Character(id: 34, name: 'Benjamin', status: 'Alive', species: 'Poopybutthole', gender: 'Male', image: 'https://yt3.googleusercontent.com/ytc/AIdro_mxHQ_ro24uPxMRmCHj7BEPRZp3sePGTmEE8umP6qLSaA=s900-c-k-c0x00ffffff-no-rj', location: 'Interdimensional Cable'),
        Character(id: 35, name: 'Bepisian', status: 'Alive', species: 'Alien', gender: 'unknown', image: 'https://avatars.mds.yandex.net/i?id=10b4668569b7fbad378480850b4e2ed6_sr-4168527-images-thumbs&n=13', location: 'Bepis 9'),
        Character(id: 36, name: 'Beta-Seven', status: 'Alive', species: 'Alien', gender: 'unknown', image: 'https://avatars.mds.yandex.net/i?id=1a02ef2ecc4352976be9b5234d1da335_l-12653839-images-thumbs&n=13', location: 'unknown'),
        Character(id: 37, name: 'Beth Sanchez', status: 'Alive', species: 'Human', gender: 'Female', image: 'https://i.pinimg.com/474x/79/31/2f/79312f71c22e65933d125b1a03291bd0.jpg?nii=t', location: 'Earth (C-137)'),
        Character(id: 38, name: 'Beth Smith', status: 'Alive', species: 'Human', gender: 'Female', image: 'https://i.pinimg.com/736x/79/77/d2/7977d2f4e30bf325fd6679b079ac1c36.jpg', location: 'Earth (C-137)'),
        Character(id: 39, name: 'Beth Smith', status: 'Alive', species: 'Human', gender: 'Female', image: 'https://i.pinimg.com/736x/79/77/d2/7977d2f4e30bf325fd6679b079ac1c36.jpg', location: 'Earth (Evil Rick\'s Target Dimension)'),
        Character(id: 40, name: "Beth's Mytholog", status: 'Dead', species: 'Mythological Creature', gender: 'Female', image: 'https://i.pinimg.com/736x/79/77/d2/7977d2f4e30bf325fd6679b079ac1c36.jpg', location: 'Nuptia 4'),
      ];
    } else {
      return []; // Для page > 2 возвращаем пустой список (конец пагинации)
    }
  }
}