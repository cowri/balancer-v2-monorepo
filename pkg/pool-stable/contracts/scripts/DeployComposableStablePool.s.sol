pragma solidity ^0.7.0;

import "../ComposableStablePool.sol";
import "forge-std/Script.sol";
pragma experimental ABIEncoderV2;

contract DeployComposableStablePool is Script {
    ComposableStablePool pool;

     struct NewPoolParams {
        IVault vault;
        IProtocolFeePercentagesProvider protocolFeeProvider;
        string name;
        string symbol;
        IERC20[] tokens;
        IRateProvider[] rateProviders;
        uint256[] tokenRateCacheDurations;
        bool[] exemptFromYieldProtocolFeeFlags;
        uint256 amplificationParameter;
        uint256 swapFeePercentage;
        uint256 pauseWindowDuration;
        uint256 bufferPeriodDuration;
        address owner;
        string version;
    }

    function run() external {
        vm.startBroadcast();
      
       IERC20[] memory tokens = new IERC20[](2);
       tokens[0] = IERC20(0x5979D7b546E38E414F7E9822514be443A4800529);
       tokens[1] = IERC20(0x82aF49447D8a07e3bd95BD0d56f35241523fBab1);

       IRateProvider[] memory providers = new IRateProvider[](2);
       providers[0] = IRateProvider(0xf7c5c26B574063e7b098ed74fAd6779e65E3F836);
       providers[1] = IRateProvider(address(0));

       uint256[] memory tokenRateCacheDurations = new uint256[](2);
       tokenRateCacheDurations[0] = 21600;
       tokenRateCacheDurations[1] = 21600;

       bool[] memory exemptFromYieldProtocolFeeFlags = new bool[](2);
       exemptFromYieldProtocolFeeFlags[0] = false;
       exemptFromYieldProtocolFeeFlags[1] = false;

        ComposableStablePool.NewPoolParams memory params;
        params.vault = IVault(0xBA12222222228d8Ba445958a75a0704d566BF2C8);
        params.protocolFeeProvider = IProtocolFeePercentagesProvider(0x5ef4c5352882b10893b70DbcaA0C000965bd23c5);
        params.name = "Balancer wstETH-WETH Stable Pool";
        params.symbol = "wstETH-WETH-BPT";
        params.tokens = tokens;
        params.rateProviders = providers;
        params.tokenRateCacheDurations = tokenRateCacheDurations;
        params.exemptFromYieldProtocolFeeFlags = exemptFromYieldProtocolFeeFlags;
        params.amplificationParameter = 5000;
        params.swapFeePercentage = 100000000000000;
        params.pauseWindowDuration = 5000;
        params.bufferPeriodDuration = 0;
        params.owner = 0x8153309efc8c86fD3fa897509A3c9D07fa8e8D0A;
        params.version = "v1";

        pool = new ComposableStablePool(params);

        console.log(address(pool));
    }
}
