// import 'dart:convert';

// import 'package:cryptography/cryptography.dart';
// import 'package:flutter/material.dart';

// class Crypto extends StatefulWidget {
//   const Crypto({Key key}) : super(key: key);

//   @override
//   _CryptoState createState() => _CryptoState();
// }

// class _CryptoState extends State<Crypto> {
//   Future<void> generateKey() async {
//     final algorithm = X25519();

//     // Alice chooses her key pair
//     final aliceKeyPair = await algorithm.newKeyPair();

//     // Alice knows Bob's public key
//     final bobKeyPair = await algorithm.newKeyPair();
//     final bobPrivateKey = await bobKeyPair.extractPrivateKeyBytes();
//     final bobPublicKey = await bobKeyPair.extractPublicKey();

//     String dineshPublicKey =
//         "569d38198a767416babde710cff297dec03d081fe66ccac4230ef649ef604dcb95ce7cd558374ed1641760f042dfc3f92c664afcc26eb6fe5269242eef37caef";
//     print(dineshPublicKey.length);
//     final publicKey = SimplePublicKey(base64.decode(dineshPublicKey),
//         type: KeyPairType.x25519);
//     // Alice calculates the shared secret.
//     final sharedSecret = await algorithm.sharedSecretKey(
//       keyPair: bobKeyPair,
//       remotePublicKey: publicKey,
//     );
//     final sharedSecretBytes = await aliceKeyPair.extractPublicKey();
//     print("public key");
//     print(sharedSecret.extractBytes());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         child: Center(
//           child: InkWell(
//             onTap: () async {
//               generateKey();
//             },
//             child: Container(
//               width: 100,
//               height: 50,
//               color: Colors.red,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
