import 'package:cuidame/app/data/providers/dependences/home.dart';
import 'package:cuidame/app/data/providers/dependences/medication.dart';
import 'package:cuidame/app/data/providers/dependences/patient.dart';
import 'package:cuidame/app/data/providers/dependences/repository.dart';
import 'package:cuidame/app/data/providers/dependences/service.dart';
import 'package:cuidame/app/data/providers/dependences/start.dart';
import 'package:cuidame/app/data/providers/dependences/storage.dart';
import 'package:get/get.dart';

typedef FactoryFunc<T> = T Function();

class DependencesInjector {
  static final _locator = Get;

  static T get<T extends Object>({String? instanceName}) {
    return _locator.find(tag: instanceName);
  }

  static void registerFactory<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  }) {
    _locator.create(factoryFunc, tag: instanceName);
  }

  static void registerLazySingleton<T extends Object>(
    FactoryFunc<T> factoryFunc, {
    String? instanceName,
  }) {
    _locator.lazyPut(
      factoryFunc,
      tag: instanceName,
    );
  }

  static void setup() {
    setupStartInjections();
    setupRepositoryInjections();
    setupServiceInjection();
    setupHomeInjections();
    setupMedicationInjections();
    setupPatientInjections();
    setupStorageInjections();
  }
}
