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
        // Mapping from the idx of books purchased by the user to book ID.
        mapping(uint => uint) purchasedBooks;
        uint purchasedBookCount;
        // Mapping from the idx of books published by the user to book ID.
        mapping(uint => uint) publisedBooks;
        uint publishedBooksCount;
    }
    
    mapping(uint => User) public users;
    mapping(address => uint) public userAccountToId;
    uint userCount;

    uint oldBalance;
    
    function newUser(string name) external returns (uint) {
        uint newUserId = userCount;
        userCount = userCount.add(1);
        users[newUserId] = User({name: name, account: msg.sender, balance: 0, reputation: 0, purchasedBookCount: 0, publishedBooksCount:0});
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
    
    function getUserInfo() external returns (string name, address account, uint balance, uint reputation, uint[], uint[]) {
        uint userId = userAccountToId[msg.sender];
        User user = users[userId];
        uint[] purchased;
        uint[] published;
        for (uint idx1 = 0; idx1 < user.purchasedBookCount; idx1++) {
            purchased.push(user.purchasedBooks[idx1]);
        }
        for (uint idx2 = 0; idx2 < user.publishedBooksCount; idx2++) {
            published.push(user.publisedBooks[idx2]);
        }
        return (user.name, user.account, user.balance, user.reputation, purchased, published);
    }
}