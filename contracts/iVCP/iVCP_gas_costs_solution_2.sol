pragma solidity >= 0.8.0;
// SPDX-Lisence-Identifier: MIT
/**
  * @dev implementation of the {invested Vested Creator Pool} or {iVCP} specifications
  * with gas cost solution #2
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

/**
  *  A depositer contract is a helper contract that has a deposit() external
  *  function and a withdraw() external function.
  *
  *  The deposit() function is payable, and uses any Ether sent, and deposits it
  *  into a strategy (Yearn vault, LP, etc.).
  *
  *  The withdraw() function just removes all the funds from that same strategy,
  *  and sends it back to the contracy. This function should be permissioned to
  *  only allow pools to use it, or else anyone could force a withdraw.
  */
interface IDepositer {
  function deposit() external payable;
  function withdraw() external;
}

contract iVCP {
  // payout due to each creator, organised by epoch.
  //     \/ epoch/interval   \/ creator  \/ payout amount
  mapping(uint256 => mapping(address => uint256)) contributed;
  // total deposited each epoch
  mapping(uint256 => uint256) total_deposited;
  mapping(uint256 => mapping(address => bool)) paid;

  // uint64 should be enough
  uint64 epoch = 0;
  uint256 last_payout;
	uint256 constant interval_time = 30 days;
  IDepositer public strategy;

  constructor(
    address _strategy
  ) {
    strategy = IDepositer(_strategy);
  }

  function deposit(
    address creator
  ) public payable {
    contributed[epoch][creator] += msg.value;
    total_deposited[epoch] += msg.value;
    strategy.deposit{value: msg.value}();
  }

  function verify_payout() internal view returns(bool) {
	   return (block.timestamp >= (last_payout + interval_time));
  }

  function calculatePayout(
			uint256 contributed,
			uint256 total,
			uint256 totalDeposited
  ) private pure returns(uint256) {
  	return (contributed * total)/totalDeposited;
  }


  function payout(
    uint64 _epoch
  ) external {
    require(!paid[_epoch][msg.sender], "Already paid out");
    if (!((_epoch * interval_time) < block.timestamp)) {
      // this means that the interval time has passed for _epoch
      if (_epoch == epoch) {
        // if the current epoch is the one that msg.sender is claiming from, and
        // the interval has passed, we need to increment the current epoch number,
        // and withdraw from the strategy
        strategy.withdraw();
        unchecked {
          epoch++;
        }
      }
      payable(msg.sender).transfer(calculatePayout(contributed[epoch][msg.sender], address(this).balance, total_deposited[epoch]));
      paid[_epoch][msg.sender] = true;
    }
	}

}
