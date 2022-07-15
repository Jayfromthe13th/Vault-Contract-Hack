# VaultContractHack









<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
## Table of Contents

- [Introduction](#introduction)
- [Vault](#Vault)
- [Reentrancy](#Reentrancy)
- [Flashloan](#Flashloan)
- [References](#References)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Introduction



There are three main contracts associated with this project.



---The first contract is a simplistic version of a vault contract. A user can deposit, earn, and withdraw funds from this contract. The vault contract was created with many bugs within the code. This is for educational purposes. The two main exploits that will be emphasized are reentrancy, and draining the funds through a flashloan attack.  🤬

---The reentrancy contract will be used to attack the vault contract and will drain all the funds. A malicious actor will call the withdraw function in the vault contract before the balance is updated. Which will eventually lead to total depletion of the funds in the vault contract.

---The flashloan contract will also be used to drain all the funds of the vault contract. 

## Vault

Warning!! ⚠️⚠️This contract is susceptible to hacks. There are many bugs within this code. The main objective is to drain all the funds within the given contract. Therefore, we will be using a reetrancy and a flashloan attack. This is for educational purposes.⚠️⚠️



## Reentrancy

<ol>
 <li>Paste code in remix and compile appropriate version.<li>
 Deploy both vault and reentrancy contracts.<li>
 Pick an account that can send over 1 ether (attacker account).<li>
 Use the attack function and confirm transaction via Metamask.<li>
 Call get Balance function in both contracts.<li>
 The new balance should be 2 ether in the new account. When depositing ether, the fallback function will be activated in the attacking contract.<li>
 Repeat until the victim's contract is drained. </ol>

## Flashloan


<ol><li> Paste code in remix.<li>
Select and compile appropriate version.
<li>Go to transaction menu (menu 3).
<li>Change environment to injected web3.
<li>Accept confirmation on Metamask.
<li>Make sure that you are on the flashloan.sol contract.
<li>To deploy, input the victim's contract tokens' name, symbol, and loan amount.
<li>Click transact.
<li>Confirm transaction.
<li>Copy contract that has been created and input liquidity using Metamask wallet.
<li>After you confirm transaction via Metamask, go and click action.
<li>Click on flashloan action button and confirm transaction via Metamask.<ol>

## Mitigations
<p> Flashloan attack </p>

Decentralized Pricing Oracles:
As most flash loan attacks depend on price manipulation, it’s necessary to counter this approach with decentralized pricing oracles. Good examples include Chainlink and Band Protocol. These platforms keep all protocols safe by presenting the accurate pricing of different cryptocurrencies.


OppenZepplin: Implementation of OppenZepplin's Contracts will helps minimize risk by using battle-tested libraries of smart contracts for Ethereum and other blockchains









<p> Reentrancy </p>


Check-effects-interactions patterns:
First perform any checks, which are normally assert and require statements, at the beginning of the function. If the checks pass, the function should then resolve all the effects to the state of the contract. Only after all state changes are resolved should the function interact with other contracts. By calling external functions last, even if an attacker makes a recursive call to the original function they cannot abuse the state of the contract.

Mutex:
A mutex places a lock on the contract state. Only the owner of the lock can modify the state.



## References

https://medium.com/coinmonks/protect-your-solidity-smart-contracts-from-reentrancy-attacks-9972c3af7c21 

https://consensys.github.io/smart-contract-best-practices/attacks/reentrancy/

https://medium.com/geekculture/what-is-a-defi-flash-loans-flash-loan-attack-c130c83d9811
