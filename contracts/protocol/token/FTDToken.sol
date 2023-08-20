// SPDX-License-Identifier: AGPL-3.0
pragma solidity ^0.8.0;

import { ERC20VotesUpgradeable } from "../../dependencies/openzeppelin/contracts-upgradeable/token/ERC20/extensions/ERC20VotesUpgradeable.sol";
import {IFTDToken} from '../../interfaces/IFTDToken.sol';
import {FilAddress} from '../libraries/utils/FilAddress.sol';

/**
 * @title FTDToken
 * @author STFIL
 **/
contract FTDToken is IFTDToken, ERC20VotesUpgradeable {
  using FilAddress for address;

  uint256 public constant TOTAL_SUPPLY = 500000000 ether;

  /// @custom:oz-upgrades-unsafe-allow constructor
  constructor() {
    _disableInitializers();
  }

  /**
   * @dev Initializes the FTDToken
   */
  function initialize() external initializer {
    __ERC20_init("FTDToken","FTD");
    __ERC20Permit_init("FTDToken");
  }

  /**
   * @dev Mint `amount` tokens to the `account`.
   */
  function mint(address account, uint256 amount) external {
    account = account.normalize();
    
    require(amount + totalSupply() <= TOTAL_SUPPLY, "FTDToken: total supply overflowing");
    _mint(account, amount);

    emit Mint(account, amount);
  }

  /**
   * @dev Destroys `amount` tokens from the caller.
   */
  function burn(uint256 amount) external {
    address sender = _msgSender().normalize();
    _burn(sender, amount);

    emit Burn(sender, amount);
  }

  /**
   * @dev Destroys `amount` tokens from `account`, deducting from the caller's
   * Requirements:
   *
   * - the caller must have allowance for ``accounts``'s tokens of at least
   */
  function burnFrom(address account, uint256 amount) external {
    account = account.normalize();
    address sender = _msgSender().normalize();
    _spendAllowance(account, sender, amount);
    _burn(account, amount);

    emit BurnFrom(sender, account, amount);
  }
}