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
            
        }
    }
    
    
}