//What the contract does:Create army of zombies and store thier information.

pragma solidity ^0.4.0;

contract ZombieFactory{

    //event to signal creation of new zombie
    event NewZombie(uint zombieId, string name, uint dna);
    
    uint dnaDigits = 16;
    uint dnaModulus = 10 ** dnaDigits;
    
    // characteristics/attributes of a zombie using struct
    struct Zombie{
        string name;
        uint dna;
        
    }
    
    // dynamic array of zombies
    Zombie[] public zombies;
    
    // function to create new Zombies
    function _createZombie(string _name,uint _dna) private{
        //zombies.push() returns new length of array extended after addition of zombie
        uint id = zombies.push(Zombie(_name,_dna))-1;
        // fire signal to convey creation of zombie to front-end
        emit NewZombie(id,_name,_dna);
        
    }
    
    // function to generate random dna for a zombie
    function _generateRandomDna(string _str) private view returns(uint) {
        // generate random no. using keccak256 using input from user
        uint rand = uint(keccak256(abi.encodePacked(_str)));
        return rand % dnaModulus;
    }
    
    // public function to call the other functions
    function createRandomZombie(string _name) public {
        uint randDna = _generateRandomDna(_name);
        _createZombie(_name,randDna);
    }
}