// import 'package:flutter_test/flutter_test.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:onfly/data/datasources/implementation/local/travel_remote_data_source_local.dart';
// import 'package:onfly/data/datasources/remote/local/travel_data_source_local.dart';
// import 'package:onfly/domain/entities/travel.dart';

// class MockHiveInterface extends Mock implements HiveInterface {}

// class MockHiveBox extends Mock implements Box {}

// void main() {
//   late TravelDataSourceLocal userDataSource;
//   final Travel travelTest = Travel(
//     id: 0,
//     title: 'CNF-BSB',
//     from: 'CNF',
//     to: 'BSB',
//     date: '10/10/2024',
//     boardingPass: '183BA',
//   );
//   MockHiveInterface mockHiveInterface;
//   MockHiveBox mockHiveBox;

//   setUp(() async {
//     mockHiveInterface = MockHiveInterface();
//     mockHiveBox = MockHiveBox();
//     userDataSource = RemoteTravelDataSourceLocal(mockHiveInterface);
//   });

//   test('should cache the movie details', () async {
//     //arrange
//     when(mockHiveInterface.openBox(any)).thenAnswer((_) async => mockHiveBox);
//     //act
//     await userDataSource.getTravelData(travel: travelTest);
//     //assert
//     verify(mockHiveBox.put('${movie.id}', tmovie));
//     verify(mockHiveInterface.openBox("MovieDetailedBox"));
//   });

//   test('Deve retornar os dados da viagem do banco local', () {
//     expect(userDataSource.getTravelData(travel: travelTest), travelTest);
//   });
// }
