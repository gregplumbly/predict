// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract FootballPrediction {
    
    event NewFixture(uint fixtureId, string gameId, uint date);

    address public owner;
    address[] public players;
    address[] public winners;

    enum resultType {win, lose, draw, noResult} // refers to home team

    struct Fixture {
        string gameId; // e.g MNUCHE or ARSBRE
        uint date;
        uint16 homeScore;
        uint16 awayScore;
        resultType result;
    }

    Fixture[] public fixtures;

    struct Prediction {
        uint fixtureId;
        uint16 homeScore;
        uint16 awayScore;
        resultType result;
    }

    mapping (address => Prediction[]) public playerToPrediction;
    mapping (address => uint) public playerToAmountDue;

    constructor() {
        owner = msg.sender;
    }

    function createFixture(string memory _game, uint _matchDate) external restricted 
        returns (uint) {

        fixtures.push(Fixture(_game, _matchDate, 0, 0, resultType.noResult));
        uint fixtureId = fixtures.length - 1;
        
        // Emit an event any time new fixture is created. UI code will listen to this and display
        emit NewFixture(fixtureId, _game, _matchDate);
        
        return fixtureId;
    }

    function balanceOfPot() public view returns (uint) {
        return address(this).balance;
    }
    
    function makePrediction(uint _fixtureId, uint16 _homeScore, uint16 _awayScore, uint _date)
        external payable {
        
        // Allow prediction entry only if done before match start time
        require(block.timestamp < _date);
        
        // Make sure they paid :) For now amount to bet is fixed to 0.01 ether for simplicity
        require(msg.value == .01 ether);
        
        // Maintain a list of unique players and also a map of their address and prediction
        if (playerToPrediction[msg.sender].length > 0) {
            players.push(msg.sender);
        }

        resultType result;
        if (_homeScore == _awayScore) {
            result = resultType.draw;
        } else if (_homeScore > _awayScore) {
            result = resultType.win;
        } else {
            result = resultType.lose;
        }

        playerToPrediction[msg.sender].push(Prediction(_fixtureId, _homeScore, _awayScore, result));
    }

    function updateResultForMatch(uint _fixtureId, uint16 _homeScore, uint16 _awayScore) external restricted {
        Fixture storage matchToUpdate = fixtures[_fixtureId];
        matchToUpdate.homeScore = _homeScore;
        matchToUpdate.awayScore = _awayScore;
        
        if (_homeScore == _awayScore) {
            matchToUpdate.result = resultType.draw;
        } else if (_homeScore > _awayScore) {
            matchToUpdate.result = resultType.win;
        } else {
            matchToUpdate.result = resultType.lose;
        }
    }

    function calculateWinners() external restricted {

        Prediction[] storage playerPredictions;

        for (uint i = 0; i < players.length; i++) {
            playerPredictions = playerToPrediction[players[i]];

            for (uint j = 0; i < playerPredictions.length; j++) {
                if (playerPredictions[j].result == fixtures[playerPredictions[j].fixtureId].result) {
                    winners.push(players[i]);
                }
            } //end of inner for loop
        } //end of outer for loop

        uint perMatchWinnings = balanceOfPot() / winners.length;

        for (uint i = 0; i < winners.length; i++) {
            playerToAmountDue[winners[i]] += perMatchWinnings;
        }
    }

    function withdrawWinnings() public {}    

    modifier restricted() {
        require(msg.sender == owner);
        _;
    }
}
