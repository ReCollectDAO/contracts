type proposal = {
  key : bytes;
  title : string;
}

type proposal_set = (address, proposal) big_map

type storage = {
  proposals : proposal_set
}

type parameter =
  Create of string

type return = operation list * storage

let create (p, s : string * storage) : return =
  let proposal : proposal =
    {key = Crypto.blake2b (Bytes.pack p); title = p} in
  let updated_map: proposal_set =
    Big_map.update Tezos.sender (Some proposal) s.proposals in
  let s = {s with proposals = updated_map}
  in ([] : operation list), s


let main (p, s : parameter * storage) : return =
  match p with
  | Create c -> create (c,s)
