contract openAuction {
    
    
    address public benificiary;
    uint public auctionStart;
    uint public auctionTime;
    
    // state of the auction
    address public highestBidder;
    uint public highestBid;
    
    // bool for end of auction
    bool public auctionEnd;
    
    // events that will be fired on changes
    event highestBidIncrease(address bidder, uint amount);
    event auctionEnding(address winner, uint winAmount);
    
    // create the auction (constructor)
    function createAuction(address _benificiary, uint _auctionTime) {
        benificiary = _benificiary;
        auctionStart = now;
        auctionTime = _auctionTime;
    }
    
    // bidding function
    function bid(uint amount) {
        // check time
        if(now > auctionStart + auctionTime) throw;
        // check to make sure bid is higher then previous max
        if(amount <= highestBid) throw;
        
        // adjust highest bidder
        highestBidder = msg.sender; 
        highestBid = amount;
        
        // fire event 
        highestBidIncrease(msg.sender, amount);
    }
    
    
}