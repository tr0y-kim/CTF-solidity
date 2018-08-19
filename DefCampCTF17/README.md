# EtherHide 

## Description

[DctfChall.sol](#)


## Flag
DCTF{f9c6470f8b5b0873b8b2a22bc2711ea973864b5faa5753ca88b79f8ba0b62c6a}

## How to solve
In pwn.sol, you first trigger `attack()` function which changed `performAttack` to true, and it goes to the fallback function.

Fallback `function() payable` continuously withdraw and callstack of the EVM gets wrong and recursively execute `msg.sender.call.value(amount)();`

Later, attacker execute `getJackpot()` function and get money!


