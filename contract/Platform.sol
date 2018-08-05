pragma solidity ^0.4.19;

import "./Ownable.sol";

contract Platform is Ownable {
    mapping(address => bool) public books;
    uint bookCount;
    mapping(address => bool) public members;
    uint memberCount;
    
    function newBook(address book) external {
        // TODO how to verify the adress is for a book.
        books[book] = true;
    }
    
    function newMember(address member) external {
        // TODO how to verify the address is for a member.
        members[member] = true;
    }
}
