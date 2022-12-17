//SPDX-License-Identifier: MIT

  pragma solidity <=0.8.7;

  import "https://github.com/smartcontractkit/chainlink/blob/develop/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

     library OphirPriceConverter {
         //function to get the price of ETH/USD

           function getPrice() internal view returns (uint256) {

        //ABI
        //Address: 0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);

        (,int256 answer,,,) = priceFeed.latestRoundData();
        
        //Typecasting
        return uint256 (answer * 1e10);
    }

    function getVersion() internal view returns (uint256) {

        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }


    function getConversionRate(uint256 ethAmount) internal view returns(uint256) {
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD = (ethPrice * ethAmount) / 1e18;

        return ethAmountInUSD;
    }



     }
     
