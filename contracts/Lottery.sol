pragma solidity ^0.4.17;

contract Lottery {
    address public manager;
    address[] public players;
    
    function Lottery() public {
        manager = msg.sender;
    }
    
    function enter() public payable {
        require(msg.value > .01 ether);
        players.push(msg.sender);
    }
    
    function random() private view returns (uint) {
        return uint(keccak256(block.difficulty, now, players));
    }
    
    function pickWinner() public restricted {
        uint index = random() % players.length;
        players[index].transfer(this.balance);
        // (0) should be dynamic & initial size of zero.
        players = new address[](0);
    }
    
    modifier restricted() {
        require(msg.sender == manager);
        _; // it's like a target.
    }
    
    function getPlayers() public view returns (address[]) {
        return players;
    }
}   

