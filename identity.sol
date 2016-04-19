contract Identity {
    
    struct account {
        address acountAddress;
    }
    account[] public accounts;
    
    struct middleWare {
        address contractAddress;
    }
    middleWare[] middleWareList;
    
    // restrict access to approved accounts and contracts
    modifier verifyAccount(address user) {
        bool verified = false;
        for(uint i=0; i<accounts.length; i++) {
            if (accounts[i].acountAddress == user) verified = true;
        }
        if (!verified) throw;
        _ 
    }
    
    modifier verifyMiddlewear(address _middleWare) {
        bool verified = false;
        for(uint i=0; i<middleWareList.length; i++) {
            if (middleWareList[i].contractAddress == _middleWare) verified = true;
        }
        if (!verified) throw;
        _
    }
    
    // add account if identity is verified
    function addAccount(address newAccount) 
    verifyAccount(msg.sender)
    {
        accounts.push(account({
            acountAddress : newAccount
        }));
    }
    
    function authorizeMiddleWare(address newExtension) 
    verifyAccount(msg.sender)
    {
        middleWareList.push(middleWare({
            contractAddress : newExtension
        }));
    }
    
}