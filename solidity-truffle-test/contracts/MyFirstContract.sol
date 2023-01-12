pragma solidity ^0.8.17;

contract MyFirstContract {

    string public initialString = "Hello World!";

    function getString() public view returns (string memory) {
        return initialString;
    }
}
