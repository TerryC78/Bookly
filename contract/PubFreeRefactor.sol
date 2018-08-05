pragma experimental ABIEncoderV2;

import "./Ownable.sol";
import "./SafeMath.sol";

/// PubFree contract.
///
/// TODO: missing comments.
contract PubFree is Ownable {
    
    using  SafeMath for uint256;
    
    /// Abstraction of a book published on PubFree.
    ///
    /// Life of a Book:
    /// -  Published by an author(User).
    /// -  Users buy the published Book.
    /// -  Users add reviews to the Book.
    /// -  Users can read book reviews.
    struct Book {
        // Required. Unique identifier of the book, auto assigned by the system.
        uint bookId;
        
        // Required. Author uid of the book.
        uint authorUid;
        
        // Required. User gets password after buying the book.
        string password;
        
        // Book title, optional.
        string title;
        
        // Book price in ether.
        uint price;
        
        // Reviews of this Book.
        uint[] reviews;
    }
    
    // Book storage: BookId -> Book.
    Book[] books;
    
    /// Abstraction of User on PubFree. User can be Reader as well as Author.
    /// 
    /// Life of a User:
    /// -  User registers on PubFree. (Skip)
    /// -  User signs into PubFree. (Skip)
    /// 
    /// Life of an Author:
    /// -  Author publishes a book.
    /// -  Author gets token when readers buy the Book.
    ///
    /// Life of a Reader:
    /// -  Reader buys a Book.
    /// -  Reader adds a Review.
    /// -  Reader reviews all Books, gets average rating of a Book.
    struct User {
        
        // Required. Auto assigned by the system.
        uint userId;
        
        // Required. User's wallet address.
        address account;
        
        // Books bought by the user.
        uint[] ownedBooks;
        
        // Books authored and published by the user;
        uint[] publishedBooks;
    }
    
    // User storage: userId -> User.
    User[] public users;
    
    // User address mapping: address -> userId.
    mapping(address => uint) public userAccountToId;
    
    /// Abstraction of Book Review.
    /// 
    /// Life of a Review:
    /// -  Book buyer(reader) writes a Review.
    /// -  Readers review existing Reviews of the Book.
    /// -  Readers get average rating of a Book based on Reviews.
    struct Review {
 
        // Required. Unique identifier of the Review.
        uint reviewId;
        
        // Required. BookId.
        uint bookId;
        
        // Required. User who gave this review.
        uint reviewerId;
        
        // Required. Rating should range from 1 to 5.
        uint rating;
    }
    
    // Review storage: reviewId -> Review.
    Review[] reviews;
    
    /// *** Public functions ***
    
    // FE pulls all Books.
    function getAllBooks() external view returns (Book[]) {
       return books; 
    }
    
    // FE pulls one Book.
    function getBook(uint bookId) external view returns (Book) {
        return books[bookId];
    }
    
    // Author publishes a book.
    // TODO: missing comments.
    function PublishBook(string title, uint price, string password) external returns (bool) {
        uint authorId = _getUserIdCreateIfNotExist();

        // Add created Book to Author.
        // TODO: Assuming there are no duplicate books published.
        User storage author = users[authorId];
        uint newBookId = _makeBook(title, price, password);
        author.publishedBooks.push(newBookId);
        
        // StatusOk();
        return true;
    }
    
    function BuyBook(uint bookId) external payable returns (bool) {
        require(msg.value >= books[bookId].price);
        require(msg.sender.balance >= books[bookId].price);
        
        uint authorId = books[bookId].authorUid;
        _transferBalance(authorId, books[bookId].price);
        
        // StatusOk();
        return true;
    }
    
    function AddReview(uint bookId, uint rating) external returns (uint) {
        uint reviewerId = _getUserIdCreateIfNotExist();
        return _makeReview(bookId, reviewerId, rating);
    }
    
    /// *** Public functions END ***
    
    /// *** Private functions ***
    
    // TODO: missing comments.
    function _getUserIdCreateIfNotExist() internal returns (uint) {
        uint userId = userAccountToId[msg.sender];
        if (userId == 0) {
            userId = _makeUser();
        }
        return userId;
    }
    
    // TODO: missing comments.
    function _makeUser() internal returns (uint) {
        uint newUserId = users.length;
        uint[] storage ownedBooks;
        uint[] storage publishedBooks;
        users.push(User({userId: newUserId, 
                         account: msg.sender, 
                         ownedBooks: ownedBooks,
                         publishedBooks: publishedBooks
        }));
        userAccountToId[msg.sender] = newUserId;
        return newUserId;
    }
    
    // TODO: missing comments.
    function _makeBook(string title, uint price, string password) internal returns (uint) {
        uint newBookId = books.length;
        uint authorId = userAccountToId[msg.sender];
        uint[] storage reivewIds;
        books.push(Book({bookId: newBookId, 
                         authorUid: authorId, 
                         title: title, 
                         price: price, 
                         password: password,
                         reviews: reivewIds
        }));
        return newBookId;
    }
    
    // TODO: missing comments.
    function _makeReview(uint bookId, uint reviewerId, uint rating) internal returns (uint) {
        uint newReviewId = reviews.length;
        reviews.push(Review({reviewId: newReviewId, 
                             bookId: bookId, 
                             reviewerId: reviewerId,
                             rating: rating
        }));
        books[bookId].reviews.push(newReviewId);
        return reviewerId;
    }
    
    // TODO: missing comments.
    function _transferBalance(uint receiverId, uint cost) internal returns (bool) {
        User storage receiver = users[receiverId];
        receiver.account.transfer(cost);
        
        // StatusOk();
        return true;
    }
    
    /// *** Private functions END ***
    
}
