#include "proposal.mligo"

let dao_contract (p, s : parameter * storage) : return =
  match p with
  | Create c -> createProposal (c,s)
