pragma solidity >=0.6.8;
import "../interfaces/ILSP7DigitalAsset.sol";
import "../IEasyAuction.sol";
import "../interfaces/ILYX.sol";

contract DepositAndPlaceOrder {
    IEasyAuction public immutable easyAuction;
    ILYX public immutable nativeTokenWrapper;

    constructor(
        address easyAuctionAddress,
        address _nativeTokenWrapper
    ) public {
        nativeTokenWrapper = ILYX(_nativeTokenWrapper);
        easyAuction = IEasyAuction(easyAuctionAddress);
        ILSP7DigitalAsset(_nativeTokenWrapper).authorizeOperator(
            easyAuctionAddress,
            uint256(-1),
            ""
        );
    }

    function depositAndPlaceOrder(
        uint256 auctionId,
        uint96[] memory _minBuyAmounts,
        bytes32[] memory _prevSellOrders,
        bytes calldata allowListCallData
    ) external payable returns (uint64 userId) {
        uint96[] memory sellAmounts = new uint96[](1);
        require(msg.value < 2 ** 96, "too much value sent");
        nativeTokenWrapper.deposit{value: msg.value}();
        sellAmounts[0] = uint96(msg.value);
        return
            easyAuction.placeSellOrdersOnBehalf(
                auctionId,
                _minBuyAmounts,
                sellAmounts,
                _prevSellOrders,
                allowListCallData,
                msg.sender
            );
    }
}
