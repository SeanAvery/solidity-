// exchange contract 

contract Exchange {
    // create a struct for bids and asks
    struct Bid {
        uint price;
        uint numShares;
    }
    struct Ask {
        uint price;
        uint numShares;
    }
    
    // make Bid[] and Ask[] to hold active orders 
    // ordering uints from least to greatest EX: Bids[4,5,7,8,..]
    Bid[] Bids;
    Ask[] Asks;
    
    uint[] askLedger;
    askLedger[0] = 3;
    // function constructor(uint price) returns (bool) {
    //     askLedger.push(price);
    //     return true;
    // }
    
    // filter incoming bids and asks
    // only accept bids and asks which are 'in the market'
    // return true if the bidding price is greater than the least asking price
    
    function filterBid(uint price) returns(bool) {
        // for (uint i = 0; i < Bids.length; i++) {
        //     if (price >= Asks[0].price) {
        //         sortBid(price);
        //         return true;
        //     }
        // }
        if (price >= askLedger[0]) {
                sortBid(price);
                return true;
        }
        return false;
    }
    
    function sortBid(uint price) returns (bool) {
        return true;
    }
    
}
