import 'package:adventofcode2021/src/day16.dart';
import 'package:test/test.dart';

void main() {
  group('day 16', () {
    test('packet - literal value - initializes new packet', () {
      final puzzleInput = 'D2FE28';
      final binary = Day16().parseBinary(puzzleInput);

      final packet = Packet(binary);

      expect(packet.literalValue, equals(2021));
      expect(packet.subPackets, isEmpty);
      expect(packet.version, equals(6));
      expect(packet.typeId, equals(4));
      expect(packet.notUsedRawBinaryContent, equals('000'));
    });

    test('packet - operator with lenght type id zero - initializes new packet', () {
      final puzzleInput = '38006F45291200';
      final binary = Day16().parseBinary(puzzleInput);

      final packet = Packet(binary);

      expect(packet.subPackets, isNotEmpty);
      expect(packet.subPackets.length, 2);
      expect(packet.version, equals(1));
      expect(packet.typeId, equals(6));
      expect(packet.notUsedRawBinaryContent, equals('0000000'));
    });

    test('packet - operator with lenght type id one - initializes new packet', () {
      final puzzleInput = 'EE00D40C823060';
      final binary = Day16().parseBinary(puzzleInput);

      final packet = Packet(binary);

      expect(packet.subPackets, isNotEmpty);
      expect(packet.subPackets.length, 3);
      expect(packet.version, equals(7));
      expect(packet.typeId, equals(3));
      expect(packet.notUsedRawBinaryContent, equals('00000'));
    });

    test('solveFirstPuzzle - first example input - returns expected result', () {
      final puzzleInput = '8A004A801A8002F478';
      final day = Day16();

      final solution = day.solveFirstPuzzle(puzzleInput);

      expect(solution, equals('16'));
    });

    test('solveFirstPuzzle - second example input - returns expected result', () {
      final puzzleInput = '620080001611562C8802118E34';
      final day = Day16();

      final solution = day.solveFirstPuzzle(puzzleInput);

      expect(solution, equals('12'));
    });

    test('solveFirstPuzzle - thrid example input - returns expected result', () {
      final puzzleInput = 'C0015000016115A2E0802F182340';
      final day = Day16();

      final solution = day.solveFirstPuzzle(puzzleInput);

      expect(solution, equals('23'));
    });

    test('solveFirstPuzzle - fourth example input - returns expected result', () {
      final puzzleInput = 'A0016C880162017C3686B18A3D4780';
      final day = Day16();

      final solution = day.solveFirstPuzzle(puzzleInput);

      expect(solution, equals('31'));
    });

    test('solveSecondPuzzle - sum example input - returns expected result', () {
      final puzzelInput = 'C200B40A82';
      final day = Day16();

      final solution = day.solveSecondPuzzle(puzzelInput);

      expect(solution, equals('3'));
    });

    test('solveSecondPuzzle - product example input - returns expected result', () {
      final puzzelInput = '04005AC33890';
      final day = Day16();

      final solution = day.solveSecondPuzzle(puzzelInput);

      expect(solution, equals('54'));
    });

    test('solveSecondPuzzle - minimum example input - returns expected result', () {
      final puzzelInput = '880086C3E88112';
      final day = Day16();

      final solution = day.solveSecondPuzzle(puzzelInput);

      expect(solution, equals('7'));
    });

    test('solveSecondPuzzle - maximum example input - returns expected result', () {
      final puzzelInput = 'CE00C43D881120';
      final day = Day16();

      final solution = day.solveSecondPuzzle(puzzelInput);

      expect(solution, equals('9'));
    });

    test('solveSecondPuzzle - less example input - returns expected result', () {
      final puzzelInput = 'D8005AC2A8F0';
      final day = Day16();

      final solution = day.solveSecondPuzzle(puzzelInput);

      expect(solution, equals('1'));
    });

    test('solveSecondPuzzle - greater example input - returns expected result', () {
      final puzzelInput = 'F600BC2D8F';
      final day = Day16();

      final solution = day.solveSecondPuzzle(puzzelInput);

      expect(solution, equals('0'));
    });

    test('solveSecondPuzzle - equal example input - returns expected result', () {
      final puzzelInput = '9C005AC2F8F0';
      final day = Day16();

      final solution = day.solveSecondPuzzle(puzzelInput);

      expect(solution, equals('0'));
    });

    test('solveSecondPuzzle - combination example input - returns expected result', () {
      final puzzelInput = '9C0141080250320F1802104A08';
      final day = Day16();

      final solution = day.solveSecondPuzzle(puzzelInput);

      expect(solution, equals('1'));
    });
  });
}
