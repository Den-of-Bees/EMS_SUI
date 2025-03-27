module ems_sui::liquidity_provider {
    use sui::object::{Self, UID};
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::balance::{Self, Balance};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use ems_sui::ems_coin::EMS_COIN;
    use sui::sui::{Self, SUI};

    public struct LIQUIDITY_PROVIDER has drop {}

    public struct Pool has key {
        id: UID,
        sui_balance: Balance<SUI>,
        ems_balance: Balance<EMS_COIN>,
        lp_token_balance: TreasuryCap<LIQUIDITY_PROVIDER>
    }

    public struct AdminCap has key {
        id: UID
    }

    fun init(witness: LIQUIDITY_PROVIDER, ctx: &mut TxContext) {
        transfer::transfer(AdminCap {
            id: object::new(ctx)
        }, tx_context::sender(ctx));

        let (treasury_cap, metadata) = coin::create_currency<LIQUIDITY_PROVIDER>(
            witness, 
            9, 
            b"LP-EMS-SUI",
            b"EMS-SUI LP Token",
            b"Liquidity provider token for EMS-SUI pool",
            option::none(), 
            ctx
        );

        transfer::public_transfer(metadata, tx_context::sender(ctx));

        let pool = Pool {
            id: object::new(ctx),
            sui_balance: balance::zero(),
            ems_balance: balance::zero(),
            lp_token_balance: treasury_cap
        };  

        transfer::share_object(pool);
    }

}