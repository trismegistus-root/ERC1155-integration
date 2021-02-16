# Replatform - ERC155-integration  
## What it is  
ERC1155 for multi-token minting from a single contract under Replatform umbrella

## What it does  
The ERC1155, ERC20 treasury system, permits for a tradeable token as a "gold-standard" for deplatformed communities. Given the times in which we live, no one can be certain that their favorite online community will exist tomorrow. The Replatform contract provides a token for anonymous verification of identity. Thus, if a community is disbanded, all the token owners from that community would be able to find one another without ever revealing their true identities. Every community is able to draw from the treasury to supply their favorite forum, board, or channel with a common identity that is completely on the blockchain and removed from the whims of censorship. 

## How it does it  
A community may request a token be minted for them. A community owner is designated, or a wallet is created on their behalf. That token is an ERC1155 token. When a certain number of these tokens is minted for a community, it locks a corresponding value of the ERC20 token so that it may not be purchased or sold, diminishing the overall supply. This is the gist of the ERC20Treasury contract that can be found in the main branch. The ERC20s can be sold for a future stake in governance of the platform. Governors are ERC20 purchasers or ERC20 locked-supply communities. Governance will remain in the hand of the original developer until the number of community IDs in the Replatform mapping guarantees that no one community can overrule another, encouraging cooperation. NOTE: *A community does not OWN a Replatform Token, but locks it up, preventing sale. Furthermore, that community is granted the same voting rights as if they did own that token. That way no bad-faith community owner can sell the tokens from beneath the community. They can only return the excess to the treasury.*

## Improvements on the deprecated Replatform contract(s)
The original Replatform Token was a single ERC20 token doing the work for multiple token contracts. 
By implementing the ERC1155 token (potentially with some dev defined additions to the OpenZeppelin design implementations), 
we should be able to make a multi-token contract that permits communities to pull from a pre-defined pool of token to dedicate 
to their specific community. 

# NEXT STEPS  
## Oracles  
While the goal is to launch the token as quickly and safely as possible(considering the culturale climate), the end-goal is to implement blockchain oracles to monitor the 404 status of any community. The oracles will detect if a community has been deplatformed, and immediately launch a "safe house" for the community and disallow any further minting of the token until the community decides it is safe to permit new members. 
