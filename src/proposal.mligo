type proposal = {
  key: bytes;
  title: string;
  votes: nat;
  start: timestamp;
  state: string;
}

type proposal_set = (bytes, proposal) big_map

type storage = {
  proposals: proposal_set
}

type parameter =
  Create of string

type return = operation list * storage

let createProposal (title, store : string * storage): return =
  let proposalKey = Crypto.blake2b (Bytes.pack title) in
  let proposal: proposal = {
      key = proposalKey;
      title = title;
      votes = 0n;
      start = Tezos.now;
      state = "DRAFT"
    } in
  let updated_map: proposal_set =
    Big_map.update proposalKey (Some proposal) store.proposals in
  let store = {store with proposals = updated_map}
  in ([] : operation list), store
