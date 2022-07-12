pragma solidity ^8.0;
contract Vault {
    struct Investor {
        address addr;
        uint amount;
        uint index;
    }
    mapping(address => Investor) public investorsData;
    uint number_of_investors;
    address[] investors;
    uint total_invested;
    
    mapping(address => bool) keepers;
    
    event Deposited(address addr, uint amount);
    event Withdrawn(address addr, uint amount);
    event RewardsEarned(uint amount);
    
    constructor() {
        require(msg.value > 0, "Vault must be initialized with nonzero funds");
        total_invested = msg.value;
    }
    
    function deposit()public payable {
        require(msg.value > 0, "Need to deposit a nonzero amount of fund");
        Investor storage investor;
        investor.addr = msg.sender;
        investor.amount += msg.value;
        investor.index = number_of_investors;
        investorsData[msg.sender] = investor;
        
        number_of_investors += 1;
        total_invested += msg.value;
        emit Deposited(msg.sender, msg.value);
    }
    
    function earn(uint amount) public{
        require(keepers[msg.sender], "Not a keeper");
        
        uint amount_to_give = msg.value / number_of_investors;
        for (uint i=0; i < number_of_investors; i++) {
            address investorAddr = investors[i];
            Investor storage investor = investorsData[investorAddr];
            investor.amount += amount_to_give;
            investorAddr.call.value(amount_to_give)("");
        }
        total_invested += msg.value;
        
        emit RewardsEarned(amount_to_give);
    }
    //withdraw function is susceptible for reentrancy
    function withdraw(uint amount) public{
        require(investorsData[msg.sender].amount >= 0, "Not enough funds deposited to withdraw");
        Investor storage investor = investorsData[msg.sender];
        uint amount_to_withdraw = investor.amount;
        (bool success, ) = msg.sender.call.value(amount_to_withdraw)("");
        total_invested -= amount_to_withdraw;
        investor.amount -= amount_to_withdraw;
        emit Withdrawn(msg.sender, msg.value);
    }
    
    receive() external payable {}

}