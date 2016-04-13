contract BlindAuction {
    // bid struct
    // bytes 32 contains a hashed bid 
    // deposit ensures the Bid is valid
    struct Bid {
        bytes32 blindedBid;
        uint deposit;
    }
    
    // state of the auction
    address public beneficiary;
    uint public auctionStart;
    uint public auctionEnd;
    uint public reveal;
    bool public ended;
    
    uint public highestBid;
    address public highestBidder;
    
    mapping(address=>Bid[]) public Bids;
    
    // event for the end of auction
    event auctionEnded(address winner, uint highestBid);
    
    // modifiers
    modifier beforeTime(uint _time) { 
        if(now <= _time) throw;
    }
    modifier afterTime(uint _time) {
        if(now >= _time) throw;
    }
    // construter funciton for blind auction 
    function blindAuction(address _benificiary, uint biddingTime, uint revealTime) {
        beneficiary = _benificiary;
        auctionStart = now;
        auctionEnd = now + biddingTime;
        reveal = auctionEnd + revealTime;
    }
    
    // function to send in bid
    function bid(bytes32 _blindedBid) 
    beforeTime(auctionEnd)
    {
        Bids[msg.sender].push(Bid({
            blindedBid : _blindedBid,
            deposit : msg.value 
        }));
    }
    
    function revealBids(uint[] _amounts, bool[] _fake, bytes32[] _secrets) 
    afterTime(auctionEnd)
    beforeTime(reveal)
    {
        
        // get length of bid array for msg.sender
        uint length = Bids[msg.sender].length;
        // check to make sure amounts, fake, secret lengths are equal to bid length 
        if (_amounts.length != length || _fake.length != length || _secrets.length != length) {
            throw;
        }
        
        // initialize refund variable
        uint refund;
        
        for (uint i = 0; i < length; i ++) {
            var bid = Bids[msg.sender][i];
            var (amounts, fake, secrets) = (_amounts, _fake, _secrets);
            if (bid.blindedBid != sha3(amounts, fake, secrets)) {
                continue;
            }
            refund += bid.deposit;
        }
        msg.sender.send(refund);
    }
    
    // keep track of highest bid 
    function placeBid(address bidder, uint value) internal 
    returns (bool success)
    {
        if(value <= highestBid) {
            return false;
        }   
        else {
            highestBidder.send(highestBid);
            highestBid = value;
            highestBidder = bidder;
            return true;
        }
    }
    // end the auction and send the highest bid to benificiary
    function end() 
    // check that it is after reveal time
    afterTime(reveal)
    {
        // fire event
        auctionEnded(highestBidder, highestBid);
        // send funds to benificiary 
        beneficiary.send(this.balance);

        ended = true;
    }
    
    function () {
        throw;
    }
}



