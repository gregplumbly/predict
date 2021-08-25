// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract FootballPrediction {
    address public manager;
    address[] public players;
    address[] public winners;

    enum result_type { win, lose, draw} // refers to home team

    struct Fixture {
        string gameId; // e.g MNUvCHE or ARSvBRE
        uint256 date;
        uint16 home_score;
        uint16 away_score;
        result_type result;
    }

    Fixture[] fixtures;

    // mappings

    constructor() {
        manager = msg.sender;
    }

    function createFixtures(string memory _game, uint256 _matchdate)
        public
        restricted
        returns (uint256 fixtureId)
    {}

    function updateResults() public restricted {
        //struct for multiple scores?
    }

    function calculateWinners() public restricted {}

    function makePrediction() public {
        // user would also send transfer for lottery ticket with predictions
    }

    function withdrawWinnings() public {}

    modifier restricted() {
        require(msg.sender == manager);
        _;
    }
}
