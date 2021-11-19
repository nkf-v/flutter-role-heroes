import 'package:role_heroes/modules/heroes/models/user_hero.dart';
import 'package:role_heroes/modules/heroes/repositories/base.dart';
import 'package:role_heroes/modules/structural_attribute/models/structural_attribute.dart';
import 'package:role_heroes/modules/structural_attribute/models/structural_value.dart';
import 'package:role_heroes/repository/structural_attribute.dart';

class StructuralAttributeRepository extends BaseRepository implements IStructuralAttributeRepository {
  @override
  Future<List<StructuralValue>> getValues(StructuralAttribute attribute) async {
    final List data = await this.apiClient.getStructureAttributeValues(
      await this.accessTokenStorage.getValue(),
      attribute.id,
    );
    final List<StructuralValue> result = [];
    for (final Map datum in data)
      result.add(StructuralValue.fromData(datum));
    return result;
  }

  @override
  Future updateValues(UserHero userHero, StructuralAttribute attribute) async {
    await this.apiClient.setStructuralAttributeValues(
      await this.accessTokenStorage.getValue(),
      userHero.id,
      attribute.id,
      attribute.values.map<int>((StructuralValue value) => value.id).toList(),
    );
  }
}
