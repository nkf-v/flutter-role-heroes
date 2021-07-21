import 'package:flutter/material.dart';
import 'package:role_heroes/app/heroes/widgets/field.dart';
import 'package:role_heroes/components/characteristics_builder.dart';
import 'package:role_heroes/controllers/user_hero.dart';
import 'package:role_heroes/models/attribute.dart';
import 'package:role_heroes/models/category/category.dart';
import 'package:role_heroes/models/user_hero/user_hero.dart';
import 'package:role_heroes/utils/value_types.dart';
import 'package:role_heroes/widgets/category_tab.dart';

abstract class IHeroDetailScreenBuilder {
  void reset();
  void build(UserHero hero, IUserHeroController controller);
  Map getResult();
}

class HeroDetailScreenBuilder extends IHeroDetailScreenBuilder {
  Map<CategoryTab, Widget> _mapCategoryToViews;

  @override
  void reset() {
    this._mapCategoryToViews = new Map<CategoryTab, Widget>();
  }

  @override
  void build(UserHero hero, IUserHeroController controller) {
    this.buildMainFieldsCategory(hero, controller);
    this.buildCharacteristicsCategory(hero, controller);
    this.buildAttributes(hero, controller);
  }

  @override
  Map<CategoryTab, Widget> getResult() {
    return this._mapCategoryToViews;
  }

  void buildMainFieldsCategory(UserHero hero, IUserHeroController controller) {
    final CategoryTab category = CategoryTab(
        category: Category(
            id: 0,
            name: 'Base fields'
        )
    );

    this._mapCategoryToViews[category] = Column(
      children: [
        Field(
          name: 'Name',
          type: StringType(),
          value: hero.name,
          setValue: (value) => controller.updateHero(
              hero.id,
              {'name': value},
            ),
        ),
        Field(
          name: 'Note',
          type: StringType(),
          value: hero.note,
          setValue: (value) => controller.updateHero(
              hero.id,
              {'note': value},
            )
        ),
      ],
    );
  }

  void buildCharacteristicsCategory(UserHero hero, IUserHeroController controller) {
    final CategoryTab category = CategoryTab(
      category: Category(
        id: 0,
        name: 'Characteristics',
      )
    );

    this._mapCategoryToViews[category] = CharacteristicsBuilder(hero: hero, controller: controller);
  }

  void buildAttributes(UserHero hero, IUserHeroController controller) {
    Map<Category, List<Attribute>> categoriesAttributes = Map.fromIterable(
        hero.attributes,
        key: (attribute) => attribute.category,
        value: (attribute) => []
    );
    hero.attributes.forEach((Attribute attribute) {
      categoriesAttributes[attribute.category].add(attribute);
    });
    categoriesAttributes.forEach((Category category, List<Attribute> attributes) {
      final CategoryTab categoryTab = CategoryTab(category: category);
      this._mapCategoryToViews[categoryTab] = ListView.builder(
        itemCount: attributes.length,
        itemBuilder: (context, index) {
          Attribute attribute = attributes.elementAt(index);
          return Field(
            name: attribute.name,
            type: attribute.type,
            value: attribute.value,
            setValue: (value) { return controller.updateHeroAttribute(hero.id, attribute.id, <String, dynamic>{'value': value}); },
          );
        }
      );
    });
  }

}
