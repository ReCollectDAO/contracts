#include "proposal.mligo"

let dao_contract (parameter, store : parameter * storage) : return =
  match parameter with
  | Create title -> createProposal (title,store)
