// SPDX-License-Identifier: MIT
pragma solidity 0.7.6;

import "./WETH.sol";
import "./SafeMath.sol";

contract DepositContract {
    using SafeMath for uint256;

    address payable public immutable _weth;
    uint256 public constant rewardBase = 5;
    uint256 public immutable startBlock;
    uint256 public immutable endBlock;
    mapping(address => uint256) public depositAmount;
    mapping(address => uint256) public checkPoint;
    mapping(address => uint256) public calculatedReward;
    mapping(address => uint256) public claimedReward;

    event Deposit(address indexed sender, uint256 amount);
    event Claim(address indexed sender, address recipient, uint256 amount);
    event Withdraw(address indexed sender, uint256 amount);

    constructor(address payable _wethAddress, uint256 _period) {
        startBlock = block.number;
        endBlock = block.number + _period + 1;
        _weth = _wethAddress;
    }

    modifier onlyValidTime() {
        require(block.number <= endBlock);
        _;
    }

    function deposit(uint256 _amount) public onlyValidTime returns (bool) {
        require(_amount > 0, "Invalid amount");

        if (depositAmount[msg.sender] != 0) {
            uint256 previousBlockNumber = checkPoint[msg.sender].div(
                depositAmount[msg.sender]
            );
            calculatedReward[msg.sender] =
                calculatedReward[msg.sender] +
                ((block.number - previousBlockNumber) *
                    depositAmount[msg.sender]) /
                rewardBase;
        }
        depositAmount[msg.sender] = depositAmount[msg.sender].add(_amount);
        checkPoint[msg.sender] = _amount.mul(block.number);

        WETH(_weth).transferFrom(msg.sender, address(this), _amount);

        emit Deposit(msg.sender, _amount);
        return true;
    }

    function getPendingReward(address _account)
        public
        view
        returns (uint256 pendingReward)
    {
        if (checkPoint[_account] == 0) return 0;

        uint256 previousBlockNumber = checkPoint[msg.sender].div(
            depositAmount[msg.sender]
        );
        uint256 currentBlock = block.number > endBlock
            ? endBlock
            : block.number;
        pendingReward =
            calculatedReward[_account] +
            ((currentBlock - previousBlockNumber) * depositAmount[msg.sender]) /
            rewardBase -
            claimedReward[_account];
    }

    function claimReward(address payable _toAddress) public returns (bool) {
        uint256 pendingReward = getPendingReward(msg.sender);
        claimedReward[msg.sender] = claimedReward[msg.sender].add(
            pendingReward
        );
        WETH(_weth).withdrawTo(_toAddress, pendingReward);

        emit Claim(msg.sender, _toAddress, pendingReward);
        return true;
    }

    function withdraw(uint256 _amount) public returns (bool) {
        require(
            _amount > 0 && _amount <= depositAmount[msg.sender],
            "Invalid amount"
        );

        claimReward(msg.sender); // 改一下格式 （bool true, )

        uint256 previousBlockNumber = checkPoint[msg.sender].div(
            depositAmount[msg.sender]
        );
        uint256 currentBlock = block.number > endBlock
            ? endBlock
            : block.number;
        calculatedReward[msg.sender] =
            calculatedReward[msg.sender] +
            ((currentBlock - previousBlockNumber) * depositAmount[msg.sender]) /
            rewardBase;
        depositAmount[msg.sender] = depositAmount[msg.sender].sub(_amount);
        checkPoint[msg.sender] = depositAmount[msg.sender].mul(block.number);

        WETH(_weth).withdrawTo(msg.sender, _amount);

        emit Withdraw(msg.sender, _amount);
        return true;
    }

    uint256 counter;

    function addBlockNumber() public {
        counter++;
    }

    function getBlockNumber() public view returns (uint256) {
        return block.number;
    }
}
