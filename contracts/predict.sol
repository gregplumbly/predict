// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Storage {
    address public manager;
    address[] public players;
    address[] public winners;
    
    constructor() {
        manager = msg.sender;
    }

    function createFixture(string memory _game, uint256 _matchdate) public restricted { // _game format = 'MNCVARS' (Man City V Arsenal)
    } 

    function makePrediction() public {
    }


    function calculateWinners()  public restricted {
    }


    function withdrawWinnings() public {
    }

    modifier restricted() {
      require (msg.sender == manager);
      _;
    }
}