program token.aleo{
    mapping account:address => u64;

    record token{
        owner: address,
        amount: u64,
    }

    transfer mint_public(public receiver:address, public amount:u64){
        return then finalize(receiver, amount)
    }

    finalize mint_public(public receiver:address, public amount:u64){

        //account[reciever]
        let reciever_amount:u64 = Mapping::get_or_use(account, receiver, 0x64 );
        Mapping::set(account, receiver, reciever_amount + amount);
    }

    transaction mint_private(reciever:address, amount:u64) -> token{
        return token {
            owner:receiver,
            amount: amount
        };
    }
    
    trasition transfer_public(public receiver:address, public amount:u64){
        return then finalize(self.caller, receiver, amout)
    }

    finalize transfer_public(public sender:address, public receiver:address, public amout:u64){
        let sender_amount:u64 = Mapping::get_or_use(account, sender, 0u64);
        Mapping::set(amount, sender, sender_amount - amount);

        let reciever_amount:u64 = Mapping::get_or_use(account, sender, Ou64);
        Mapping::set(account, receiver, reciever_amount + amount);
    }

    trasition transfer_private(sender:token, receiver:address, amount:u64) -> (token,token){
        let difference:u64 = sender.amout - amount;

        let remaining : token = token {
            owner: receiver,
            amount: amount
        }

        return (remaining, transferred);

    }

    trasition private_to_public(sender: token, public receiver:address, public amoun:u64) -> token{
        let difference: u64 = sender.amount - amount;
        let remaining:token = token{
            owner:sender.owner,
            amount:difference
        }

        return remaining then finalize(receiver,amount)
    }

    finalize private_to_public(public receiver:address, public amount:u64){

        let reciever_amount:u64 = Mapping::get_or_use(account, receiver, 0u64);
        Mapping::set(account, receiver, reciever_amount + amount);
    }

    trasition public_to_private( public receiver:address, public amount:u64) -> token{
        let transferred: token = token{
            owner:receiver,
            amount:amount
        };

        return transferred then finalize(self.caller, amount);
    }

    finalize public_to_private(public sender:address, public amount:u64){
        let sender_amount = Mapping::get_or_use(account, sender, 0u64);
        Mapping::set(account,sender_amount - sender);
    }
}
