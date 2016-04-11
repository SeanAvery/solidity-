contract vote {
    
    struct Voter {
        // weight of voe
        uint weight;
        // true if already voted
        bool voted;
        // index for voted proposal 
        uint vote;
        // delegate vote to someone else
        address delegate;
    }
    
    struct Proposal {
        bytes32 name;
        uint voteTally;
    }
    
    // creating a mapping of addresses to Voter for a Voter ledger
    mapping(address=>Voter) public Voters;
    // mapping(address=>Proposal) public Proposals;
    // dynamically sized array for Proposals
    Proposal[] public Proposals;
    
    // public address for chairperson
   address public chairperson;
   
    function ballot(bytes32[] proposalNames) {
        chairperson = msg.sender;
        Voters[chairperson].weight = 1;
        for(uint i = 0; i < proposalNames.length; i++) {
            Proposals.push(Proposal({
                name : proposalNames[i],
                voteTally : 0
            }));
        }
    }
    
    // let chairperson give rights to vote to individuals
    function votingRight(address voter) {
        if (msg.sender != msg.sender || Voters[voter].voted) {
            throw;
        }
        Voters[voter].weight = 1;
    }

    // allow individuals to delegate votes to others
    function delegateVote(address to) {
        if (Voters[msg.sender].voted) {
            throw;
        }
        if (to == msg.sender) {
            throw;
        }
        
        if (Voters[to].voted) {
            Proposals[Voters[to].vote].voteTally += 1;
        }
        else {
            Voters[to].weight += 1;
        }
        
        // adjust delegators vote status and weight 
        Voters[msg.sender].voted = true;
        Voters[msg.sender].weight -= 1;
    }
    
    // allow individuals to cast vote
    function vote(uint proposal, uint weight) {
        // check to see if already voted
        if (Voters[msg.sender].voted) {
            throw;
        }
        // check to ensure they have the alloted weight
        if (Voters[msg.sender].weight < weight) {
            throw;
        }
        // adjust proposal voteTally 
        Proposals[proposal].voteTally += weight;
        // adjust msg.senders balance
        Voters[msg.sender].voted = true;
        Voters[msg.sender].vote = proposal;
        Voters[msg.sender].weight -= weight;
    }
    // look for the winning proposal 
    function countVote() constant returns(uint prop, uint winningTally) {
        uint propCounter; 
        uint maxCounter = 0;
        for (uint i = 0; i < Proposals.length; i++) {
            if (Proposals[i].voteTally >= maxCounter) {
                propCounter = i;
                maxCounter = Proposals[i].voteTally;
            }
        }
        
        return (propCounter, maxCounter);
    }
}