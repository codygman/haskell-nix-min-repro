{ mkDerivation, base, binary, bytestring, cryptohash-md5
, data-binary-ieee754, mtl, network, QuickCheck, stdenv
, test-framework, test-framework-quickcheck2, text, time, network-bsd
}:
mkDerivation {
  pname = "bson";
  version = "0.4.0.1";
  sha256 = "6bc436f1671c19fbe3b56a52cf786a0f78f8a73a4b072af0aa006ce40286bdf6";
  libraryHaskellDepends = [
    base binary bytestring cryptohash-md5 data-binary-ieee754 mtl
    network-bsd text time
  ];
  configureFlags = [
    "-f-_old-network"
  ];
  testHaskellDepends = [
    base bytestring QuickCheck test-framework
    test-framework-quickcheck2 text time
  ];
  homepage = "http://github.com/mongodb-haskell/bson";
  description = "BSON documents are JSON-like objects with a standard binary encoding";
  license = stdenv.lib.licenses.asl20;
}
