// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.0;

import {IERC20Upgradeable} from "../dependencies/openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";

interface IFTDToken is IERC20Upgradeable {
  /**
   * @dev Emitted on mint()
   **/
  event Mint(address indexed account, uint256 amount);

  /**
   * @dev Emitted on burn()
   **/
  event Burn(address indexed account, uint256 amount);

  /**
   * @dev Emitted on burnFrom()
   **/
  event BurnFrom(address indexed sender, address indexed account, uint256 amount);

   /**
    * @dev Mint `amount` tokens to the `account`.
    */
  function mint(address account, uint256 amount) external;

   /**
    * @dev Destroys `amount` tokens from the caller.
    */
  function burn(uint256 amount) external;

  /**
   * @dev Destroys `amount` tokens from `account`, deducting from the caller's
   * Requirements:
   *
   * - the caller must have allowance for ``accounts``'s tokens of at least
   */
  function burnFrom(address account, uint256 amount) external;

  /**
   * @dev Returns the mint supply.
   */
  function mintSupply() external view returns (uint256);
}
