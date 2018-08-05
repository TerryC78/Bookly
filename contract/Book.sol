pragma solidity ^0.4.19;

import "./Safemath.sol";
import "Platform.sol";

contract Book is Ownable {
    using  SafeMath for uint256;
    
    struct SplitModel {
        uint ownerPrecentage;
        uint ReviewerPrecentage;
        uint PlatformPrecentage;
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
    
    string public title;
    string public description;
    address public owner;
    uint public price;
    uint public totalSold;
    string private password;
    uint public publishTime;
    uint public threadCount;
    mapping(uint => ReviewThread) public threads;
    int public rate;
    Platform platform = Platform(/*Fixed address for Platform*/);
    
    SplitModel splitModel;
    
    uint clearingPeriod = 30 days;
    
    uint ownerBalance;
    // A map to list all purchased users.
    mapping(address => bool) purchased;
    // A map to record record credits earned through reviews.
    uint reviewerCounts;
    mapping(uint => address) reviewerIds;
    mapping(address => uint) reviewerCredits;
    
    // Only reviews with positive rate counts (Good review). It sums up the rates of all good reviews.
    uint goodRviewRateSum;
    
    function Book(SplitModel model) payable public Ownable {
        owner = msg.sender;
        platform.newBook(address(this));
        splitModel = model;
    }
    
    function purchse() external {
        purchased[msg.sender] = true;
        ownerBalance = ownerBalance.add(price.mul(splitModel.ownerPrecentage).div(100));
    }
    
    function hasPurchased() external returns (bool, string) {
        if (purchased[msg.sender]) {
            return (true, password);
        }
        return (false, "");
    }
    
    function createReviewThread(string title) external returns (uint) {
        uint threadId = threadCount; 
        publicInfo.threads[threadId] = ReviewThread();
        threadCount = threadCount.add(1);
        appendReivew(threadId, title);
        return threadId;
    }
    
    function appendReivew(uint threadId, string title) external returns (uint){
        Thread appendToThread = threads[threadId];
        unint reviewId = appendToThread.reviewCount;
        appendToThread[reviewId] = Review({title: title, createTime: now, owner: msg.sender});
        appendToThread.reviewCount = appendToThread.reviewCount.add(1);
        return reviewId;
    }
    
    function rateBook(int r) external {
        // May add cost for each rate.
        // Limit rate frequency.
        rate += r;
    }
    
    function rateReview(uint threadId, uint reviewId, int r) external {
        // Limit rate frequency
        uint oldRate = threads[threadId].reviews[reviewId].rate;
        uint newRate = oldRate + r;
        if (oldRate >= 0 && newRate >= 0) {
            goodRviewRateSum += r;
        } else if (oldRate >= 0) {
            goodRviewRateSum -= oldRate;
        } else if (newRate > 0) {
            goodRviewRateSum += newRate;
        }
        if (threads[threadId].reviews[reviewId].title != "") {
            threads[threadId].reviews[reviewId].rate += r;
        }
    }
    
    function authorWithDraw() external onlyOwner{
        // TODO check amount is not shallow copy of ownerBalance.
        uint amount = ownerBalance;
        ownerBalance = 0;
        msg.sender.transfer(ownerBalance);
    }
    
    // TODO call this function every clearingPeriod;
    function clearing() {
        // TODO verify the msg.sender
        _updateReviewerCredits();
        for (uint idx = 0; idx < reviewerCounts; idx++) {
            address reviewerAddr = reviewerIds[idx];
            uint credit = reviewerCredits[reviewerAddr];
            delete reviewerIds[idx];
            delete reviewerCredits[reviewerAddr];
            reviewerAddr.transfer(credit);
        }
    }
    
    function _updateReviewerCredits() private view {
        for (uint threadId = 0; threadId < threadCount; threadId++) {
            Thread thread = threads[threadId];
            for(uint reviewId = 0; reviewId < thread.reviewCount; reviewId++) {
                Review review = thread.reviews[reviewId];
                if (reviewerCredits[review.owner] != 0) {
                    reviewerIds[reviewerCounts] = review.owner;
                    reviewerCounts = reviewerCounts.add(1);
                }
                reviewerCredits[review.owner].add(review.rate);
            }
        }
    }
}
