pragma solidity >= 0.8.0;
// SPDX-Lisence-Identifier: MIT
/**
  * @dev implementation of the {invested Vested Creator Pool} or {iVCP} specifications
  * with gas cost solution #1
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
  // all the creators that have participated in the current epoch.
  mapping(uint256 => address[]) creators;
  // a mapping to check if a creator has participated in an epoch, just to make
  // sure we don't try payout a creator more than one time.
  mapping(uint256 => mapping(address => bool)) has_participated;
  // total deposited each epoch
  mapping(uint256 => uint256) total_deposited;

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
    if (!has_participated[epoch][creator]) {
      creators[epoch].push(creator);
      has_participated[epoch][creator] = true;
    }
    total_deposited[epoch] += msg.value;
    strategy.deposit{value: msg.value}();
    payout();
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


  function payout() public {
	  if (verify_payout()) {
      strategy.withdraw();
		  // implement payout logic here
      for (uint64 i = 0; i < creators[epoch].length;) {
        address creator = creators[epoch][i];
        payable(creator).transfer(calculatePayout(contributed[epoch][creator], address(this).balance, total_deposited[epoch]));
        unchecked { i++; }
      }
      last_payout = block.timestamp;
      // small gas save
      unchecked { epoch++; }
	  }
     // do nothing if the interval time has not passed
	}

}
