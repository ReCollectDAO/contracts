type proposal = {
  key : bytes;
  title : string;
}

type proposal_set = (bytes, proposal) big_map

type storage = {
  proposals : proposal_set
}

type parameter =
  Create of string

type return = operation list * storage

let create (p, s : string * storage) : return =
  let pkey = Crypto.blake2b (Bytes.pack p) in
  let proposal : proposal =
    {key = pkey; title = p} in
  let updated_map: proposal_set =
    Big_map.update pkey (Some proposal) s.proposals in
  let s = {s with proposals = updated_map}
  in ([] : operation list), s


let main (p, s : parameter * storage) : return =
  match p with
  | Create c -> create (c,s)
