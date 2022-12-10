pragma solidity >= 0.8.0;
// SPDX-Lisence-Identifier: MIT
/**
  * @dev implementation of the {basic Vested Creator Pool} or {bVCP} specifications
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
  * This is different to the EVM-compatiable contract, because on Solana, sending
  * value on CPI's isn't allowed. So we need to permission the deposit function,
  * only allowing some addresses to modify the amount that has to be paid out to
  * the creator.
  *
  * The way this works is:
  *  - NFT gets bought for 100 SOL @ 5% royalty
  *  - Marketplace contract sends 5 SOL to the bVCP
  *  - Marketplace contract calls deposit(address,uint64), uint64 being the
  *    royalty amount
  * Permissioning the deposit() call makes sure this can only be called by the
  * marketplace contract and in this order.
  */

contract bVCP_1 {
  // payout due to each creator, organised by epoch.
  //     \/ epoch/interval   \/ creator  \/ payout amount
  mapping(uint256 => mapping(address => uint64)) payouts;
  // all the creators that have participated in the current epoch.
  mapping(uint256 => address[]) creators;
  // a mapping to check if a creator has participated in an epoch, just to make
  // sure we don't try payout a creator more than one time.
  mapping(uint256 => mapping(address => bool)) has_participated;
  // addresses allowed to call deposit()
  mapping(address => bool) depositers;

  // uint64 should be enough
  uint64 epoch = 0;
  uint256 last_payout;
	uint256 constant interval_time = 30 days;
  address admin;

  modifier onlyDepositer {
    require(depositers[msg.sender], "Not a depositer");
    _;
  }

  constructor(
    address manager,
    address marketplace
  ) {
    admin = manager;
    depositers[marketplace] = true;
  }

  function deposit(
    address creator,
    uint64 amount
  ) public onlyDepositer {
    payouts[epoch][creator] = payouts[epoch][creator] + amount;
    if (!has_participated[epoch][creator]) {
      creators[epoch].push(creator);
      has_participated[epoch][creator] = true;
    }
    payout();
  }

  function verify_payout() internal view returns(bool) {
	   return (block.timestamp >= (last_payout + interval_time));
  }

  function payout() public {
	  if (verify_payout()) {
		  // implement payout logic here
      for (uint64 i = 0; i < creators[epoch].length;) {
        address creator = creators[epoch][i];
        payable(creator).transfer(payouts[epoch][creator]);
        unchecked { i++; }
      }
      last_payout = block.timestamp;
      // small gas save
      unchecked { epoch++; }
	  }
     // do nothing if the interval time has not passed
	}

  function mod_depositer(address depositer, bool to) external {
    require(msg.sender == admin);
    depositers[depositer] = to;
  }

  function change_admin(address _new) external {
    require(msg.sender == admin);
    admin = _new;
  }

}
