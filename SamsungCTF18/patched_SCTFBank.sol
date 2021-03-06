pragma solidity ^0.4.18;

contract SCTFBank{
    event LogBalance(address addr, uint256 value);

    mapping (address => uint256) private balance;
    uint256 private donation_deposit;
    address private owner;

    //constructor
    constructor() public{
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    //logging balance of requested address
    function showBalance(address addr) public {
        emit LogBalance(addr, balance[addr]);
    }

    //withdraw my balance
    function withdraw(uint256 value) public  {
        require(balance[msg.sender] >= value);
        balance[msg.sender] -= value;
        msg.sender.transfer(value);         // here

    }    

    //transfer my balance to other
    function transfer(address to, uint256 value) public {
        require(balance[msg.sender] >= value);
        balance[msg.sender] -= value;
        balance[to]+=value;
    }

    //transfer my balance to others
    function multiTransfer(address[] to_list, uint256 value) public {
        require(balance[msg.sender] > value*to_list.length); 
        require(value*to_list.length > value);    //integer overflow
        balance[msg.sender] -= value*to_list.length;
        for(uint i=0; i < to_list.length; i++){
            balance[to_list[i]] += value;
        }
    }   

    //donate my balance
    function donate(uint256 value) public  {
        require(balance[msg.sender] >= value); //here
        balance[msg.sender] -= value;
        donation_deposit += value;
    }

    //Only bank owner can deliver donations to anywhere he want.
    function deliver(address to) public {
        require(msg.sender == owner);   //here tx.origin changed
        to.transfer(donation_deposit);
        donation_deposit = 0;
    }

    //balance deposit, simple fallback function
    function () payable public {
        balance[msg.sender]+=msg.value;
    }
}
//END
