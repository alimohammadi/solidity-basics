// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;

contract SimpleStorage {
    uint256 public myFavoriteNumber; // 0

    uint256[] listOfFavoriteNumbers; // []
    struct Person {
        uint256 favoriteNumber;
        string name;
    }

    // dynamic array 
    Person[] public listOfPeople; //[]

    // static array 
    Person[4] public listOfPeople2; //[]

    // Person public myfriend = Person(7, "Ali");
    Person public myfriend = Person({favoriteNumber: 7, name: "Ali"});
    Person public myfriend2 = Person({favoriteNumber: 7, name: "Ali2"});
    Person public myfriend3 = Person({favoriteNumber: 7, name: "Ali3"});

    // mapping (key => value)
    mapping(string => uint256) public nameToFavoriteNumber;

    function addPerson(string memory _name, uint256 _favoriteNumber) public {
        Person memory newPerson = Person(_favoriteNumber, _name);
        listOfPeople.push(newPerson);
        nameToFavoriteNumber[_name] = _favoriteNumber; // store mapping too
    }

    function store(uint256 _favoriteNumber) public {
        myFavoriteNumber = _favoriteNumber;
    } 

    // view
    function retrieve() public view returns (uint256) {
        return myFavoriteNumber;
    }
}

contract StorageFactory{
    // type visibility name
    SimpleStorage public simpleStorage;

    function createSimpleStorageContract() public {
        simpleStorage = new SimpleStorage();

    }
}