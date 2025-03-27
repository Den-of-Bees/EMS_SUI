
/// Module: ems_sui
module ems_sui::ems_coin {
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    
    public struct EMS_COIN has drop {}

    fun init (witness: EMS_COIN, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<EMS_COIN>(
            witness,
            9,
            b"EMS",
            b"EMS",
            b"The official testing coin of EMS",
            option::none(),
            ctx
        );
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx));
    }

    public fun mint(
        treasury_cap: &mut TreasuryCap<EMS_COIN>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx)
    }

    public fun burn(treasury_cap: &mut TreasuryCap<EMS_COIN>, coin: Coin<EMS_COIN>) {
        coin::burn(treasury_cap, coin);
    }


}