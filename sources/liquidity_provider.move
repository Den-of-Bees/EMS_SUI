module ems_sui::liquidity_provider {
    use sui::object::{Self, UID};
    use sui::coin::{Self, Coin};
    use sui::balance::{Self, Balance};
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;
    use ems_sui::ems_coin::EMS_COIN;
    use sui::sui::{Self, SUI};

    public struct Pool has key {
        id: UID,
        sui_balance: Balance<SUI>,
        ems_balance: Balance<EMS_COIN>
    }

    fun init(ctx: &mut TxContext) {
        let pool = Pool {
            id: object::new(ctx),
            sui_balance: balance::zero(),
            ems_balance: balance::zero()
        };  
        transfer::share_object(pool);
    }
}