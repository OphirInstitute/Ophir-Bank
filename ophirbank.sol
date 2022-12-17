//SPDX-License-Identifier: MIT

pragma solidity <=0.8.7;

 import "./OphirPriceConverter.sol";

 //Contract deployment fee

 //moree reduction 794,164

 //792,524

 //After 817,623

 //Before 837, 177

error NotOwner();


contract ophirbank {
    
    using OphirPriceConverter for uint256;

    uint256 public  constant MINIMUM_FEE = 150 * 1e18;

    //Minimum Fee constant

    // Before 23,515
    // After  21,415

    //Keep track of all addresss sending us money

    address [] public clients;
    mapping(address => uint256) public addresstoClientsFunds;

   address public i_owner;

    constructor(){
      //setting equivalent
        i_owner = msg.sender;
    }

    //gas for owner 21,508
    // 23,644

    //c8df3ab1000000000000000000000000f16c4aec59408b9023e1eb14d5824fdcfef5531f

    //f88af21d0000000000000000000000000000000000000000000000000000000000000096

    //0xaf46f6d2B3EE8d29Cd6F53edb83ec69D554c11D6
    //0xc45Efd0Ff985DC2ecC777522933f092FC86dd778

    function fundbank() public payable {
    /* Problem1: We want to make sure that ETH smartcontract understands that we are funding ETH 
                 with respect to USD */
    // Problem2: How do we send ETH to this contract?

    //getConversionRate(msg.value);
    //same as
    //msg.value.getConversionRate();
    require(msg.value.getConversionRate() >= MINIMUM_FEE, "Not enough!"); //1e10 == 10 ** 18 == 1000000000000000000

    clients.push(msg.sender);
    addresstoClientsFunds[msg.sender] = msg.value;
   
     }

     function obtainfunds() public onlyOwner {

       

        //for loop

       /*starting index, ending index, step amount */

       for(uint256 clientIndex = 0; clientIndex < clients.length; clientIndex++) {
            address client = clients[clientIndex];
            addresstoClientsFunds[client] = 0;
       }
       
       //reset the array
       clients = new address [](0);
       
      //Withdrawing funds

      //transfer: reverts automatically
      //payable(msg.sender).transfer(address(this).balance);
    
      //send
      //bool sendSuccess = payable(msg.sender).send(address(this).balance);
      //require (sendSuccess, "sendFailed");

      //call

      (bool callSuccess, /*bytes memory dataReturned*/ ) = payable(msg.sender).call{value: address(this).balance}("");
      require (callSuccess, "callfailed");

     }

    modifier onlyOwner {

      if(msg.sender != i_owner) {revert NotOwner();}
      
      //require(msg.sender == i_owner, "sender is not owner!");
      _;

    }

    receive () external payable {
      fundbank();
    }

    fallback () external payable {
      fundbank();
    }
  
 }


//0xb4E243a74b596884cCE5480fc94A085EfB765d5e
