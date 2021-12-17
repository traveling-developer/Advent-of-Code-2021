import 'dart:math';

import 'package:adventofcode2021/src/helper/int_max.dart';

import 'day.dart';

class Day16 implements Day {
  @override
  int get dayNumber => 16;

  Map<String, String> hexToBinaryLookup = {
    '0': '0000',
    '1': '0001',
    '2': '0010',
    '3': '0011',
    '4': '0100',
    '5': '0101',
    '6': '0110',
    '7': '0111',
    '8': '1000',
    '9': '1001',
    'A': '1010',
    'B': '1011',
    'C': '1100',
    'D': '1101',
    'E': '1110',
    'F': '1111',
  };

  @override
  String solveFirstPuzzle(String puzzleInput) {
    String rawBinary = parseBinary(puzzleInput);

    var packet = Packet(rawBinary);
    List<Packet> allPackets = getAllPackets(packet);

    var versionSum = allPackets.map((e) => e.version).reduce((value, element) => value + element);

    return versionSum.toString();
  }

  @override
  String solveSecondPuzzle(String puzzleInput) {
    String rawBinary = parseBinary(puzzleInput);

    var packet = Packet(rawBinary);

    int packetValue = calculatePacketValue(packet);

    return packetValue.toString();
  }

  String parseBinary(String puzzleInput) {
    var rawBinary = puzzleInput
        .split('')
        .where((element) => hexToBinaryLookup.containsKey(element))
        .map((e) => hexToBinaryLookup[e]!)
        .reduce((value, element) => value += element);

    return rawBinary;
  }

  List<Packet> getAllPackets(Packet packet) {
    List<Packet> subPackets = [];

    for (var subPacket in packet.subPackets) {
      subPackets.addAll(getAllPackets(subPacket));
    }
    return [packet, ...subPackets];
  }

  int calculatePacketValue(Packet package) {
    if (package.typeId == 0) {
      return package.subPackets
          .map((e) => calculatePacketValue(e))
          .reduce((value, element) => value + element);
    }
    if (package.typeId == 1) {
      return package.subPackets
          .map((e) => calculatePacketValue(e))
          .reduce((value, element) => value * element);
    }
    if (package.typeId == 2) {
      return package.subPackets.map((e) => calculatePacketValue(e)).reduce(min);
    }
    if (package.typeId == 3) {
      return package.subPackets.map((e) => calculatePacketValue(e)).reduce(max);
    }
    if (package.typeId == 5) {
      if (calculatePacketValue(package.subPackets.first) >
          calculatePacketValue(package.subPackets.last)) {
        return 1;
      }
      return 0;
    }
    if (package.typeId == 6) {
      if (calculatePacketValue(package.subPackets.first) <
          calculatePacketValue(package.subPackets.last)) {
        return 1;
      }
      return 0;
    }
    if (package.typeId == 7) {
      if (calculatePacketValue(package.subPackets.first) ==
          calculatePacketValue(package.subPackets.last)) {
        return 1;
      }
      return 0;
    }
    if (package.typeId == 4) {
      return package.literalValue;
    }

    return intMax64;
  }
}

class Packet {
  String rawBinaryContent;
  String notUsedRawBinaryContent = '';

  List<Packet> subPackets = [];

  late int version;
  late int typeId;
  late int literalValue;

  Packet(this.rawBinaryContent) {
    version = int.parse(rawBinaryContent.substring(0, 3), radix: 2);
    typeId = int.parse(rawBinaryContent.substring(3, 6), radix: 2);

    if (typeId == 4) {
      _parseLiteralValue();
    } else {
      var lenghtTypeId = rawBinaryContent.substring(6, 7);

      if (lenghtTypeId == '0') {
        _parseOperatorWithLengthTypeIdZero();
      }
      if (lenghtTypeId == '1') {
        _parseOperatorWithLengTypeIdOne();
      }
    }
  }

  void _parseOperatorWithLengTypeIdOne() {
    var numberOfPackets = int.parse(rawBinaryContent.substring(7, 18), radix: 2);

    var content = rawBinaryContent.substring(18, rawBinaryContent.length);

    for (var i = 0; i < numberOfPackets; i++) {
      var subPacket = Packet(content);
      subPackets.add(subPacket);
      content = subPacket.notUsedRawBinaryContent;
    }

    notUsedRawBinaryContent = content;
  }

  void _parseOperatorWithLengthTypeIdZero() {
    var length = int.parse(rawBinaryContent.substring(7, 22), radix: 2);

    var content = rawBinaryContent.substring(22, 22 + length);

    while (content.isNotEmpty) {
      var subPacket = Packet(content);
      subPackets.add(subPacket);

      content = subPacket.notUsedRawBinaryContent;
    }

    notUsedRawBinaryContent = rawBinaryContent.substring(22 + length, rawBinaryContent.length);
  }

  void _parseLiteralValue() {
    List<String> literalValueParts = [];

    var startIndex = 6;
    var partsLength = 5;

    while (true) {
      var part = rawBinaryContent.substring(startIndex, startIndex + partsLength);
      literalValueParts.add(part);

      if (part.startsWith('0')) {
        break;
      }

      startIndex = startIndex + partsLength;
    }

    var rawLiteralValue = literalValueParts
        .map((e) => e.substring(1, e.length))
        .reduce((value, element) => value += element);

    literalValue = int.parse(rawLiteralValue, radix: 2);

    notUsedRawBinaryContent =
        rawBinaryContent.substring(startIndex + partsLength, rawBinaryContent.length);
  }
}
