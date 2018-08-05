pragma solidity ^0.4.19;

import "./Ownable.sol";
import "./SafeMath.sol";

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
    
    mapping(uint => User) public users;
    mapping(address => uint) public userAccountToId;
    uint userCount;

    uint oldBalance;
    
    function newUser(string name) external returns (uint) {
        uint newUserId = userCount;
        userCount = userCount.add(1);
        users[newUserId] = User({
            name: name,
            account: msg.sender,
            balance: 0,
            reputation: 0
        });
        userAccountToId[msg.sender] = newUserId;
        return newUserId;
    }
    
    function addFund() payable public returns (uint) {
        uint userId = userAccountToId[msg.sender];
        uint newBalance = address(this).balance;
        users[userId].balance += newBalance - oldBalance;
        oldBalance = newBalance;
        return newBalance;
    }
}