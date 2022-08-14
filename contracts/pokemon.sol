// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

contract Pokemon {

    // Cualidades para cada pokemon
    struct cualidades {
        string name;
        string tipo_pokemon;
        string ataque;
    }

    // Listado de pokemon que tenemos
    cualidades [] pokedex;

    // Añadir un nuevo pokemon a la pokedex
    function capturar_nuevo_pokemon(string memory _name, string memory _tipo_pokemon, string memory _ataque) internal {
        pokedex.push(cualidades(_name, _tipo_pokemon, _ataque));
    }
}

contract Entrador_pokemon is Pokemon {
    
    // Quien es el propietario de este entrenador pokemon
    address public owner;

    // Asignamos el valor al entrenador Pokemon
    constructor () {
        owner = msg.sender;
    }

    // Conseguimos un pokemon para nuestra pokedex
    function lanzar_pokeball(string memory _nombrePokemon, string memory _tipo_pokemon, string memory _ataque) external {
        require (keccak256(bytes(_nombrePokemon)) != keccak256(bytes(" ")), "Debes poner el nombre al pokemon");
        capturar_nuevo_pokemon(_nombrePokemon, _tipo_pokemon, _ataque);
    }

    // Modifer para poner algún filtro. Solo permitimos conseguir pokemon al owner
    modifier onlyOwner() {
        require(owner == msg.sender, "No tienes permisos para capturar estos pokemon para esta Pokedex");
        _;
    }

    // Obtenemos el listado de pokemon de la pokedex. En el caso de que el owner sea diferente, no le dejaremos ver el resultado
    function getPokedex() public view onlyOwner returns (cualidades [] memory) {
        return pokedex;
    }
}