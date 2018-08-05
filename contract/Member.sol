pragma solidity ^0.4.19;

import "./Ownable.sol";
import "./Safemath.sol";
import "./Book.sol";
import "Platform.sol";

contract Members is Ownable {
    using  SafeMath for uint256;
    
    string name;
    int public reputation = 1000;
    mapping(address => bool) public purchasedBooks;
    mapping(address => bool) public publisedBooks;
    Platform platform = Platform(/*Fixed address for Platform*/);
    
    function Members() payable public Ownable {
        owner = msg.sender;
        platform.newMember(address(this));
    }
    
    function addFund() payable public returns (uint) {
        return address(this).balance;
    }
    
    function withDraw(address target, uint withDrawAmount) external onlyOwner {
        require(withDrawAmount >= address(this).balance);
        target.transfer(withDrawAmount);
    }
    
    function updateReputation(int repu) external returns (int) {
        reputation += repu;
        return reputation;
    }
    
    function getMemberInfo() external returns (string, int) {
        return (name, reputation);
    }
    
    function purchase(address book) public onlyOwner {
        Book b = Book(book);
        uint price = b.price;
        require(address(this).balance >= price);
        book.transfer(price);
        purchasedBooks[book] = true;
        b.purchse();
    }
    
    function publish(address book) public onlyOwner {
        // TODO: Deploy book contract through web3js.
        publisedBooks[book] = true;
    }
    
    /* Returs the password to read the given book. */
    function read(address book) public onlyOwner returns (string) {
        Book b = Book(book);
        bool authorized;
        string password;
        (authorized, password) = b.hasPurchased();
        require(authorized);
        return password;
    }
    
    function getPaidForABook(address book) public onlyOwner {
        require(purchasedBooks[book]);
        Book b = Book(book);
        b.authorWithDraw();
    }
}
