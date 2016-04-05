contract seanCoin {
    // address for the minter of the currency
    address public king;
    // initialize array to hold balances for all otherparticipants 
    mapping(address=>uint) public balances;
    
    // constructor function on creation of contract
    // sets king to creator of contract
    function seanCoin() {
        king = msg.sender;
    }
    
    // give myself x amount of seanCoin
    function printMoney(uint x) {
        balances[msg.sender] += x;
    }
    
    // send seanCoin to friends 
    function sendSeanCoin(address sendAddress, uint amount) {
        if (balances[msg.sender] < amount) {
            return;
        }
        balances[msg.sender] -= amount;
        balances[sendAddress] += amount;
    }
    
}