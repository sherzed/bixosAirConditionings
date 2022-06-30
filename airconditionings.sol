// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
interface AirConditioings {
    function getAcDetail(uint256 acId) external view returns (address,uint256,uint256);
    function setAdmin(uint256 acId, uint256 tokenValue) external;
    function setDegree(uint256 acId, uint256 _degree) external;

    event acOwnerChanged(address newOwner, uint256 ac_changed);
    event acDegreeChanged(uint256 ac_changed,uint256 newDegree);
    event TransferReceived(address _from, uint _amount);
    event TransferSent(address _from, address _destAddr, uint _amount);
}

contract SetAirConditioing is AirConditioings {
    IERC20 private _ubxsToken; 

    constructor(address tokenAddress) {
        _ubxsToken = IERC20(tokenAddress); 
    }
    uint256 [4] tokenAmount; uint256 [4] acDegree; address [4] wallet;
     
    function getAcDetail(uint256 acId) public view override returns (address,uint256,uint256) {
        return (wallet[acId],tokenAmount[acId],acDegree[acId]);
    }

     function setAdmin(uint256 acId, uint256 tokenValue) public override {

        require(acId<tokenAmount.length,"out of bounds");
        require(tokenAmount[acId]<tokenValue,"Don't be afraid to take risks, increase the price :)");
        require( 
            _ubxsToken.transferFrom(msg.sender, address(this), tokenValue),
            "Transaction Error"
        );
        wallet[acId]= msg.sender;
        tokenAmount[acId] = tokenValue;
        emit acOwnerChanged(msg.sender,acId);
    }

    function setDegree(uint256 acId, uint256 _degree) public override {
        require(acId<4,"We only have 4 air conditioners :( Please choose between 0-3.");
        require(wallet[acId] == msg.sender, "The owner of the air conditioner does not appear here.");
        require(_degree>15&&_degree<33,"Values must be between 16-32.");
        acDegree[acId]=_degree;
        emit acDegreeChanged(acId,acDegree[acId]);
    }
 }
