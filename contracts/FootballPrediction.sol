// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract FootballPrediction {
    address public owner;
    address[] public players;
    address[] public winners;
    string test = 'a test';

    enum result_type { win, lose, draw} // refers to home team

    struct Fixture {
        string gameId; // e.g MNUvCHE or ARSvBRE
        uint256 date;
        uint16 home_score;
        uint16 away_score;
        result_type result;
    }

    // Add a max date for making prediction. match date -1
    // Handle error if submit after closing time - use require

    Fixture[] fixtures;

    // mappings

    constructor() {
        owner = msg.sender;
    }

    function createFixture(string memory _game, uint256 _matchdate) //start with one function
        public
        restricted
        returns (uint256 fixtureId)
    {}

    function updateResults() public restricted {
        //struct for multiple scores?
    }

    function calculateWinners() public restricted {}

    function makePredictionAndEnter() public payable { //add parameters for fixtures //start with one game
        require(msg.value > .01 ether ); //exact amount?
        players.push(msg.sender);
        // user would also submit predictions at this point?

    } // do we need a balance function?

    // new function to see live fixtures


    function withdrawWinnings() public {}

    function balanceOfPot() public view returns (uint256) {
        return address(this).balance;
    }

    modifier restricted() {
        require(msg.sender == owner);
        _;
    }
}
