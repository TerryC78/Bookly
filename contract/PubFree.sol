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
    
    struct Review {
        string title;
        uint createTime;
        address owner;
        int rate;
    }
    
    struct ReviewThread {
        uint reviewCount;
        mapping(uint => Review) reviews;
    }
    
    struct Book {
        string title;
        address ownerId;
        uint price;
        uint totalSold;
        string password;
        uint publishTime;
        uint threadCount;
        mapping(uint => ReviewThread) threads;
        int rate;
    }
    
    mapping(uint => User) public users;
    mapping(address => uint) public userAccountToId;
    uint userCount;
    
    mapping(uint => Book) public books;
    uint bookCount;

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
    
    function getUserInfo() external view returns (string name, address account, uint balance, uint reputation, uint[], uint[]) {
        uint userId = userAccountToId[msg.sender];
        User memory user = users[userId];
        uint[] memory purchased = new uint[](user.purchasedBookCount);
        uint[] memory published = new uint[](user.publishedBooksCount);
        for (uint idx1 = 0; idx1 < user.purchasedBookCount; idx1++) {
            purchased[idx1] = users[userId].purchasedBooks[idx1];
        }
        for (uint idx2 = 0; idx2 < user.publishedBooksCount; idx2++) {
            published[idx2] = users[userId].publisedBooks[idx2];
        }
        return (user.name, user.account, user.balance, user.reputation, purchased, published);
    }
    
    function newBook(string title, uint price, string password) external returns (uint) {
        uint newBookId = bookCount;
        bookCount = bookCount.add(1);
        books[newBookId] = Book({title: title, ownerId: msg.sender, price: price, totalSold: 0, password: password, publishTime: now, threadCount: 0, rate: 0});
        return newBookId;
    }
}