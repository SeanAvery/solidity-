// simple contract the stores a number on the blockchain
contract Storage {
    uint data;
    // a constructer functin
    // function stores and returns value 
    function constuctor(uint x) returns (uint) {
        data = x;
        return data;
    }
    
}