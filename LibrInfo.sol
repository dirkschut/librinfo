pragma solidity ^0.4.0;

contract LibrInfo {
  struct Persoon {
    bytes32 id;
    bool magBoekLenen;
    bool magBoekToevoegen;
  }

  address public eigenaar;
  mapping (bytes32 => Persoon) public personen;
  bytes32[] public personenlijst;

  function LibrInfo() public {
    eigenaar = msg.sender;
  }

  function PersoonToevoegen(bytes32 nummer, bytes32 code) public{
    require (msg.sender == eigenaar);
    personen[keccak256(nummer, code)] = Persoon({id: keccak256(nummer, code), magBoekLenen: true, magBoekToevoegen: false});
    personenlijst.push(keccak256(nummer, code));
  }

  function GetPersoon(bytes32 nummer, bytes32 code) view public returns (bool){
    return (personen[keccak256(nummer, code)].magBoekLenen);
  }
}
