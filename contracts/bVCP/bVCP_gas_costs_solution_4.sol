pragma solidity >= 0.8.0;
// SPDX-Lisence-Identifier: MIT
/**
  * @dev implementation of the {basic Vested Creator Pool} or {bVCP} specifications
  * with gas cost solution #4
  *
  * @notice In this case, claiming a creator's royalties awards the claimer 0.5%
  * of those funds.
  *
  * From the whitepaper:
  *
  * "A Creator Pool [...] is a royalties model which works more as a pay check,
  * rather than a constant stream of income. The basic idea behind this model
  * is that royalties do not go directly to the creator, instead, royalties are
  * sent to a pool. This pool gets emptied out in intervals, and every NFT
  * collection’s creator is paid out in proportion to what they contributed."
  *
  * Author: z.ftm or RandomZ. Contact: https://ohmki.t.me/
  */
contract bVCP {
  // payout due to each creator, organised by epoch.
  //     \/ epoch/interval   \/ creator  \/ payout amount
  mapping(uint256 => mapping(address => uint256)) payouts;
  mapping(uint256 => mapping(address => bool)) paid;

  // uint64 should be enough
  uint64 epoch = 0;
  uint256 constant interval_time = 30 days;


  function deposit(
    address creator
  ) public payable {
    payouts[epoch][creator] = payouts[epoch][creator] + msg.value;
  }

  // this is permissionless so a creator address should be passed in to allow
  // claiming for any address.
  function payout(
    uint64 _epoch,
    address creator
  ) external {
    require(!paid[_epoch][creator], "Already paid out");
    if (!((_epoch * interval_time) < block.timestamp)) {
      // this means that the interval time has passed for _epoch
      if (_epoch == epoch) {
        // if the current epoch is the one that msg.sender is claiming from, and
        // the interval has passed, we need to increment the current epoch number
        unchecked {
          epoch++;
        }
      }
      (uint256 fee, uint256 payout) = (payouts[_epoch][creator]/200, (199*payouts[_epoch][creator])/200);
      payable(creator).transfer(payout);
      payable(msg.sender).transfer(fee);
      paid[_epoch][creator] = true;
    }
	}

}
