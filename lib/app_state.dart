import 'package:flutter/material.dart';
import '/backend/backend.dart';
import 'backend/api_requests/api_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'troka/troka_util.dart';

class FFAppState extends ChangeNotifier {
  static FFAppState _instance = FFAppState._internal();

  factory FFAppState() {
    return _instance;
  }

  FFAppState._internal();

  static void reset() {
    _instance = FFAppState._internal();
  }

  Future initializePersistedState() async {}

  void update(VoidCallback callback) {
    callback();
    notifyListeners();
  }

  String _objectIdSelected = '';
  String get objectIdSelected => _objectIdSelected;
  set objectIdSelected(String _value) {
    _objectIdSelected = _value;
  }

  bool _editPhotoAvailable = false;
  bool get editPhotoAvailable => _editPhotoAvailable;
  set editPhotoAvailable(bool _value) {
    _editPhotoAvailable = _value;
  }

  String _photo0 =
      'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25';
  String get photo0 => _photo0;
  set photo0(String _value) {
    _photo0 = _value;
  }

  String _photo1 =
      'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/fotocapa.png?alt=media&token=92a864b8-6df4-4f8a-a837-4837187d8e3f';
  String get photo1 => _photo1;
  set photo1(String _value) {
    _photo1 = _value;
  }

  String _photo2 =
      'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25';
  String get photo2 => _photo2;
  set photo2(String _value) {
    _photo2 = _value;
  }

  String _photo3 =
      'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25';
  String get photo3 => _photo3;
  set photo3(String _value) {
    _photo3 = _value;
  }

  String _photo4 =
      'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25';
  String get photo4 => _photo4;
  set photo4(String _value) {
    _photo4 = _value;
  }

  String _photo5 =
      'https://firebasestorage.googleapis.com/v0/b/trokaproject.appspot.com/o/add-image.png?alt=media&token=46ceb940-d8bd-4290-8ef7-180190820a25';
  String get photo5 => _photo5;
  set photo5(String _value) {
    _photo5 = _value;
  }

  String _alteraFoto = '';
  String get alteraFoto => _alteraFoto;
  set alteraFoto(String _value) {
    _alteraFoto = _value;
  }

  bool _isFiltered = false;
  bool get isFiltered => _isFiltered;
  set isFiltered(bool _value) {
    _isFiltered = _value;
  }

  List<String> _listOfInterests = [];
  List<String> get listOfInterests => _listOfInterests;
  set listOfInterests(List<String> _value) {
    _listOfInterests = _value;
  }

  void addToListOfInterests(String _value) {
    _listOfInterests.add(_value);
  }

  void removeFromListOfInterests(String _value) {
    _listOfInterests.remove(_value);
  }

  void removeAtIndexFromListOfInterests(int _index) {
    _listOfInterests.removeAt(_index);
  }

  void updateListOfInterestsAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _listOfInterests[_index] = updateFn(_listOfInterests[_index]);
  }

  void insertAtIndexInListOfInterests(int _index, String _value) {
    _listOfInterests.insert(_index, _value);
  }

  List<String> _userFavoriteObjetcs = [];
  List<String> get userFavoriteObjetcs => _userFavoriteObjetcs;
  set userFavoriteObjetcs(List<String> _value) {
    _userFavoriteObjetcs = _value;
  }

  void addToUserFavoriteObjetcs(String _value) {
    _userFavoriteObjetcs.add(_value);
  }

  void removeFromUserFavoriteObjetcs(String _value) {
    _userFavoriteObjetcs.remove(_value);
  }

  void removeAtIndexFromUserFavoriteObjetcs(int _index) {
    _userFavoriteObjetcs.removeAt(_index);
  }

  void updateUserFavoriteObjetcsAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _userFavoriteObjetcs[_index] = updateFn(_userFavoriteObjetcs[_index]);
  }

  void insertAtIndexInUserFavoriteObjetcs(int _index, String _value) {
    _userFavoriteObjetcs.insert(_index, _value);
  }

  List<String> _citiesList = [];
  List<String> get citiesList => _citiesList;
  set citiesList(List<String> _value) {
    _citiesList = _value;
  }

  void addToCitiesList(String _value) {
    _citiesList.add(_value);
  }

  void removeFromCitiesList(String _value) {
    _citiesList.remove(_value);
  }

  void removeAtIndexFromCitiesList(int _index) {
    _citiesList.removeAt(_index);
  }

  void updateCitiesListAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _citiesList[_index] = updateFn(_citiesList[_index]);
  }

  void insertAtIndexInCitiesList(int _index, String _value) {
    _citiesList.insert(_index, _value);
  }

  double _lat = 0.0;
  double get lat => _lat;
  set lat(double _value) {
    _lat = _value;
  }

  double _lng = 0.0;
  double get lng => _lng;
  set lng(double _value) {
    _lng = _value;
  }

  String _cidadeViaLoc = '';
  String get cidadeViaLoc => _cidadeViaLoc;
  set cidadeViaLoc(String _value) {
    _cidadeViaLoc = _value;
  }

  String _filterUF = '';
  String get filterUF => _filterUF;
  set filterUF(String _value) {
    _filterUF = _value;
  }

  String _filterCity = '';
  String get filterCity => _filterCity;
  set filterCity(String _value) {
    _filterCity = _value;
  }

  String _filterObjectCategory = '';
  String get filterObjectCategory => _filterObjectCategory;
  set filterObjectCategory(String _value) {
    _filterObjectCategory = _value;
  }

  List<String> _filterObjectInterest = [];
  List<String> get filterObjectInterest => _filterObjectInterest;
  set filterObjectInterest(List<String> _value) {
    _filterObjectInterest = _value;
  }

  void addToFilterObjectInterest(String _value) {
    _filterObjectInterest.add(_value);
  }

  void removeFromFilterObjectInterest(String _value) {
    _filterObjectInterest.remove(_value);
  }

  void removeAtIndexFromFilterObjectInterest(int _index) {
    _filterObjectInterest.removeAt(_index);
  }

  void updateFilterObjectInterestAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _filterObjectInterest[_index] = updateFn(_filterObjectInterest[_index]);
  }

  void insertAtIndexInFilterObjectInterest(int _index, String _value) {
    _filterObjectInterest.insert(_index, _value);
  }

  bool _filterAnyCategoryInterest = false;
  bool get filterAnyCategoryInterest => _filterAnyCategoryInterest;
  set filterAnyCategoryInterest(bool _value) {
    _filterAnyCategoryInterest = _value;
  }

  List<String> _filterObjectCondition = [];
  List<String> get filterObjectCondition => _filterObjectCondition;
  set filterObjectCondition(List<String> _value) {
    _filterObjectCondition = _value;
  }

  void addToFilterObjectCondition(String _value) {
    _filterObjectCondition.add(_value);
  }

  void removeFromFilterObjectCondition(String _value) {
    _filterObjectCondition.remove(_value);
  }

  void removeAtIndexFromFilterObjectCondition(int _index) {
    _filterObjectCondition.removeAt(_index);
  }

  void updateFilterObjectConditionAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _filterObjectCondition[_index] = updateFn(_filterObjectCondition[_index]);
  }

  void insertAtIndexInFilterObjectCondition(int _index, String _value) {
    _filterObjectCondition.insert(_index, _value);
  }

  List<String> _defaultChoices = ['troka', 'doação'];
  List<String> get defaultChoices => _defaultChoices;
  set defaultChoices(List<String> _value) {
    _defaultChoices = _value;
  }

  void addToDefaultChoices(String _value) {
    _defaultChoices.add(_value);
  }

  void removeFromDefaultChoices(String _value) {
    _defaultChoices.remove(_value);
  }

  void removeAtIndexFromDefaultChoices(int _index) {
    _defaultChoices.removeAt(_index);
  }

  void updateDefaultChoicesAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _defaultChoices[_index] = updateFn(_defaultChoices[_index]);
  }

  void insertAtIndexInDefaultChoices(int _index, String _value) {
    _defaultChoices.insert(_index, _value);
  }

  List<String> _defaultObjectConditions = [
    'Novo',
    'Usado',
    'Recondicionado',
    'Com defeito'
  ];
  List<String> get defaultObjectConditions => _defaultObjectConditions;
  set defaultObjectConditions(List<String> _value) {
    _defaultObjectConditions = _value;
  }

  void addToDefaultObjectConditions(String _value) {
    _defaultObjectConditions.add(_value);
  }

  void removeFromDefaultObjectConditions(String _value) {
    _defaultObjectConditions.remove(_value);
  }

  void removeAtIndexFromDefaultObjectConditions(int _index) {
    _defaultObjectConditions.removeAt(_index);
  }

  void updateDefaultObjectConditionsAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _defaultObjectConditions[_index] =
        updateFn(_defaultObjectConditions[_index]);
  }

  void insertAtIndexInDefaultObjectConditions(int _index, String _value) {
    _defaultObjectConditions.insert(_index, _value);
  }

  String _filterChoice = '';
  String get filterChoice => _filterChoice;
  set filterChoice(String _value) {
    _filterChoice = _value;
  }

  bool _btnRecebidas = false;
  bool get btnRecebidas => _btnRecebidas;
  set btnRecebidas(bool _value) {
    _btnRecebidas = _value;
  }

  bool _btnEfetuadas = false;
  bool get btnEfetuadas => _btnEfetuadas;
  set btnEfetuadas(bool _value) {
    _btnEfetuadas = _value;
  }

  bool _btnEnviadas = false;
  bool get btnEnviadas => _btnEnviadas;
  set btnEnviadas(bool _value) {
    _btnEnviadas = _value;
  }

  String _objectInterestUid = '';
  String get objectInterestUid => _objectInterestUid;
  set objectInterestUid(String _value) {
    _objectInterestUid = _value;
  }

  String _objectInterestPhoto = '';
  String get objectInterestPhoto => _objectInterestPhoto;
  set objectInterestPhoto(String _value) {
    _objectInterestPhoto = _value;
  }

  String _objectInterestTitle = '';
  String get objectInterestTitle => _objectInterestTitle;
  set objectInterestTitle(String _value) {
    _objectInterestTitle = _value;
  }

  String _objectInterestCategory = '';
  String get objectInterestCategory => _objectInterestCategory;
  set objectInterestCategory(String _value) {
    _objectInterestCategory = _value;
  }

  String _objectInterestConditions = '';
  String get objectInterestConditions => _objectInterestConditions;
  set objectInterestConditions(String _value) {
    _objectInterestConditions = _value;
  }

  String _objectInterestCidade = '';
  String get objectInterestCidade => _objectInterestCidade;
  set objectInterestCidade(String _value) {
    _objectInterestCidade = _value;
  }

  String _objectInterestBairro = '';
  String get objectInterestBairro => _objectInterestBairro;
  set objectInterestBairro(String _value) {
    _objectInterestBairro = _value;
  }

  String _objectInterestId = '';
  String get objectInterestId => _objectInterestId;
  set objectInterestId(String _value) {
    _objectInterestId = _value;
  }

  String _objectCategorySelected = '';
  String get objectCategorySelected => _objectCategorySelected;
  set objectCategorySelected(String _value) {
    _objectCategorySelected = _value;
  }

  List<String> _objectCategoryInterests = [];
  List<String> get objectCategoryInterests => _objectCategoryInterests;
  set objectCategoryInterests(List<String> _value) {
    _objectCategoryInterests = _value;
  }

  void addToObjectCategoryInterests(String _value) {
    _objectCategoryInterests.add(_value);
  }

  void removeFromObjectCategoryInterests(String _value) {
    _objectCategoryInterests.remove(_value);
  }

  void removeAtIndexFromObjectCategoryInterests(int _index) {
    _objectCategoryInterests.removeAt(_index);
  }

  void updateObjectCategoryInterestsAtIndex(
    int _index,
    String Function(String) updateFn,
  ) {
    _objectCategoryInterests[_index] =
        updateFn(_objectCategoryInterests[_index]);
  }

  void insertAtIndexInObjectCategoryInterests(int _index, String _value) {
    _objectCategoryInterests.insert(_index, _value);
  }

  bool _objectAnyCategorySelected = false;
  bool get objectAnyCategorySelected => _objectAnyCategorySelected;
  set objectAnyCategorySelected(bool _value) {
    _objectAnyCategorySelected = _value;
  }
}
