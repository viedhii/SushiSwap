pragma solidity >=0.8.0;
import "hardhat/console.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./SushiSwap.sol";

contract MySolidityProject{
     address sushiSwapFactoryAddr = 0xc35DADB65012eC5796536bD9864eD8773aBc74C4; 
    SushiV2Factory factory =  SushiV2Factory(sushiSwapFactoryAddr);


    function getResult(uint i) external view  returns(address , uint, uint ){
        address addr = SushiV2Factory(factory).allPairs(i);
        (uint reserve0 ,uint reserve1)= SushiV2Router02(addr).getReserves();
        return (addr,reserve0,reserve1);
  
    }
//contract TestUniswapLiquidity {
    address private constant FACTORY = 0xc35DADB65012eC5796536bD9864eD8773aBc74C4;
    address private constant ROUTER = 0x1b02dA8Cb0d097eB8D57A175b88c7D8b47997506;
  //address private constant WETH = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;

  event Log(string message, uint val);
///////////////////////////////////////////////////////////Add Liquidity Function////////////////////////////////////////////////////


 // Development docs link : https://dev.sushi.com/sushiswap/contracts
 // SushiV2Router02 this interface has addliquidity function
 // SushiV2Router02  etherscan address -> 0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F  to check for code(i.e code/read/write)

  function addLiquidity(
    address _tokenA,
    address _tokenB,
    uint _amountA,
    uint _amountB
  ) external {
    IERC20(_tokenA).transferFrom(msg.sender, address(this), _amountA);
    IERC20(_tokenB).transferFrom(msg.sender, address(this), _amountB);

    IERC20(_tokenA).approve(ROUTER, _amountA);
    IERC20(_tokenB).approve(ROUTER, _amountB);

    (uint amountA, uint amountB, uint liquidity) =
      SushiV2Router02(ROUTER).addLiquidity(
        _tokenA,
        _tokenB,
        _amountA,
        _amountB,
        1,
        1,
        msg.sender,
        block.timestamp
      );

    emit Log("amountA", amountA);
    emit Log("amountB", amountB);
    emit Log("liquidity", liquidity);
    
  }
 /////////////////////////////////////////////////Remove Liquidity Function///////////////////////////////////////////////////////////////////

  function removeLiquidity(address _tokenA, address _tokenB) external {
    address pair = SushiV2Factory(FACTORY).getPair(_tokenA, _tokenB);

    uint liquidity = IERC20(pair).balanceOf(msg.sender);
    
     IERC20(0xC4cbedE6C5cc7D0C775AdFC76803c5888c1530f0).transferFrom(msg.sender, address(this), liquidity); 
     IERC20(pair).approve(ROUTER, liquidity);
  
    (uint amountA, uint amountB) =
      SushiV2Router02(ROUTER).removeLiquidity(
        _tokenA,
        _tokenB,
        liquidity,
        1,
        1,
        msg.sender,
        block.timestamp
      );

    emit Log("amountA", amountA);
    emit Log("amountB", amountB);
   
  }
} 

