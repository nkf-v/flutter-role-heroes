abstract class Client {
  Future login(Map data);
  Future register(Map data);
  Future logout(String token);
  Future refresh(String token);

  Future<List> games(String token);
  Future<List> userHeroes(String token, int gameId);
  Future<Map> userHero(String token, int heroId);
  Future createHero(String token, Map data);
  Future deleteHero(String token, int heroId);
  Future updateHero(String token, int heroId, Map data);

  Future updateHeroCharacteristicValue(String token, int heroId, int characteristicId, Map<String, dynamic> data);
  Future updateHeroAttributeValue(String token, int heroId, int attributeId, Map<String, dynamic> data);
}
