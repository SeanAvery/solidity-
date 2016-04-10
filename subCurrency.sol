// subCurrency ecosytyem
// allows citizens to gain stake in the ecosystem 
// peer to peer payments of token
// Reputation system and rating capability
contract subCurrency {
    // Agent: participant in the system
    struct Agent {
       address identification;
       uint balance;
       uint reputation;
    }
    
    // list of citizens and bank balances
    mapping(address=>Agent) public citizens;
    
    // currency bi-laws 1,000,000 tokens
    uint totalTokens = 1000000;
    
    // initial public offering
    // first 100,000 people to join
    // get one token each (10% of total currency)
    
    uint[] public tally;
    function currencyPool(address _identification) returns (uint) {
        //add to ipo tally array
        if (tally.length >= 999999) {
            throw;
        }
        else {
            tally.push(tally.length + 1);
            return tally.length;
        }
    }
    
    // payment channel between citizens
    function sendPayment(address _identification, uint amount) {
        // check to make sure funds are sufficient
        if (citizens[_identification].balance < amount) {
            throw;
        }
        else {
            citizens[msg.sender].balance -= amount;
            citizens[_identification].balance += amount;
        }
    }
    
    // allow citizens to rate others on a scale 1-10
    
    function sendRating(address _identification, uint rating) returns(uint) {
        citizens[_identification].reputation += rating; 
    }
    
    
    
    
}