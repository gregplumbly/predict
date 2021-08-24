// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract FootballPrediction {
    address public manager;
    address[] public players;
    address[] public winners;
    
    // struct with game and date
    // fixtures array of structs
    // mappings
    
    constructor() {
        manager = msg.sender;
    }
    
    function createFixtures (string memory _game, uint256 _matchdate) public restricted returns (uint fixtureId) {
    }

    function updateResults (fixtureId, team1_score, team2_score) public restricted { //struct for multiple scores?
    }
    
    function calculateWinners()  public restricted {
    }

    function makePrediction() public { // user would also send transfer for lottery ticket with predictions
    }

    function withdrawWinnings() public {
    }

    modifier restricted() {
      require (msg.sender == manager);
      _;
    }
}