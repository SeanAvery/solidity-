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
    
    modifier verifyMiddleware(address _middleWare) {
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



contract contractSpecs is Identity {
    
    event contractSpec(address indexed from, address indexed to, address indexed shaCheck);
    
    function sendSpec(bool sendSpec, address sendAddress, address _shaCheck) 
    // verifyMiddleware(address contractAddress)
    verifyAccount(sendAddress)
    {
        if(!sendSpec) throw;
        
        contractSpec(msg.sender, sendAddress, _shaCheck);
    }
}


