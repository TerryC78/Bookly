pragma solidity ^0.4.19;

import "./Ownable.sol";
import "./Safemath.sol";

contract PubFree is Ownable {
    using  SafeMath for uint256;
    
    struct User {
        string name;
        address account;
        uint balance;
        uint reputation;
        // Mapping of purchased books.
        mapping(uint => bool) purchasedBooks;
        // Mapping of published books.
        mapping(uint => bool) publisedBooks;
    }
    
    mapping(uint => bool) public users;
    uint userCount;

    
    function newUser(string name) external returns (uint) {
        uint newUserId = userCount;
        users[newUserId] = User({
            name: name,
            account: msg.sender,
            balance: 0,
            reputation: 0
        });
    }
}
