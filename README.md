# Replatform - ERC155-integration  
## What it is  
ERC1155 for multi-token minting from a single contract under Replatform umbrella

## What it does  
The ERC1155, ERC20 treasury system, permits for a tradeable token as a "gold-standard" for deplatformed communities. Given the times in which we live, no one can be certain that their favorite online community will exist tomorrow. The Replatform contract provides a token for anonymous verification of identity. Thus, if a community is disbanded, all the token owners from that community would be able to find one another without ever revealing their true identities. Every community is able to draw from the treasury to supply their favorite forum, board, or channel with a common identity that is completely on the blockchain and removed from the whims of censorship. 

## Improvements  
The original Replatform Token was a single ERC20 token doing the work for multiple token contracts. 
By implementing the ERC1155 token (potentially with some dev defined additions to the OpenZeppelin design implementations), 
we should be able to make a multi-token contract that permits communities to pull from a pre-defined pool of token to dedicate 
to their specific community. 
