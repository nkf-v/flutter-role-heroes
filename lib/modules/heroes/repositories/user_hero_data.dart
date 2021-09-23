import 'package:role_heroes/models/attribute.dart';
import 'package:role_heroes/models/characteristic/characteristic.dart';
import 'package:role_heroes/modules/heroes/models/user_hero.dart';
import 'package:role_heroes/repository/user_heroes.dart';

import 'base.dart';

class UserHeroDataRepository extends BaseRepository implements IUserHeroDataRepository {
  @override
  Future updateCharacteristic(UserHero hero, Characteristic characteristic) async {
    final Map response = await this.apiClient.updateHeroCharacteristicValue(
      await this.accessTokenStorage.getValue(),
      hero.id,
      characteristic.id,
      {
        'value': characteristic.value,
      },
    );

    return checkSuccessResponse(response);
  }

  @override
  Future updateAttribute(UserHero hero, Attribute attribute) async {
    final response = await this.apiClient.updateHeroAttributeValue(
      await this.accessTokenStorage.getValue(),
      hero.id,
      attribute.id,
      {
        'value': attribute.value,
      }
    );

    return checkSuccessResponse(response);
  }
}
