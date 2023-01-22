// SPDX-License-Identifier: GPL-3.0

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol"; 

contract PokeNFT is ERC721{

    struct pokemon{
        string name;
        uint level;
        string img;
    }

    pokemon[] public pokemons;
    address public gameOwner;

    constructor () ERC721 ("PokeNFT", "PKNFT"){

        gameOwner = msg.sender;

    }

    modifier onlyOwnerOf(uint _monsterID){

        require(ownerOf(_monsterID)==msg.sender, "Apenas o dono pode batalhar com este Pokemon");
        _;
    }

    function battle(uint _attackingPokemon, uint _defendingPokemon) public onlyOwnerOf(_attackingPokemon){
        pokemon storage attacker = pokemons[_attackingPokemon];
        pokemon storage defender = pokemons[_defendingPokemon];

        if (attacker.level >= defender.level){
            attacker.level += 2;
            defender.level += 1;
        } else{
            attacker.level += 1;
            defender.level += 2;
        }
    }

    function createNewPokemon(string memory _name, address _to, string memory _img) public {
        require(msg.sender == gameOwner, "Apenas o dono do jogo pode criar novos Pokemons");
        uint id = pokemons.length;
        pokemons.push(pokemon(_name, 1, _img));
        _safeMint(_to, id);
    }

}