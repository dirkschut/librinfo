pragma solidity ^0.4.0;

contract LibrInfo {
  struct Persoon {
    bytes32 id;
    bool magBoekLenen;
    bool magBoekToevoegen;
  }

  struct Boek {
    string ISBN;
    string titel;
    string auteur;
    bytes32 lener;
  }

  address public eigenaar;

  mapping (bytes32 => Persoon) public personen;
  bytes32[] public personenlijst;

  Boek[] public boekenlijst;

  function LibrInfo() public {
    eigenaar = msg.sender;
  }

  function PersoonToevoegen(bytes32 nummer, bytes32 code) public{
    require (msg.sender == eigenaar);
    personen[keccak256(nummer, code)] = Persoon({id: keccak256(nummer, code), magBoekLenen: true, magBoekToevoegen: false});
    personenlijst.push(keccak256(nummer, code));
  }

  function PersoonMagToevoegen(bytes32 nummer, bytes32 code) public{
    require (msg.sender == eigenaar && personen[keccak256(nummer, code)].magBoekLenen);
    personen[keccak256(nummer, code)].magBoekToevoegen = true;
  }

  function GetPersoon(bytes32 nummer, bytes32 code) view public returns (bool){
    return (personen[keccak256(nummer, code)].magBoekLenen);
  }

  function BoekToevoegen(bytes32 nummer, bytes32 code, string ISBN, string titel, string auteur) public{
    require (personen[keccak256(nummer, code)].magBoekToevoegen);
    boekenlijst.push(Boek({ISBN: ISBN, titel: titel, auteur: auteur, lener: ""}));
  }

  function BoekLenen(bytes32 nummer, bytes32 code, uint boek) public{
    require(personen[keccak256(nummer, code)].magBoekLenen && boekenlijst[boek].lener == "");
    boekenlijst[boek].lener = keccak256(nummer, code);
  }

  function BoekInleveren(bytes32 nummer, bytes32 code, uint boek) public{
    require(boekenlijst[boek].lener == keccak256(nummer, code));
    boekenlijst[boek].lener = "";
  }
}
