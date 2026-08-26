# Reorg Caps and Confirmation Delays: A Primer on Finality Arbitration

A reorg cap is a "reorganization cap"; in other words, a "reorganization limit," or a "soft finality threshold."

Under any of these terms, the value defines the limits of a window that a client (aka a "node") on a decentralized Proof-of-Work network would use to differentiate _mutable_ and _immutable_ chain data.

Now, if you're reading the word "immutable" above with the intuition or connotation that Proof-of-Work blockchain data is always perfectly immutable, I must first challenge this common misconception.

The _Immutability Promise_ of the Ethereum Classic does not speak directly to any particular set, complete or partial, of chain data. Instead, it speaks to __the intention of continuing a network and database protocol  as designed _ad infinitum___. And in fact, the Proof-of-Work based protocol described in the famous Yellow Paper as the specification for Ethereum (and by association Ethereum Classic), relies deeply on the absence of any node's supposition of any chain data permanence.

Because nodes must use shared consensus rules to arrive independently at equivalent chain data states, these rules are limited to the domain of variables that exist as features of the chain data itself, and can be validated and generated with specification-derived function implementations. Values as such would include `total difficulty`, `mix hash`, and `state root`. 

These characteristic validations of chain data as the sole conditions under which nodes arrive at common chain data states enables the decentralized Byzantine Fault Tolerance of the network. Nodes are never coerced into a permanent reliance on any peer, set of peers, or single temporal understanding of the network state. Nodes may be fooled for a minute, or even a week, but _in the long run_, and granted clearly defined network preconditions (usually mostly benevolent peers and miners), they are certain to arrive at the common truth: consensus. 

### Reorg caps

Reorg caps are extra-protocol (not defined in protocol) variables that nodes _can_ use to make arbitrary assumptions about chain data state permanence. Again, this would represent an assumption made outside of consensus rules. And further, as we'll see, may in fact be in _direct contradiction_ of the protocol's consensus rules.

Let's say _Node A_ has a reorg cap of 3,000 blocks. This means that if the node believes the latest chain head number is 10,000, then _Node A_ will be unwilling to follow any valid chain that has a "common ancestor" at block 6,999 or below -- even if that "new" chain is 100,000 blocks long, with 10000000x higher total difficulty, and is completely valid according to the specification-defined block succession consensus rules.

Now, let's say _Node B_ has the same reorg cap of 3,000 blocks. But _Node B_ happens to physically located next-door to a miner, and hears about and imports a block numbered 10,001 before _Node A_ does. Then, by some miracle or tragedy, the 100,000-long chain is announced and both _Node A_ and _Node B_ hear about this new chain candidate at the same time. The new chain happens to have a common ancestor on both nodes _A_ and _B_ at block 7,000. 

In this case, _Node A_, having a latest head block of 10,000 -- placing the common ancestor within the reorg limit of 3,000 (10,000-3,000=7,000) -- will allow the reorganization, and reorganize its block database in order to download the new, valid, 100,000-block chain. _Node B_, on the other hand, having already imported block 10,001 (which was a perfectly valid block, although obviously inferior to the propagated 100,000th block), will refuse the reorganization, since its 3,000-block reorganization limit prevents it from ever changing any blocks below block 7,001. _Node B_ is now incapable of syncing with the 100,000-block chain, and will be doomed to this consensus failure...

That is, unless _Node B_'s operator decides to trust the hearsay on Twitter, and purge the node's already-downloaded chain data, and attempt synchronization with the network again. When and if so, it ~~will~~ may be able to validate and import the 100,000 block chain, and achieve consensus with _Node A_. It will fail this 2nd synchronization attempt (again) if the peer or peers it connects with report to it the still-shorter 10,001-block chain before it is able to learn of or process the 100,000-block chain. In which case, the node operator must again consult their oracles...

Since, as above, _Node B_'s consensus issue can be resolved (at least potentially, and temporarily) by manually overriding its temporal and subjective "view" of the network, reorg caps are understood as "soft finality" values. 

![reorg-limits-png](https://user-images.githubusercontent.com/45600330/89716130-0748d680-d970-11ea-94af-dc1cb5a57206.png)

### Reorg caps in theory and practice

In theory, there is NO specification or allowance for reorganization caps in Ethereum or Ethereum Classic's PoW blockchain protocol. As stated and hopefully clearly exemplified above, they are, in fact, theoretically in _contradiction_ with the foundational assumptions of the consensus protocol.

In practice, they exist. OpenEthereum apparently has a reorg cap of 3,000. And in practice, on August 1, 2020, this non-protocol consensus-impacting value caused a chain split (or _splits_!), with OpenEthereum nodes unable to achieve the correct consensus-protocol validated network state when a miner on Ethereum Classic broadcasted a valid chain segment 3,671 blocks in length. 

A reorg cap called the `FullImmutabilityThreshold` (for fast and full-sync configurations) and `LightImmutabilityThreshold` (for LES configurations) also exists in Core-Geth and ethereum/go-ethereum, set to 90,000 and 30,000 respectively. These values, in regard to chain data consensus, are assumed and intentionally designed to be "impossibly high," representing a developer-granted assumption that they _should never_ actually be used in sync protocol. These values exist to facilitate the practicalities of database optimizations, namely a separation of chain data into two databases, one called the "Ancient Store," which is an immutable data store designed to store archival chain data with extreme efficiency, optimizing disk use and IO. Blocks whose numbers come to fall below this limit (say, block 909,999 of a 1,000,000-block chain) are assumed safe-to-move to the ancient store, and thereby optimizing the program's disk use. 

If a miner broadcasts a "new," valid, and difficulty-dominant 100,000-block chain segment to the surprise of the network, both OpenEthereum and Core-Geth (and ethereum/go-ethereum) will be caught severely vulnerable. By the consensus-relevant difficulty algorithm, a 90,000-block segment would take about about 2-weeks of mining to generate.

### Reorg caps and confirmation delays 

Reorgs caps are often, though mistakenly, associated with the user-facing values cryptocurrency exchanges present to users as _Confirmation Delays_. Exchanges use confirmation delays to decide the window at which they feel it is "safe" to finally authorize account deposits and withdrawals pending a transaction with a given chain. Once a transaction is processed by the chain network, if a subsequent chain reorganization with a magnitude inside of their confirmation delay happens, the exchange is able to simply abort the transaction on the Exchange side and prompt the user the user to try again, having lost nothing materially themselves nor on behalf of their users. 

The Confirmation Delay implemented by an Exchange represents their assumed risk profile relative to the chain. A healthy and competitive Exchange will use a variety of real-time metrics (eg. hash rate, node count, pair prices, transaction throughput, historical variance, &c.) for any given chain to produce an adaptive and accurate representation of their desired risk profile with that chain; some chains want to edge to lower riskier values because they want to compete for users by providing a "snappy" service, while other chain choose more conservative stances.

Reorgs caps would potentially obstruct node implementation of the network's consensus specifications by enforcing immutability against arbitrary chain segments. Confirmation delays, like reorg caps, are subjective decisions about finality. Unlike reorg caps, however, confirmation delays govern sovereign behavior _off-chain_ (eg. fiat payout for a withdrawal), whereas node reorg caps may effect _on-chain_ network, and thus state, behavior.



### FAQs

- __Wouldn't equivalent Exchange Confirmation Delays and Client Reorg Caps synergize to prevent 51% attacks?__

No. For one, we cannot expect, let alone encourage, _all_ Exchanges to adopt the same confirmation delays. Secondly, as described above, _reorg caps are impossible to implement at the network level_, since nodes are decentralized and the consensus mechanisms depend on the ability of each node to use the same consensus algorithms independently and asynchronously to arrive at the same chain state. Clients (nodes) implementing actionable reorg caps present a distinct threat to themselves and overall network health. Confirmation Values, on the other hand, are an excellent way for Exchanges (and everyone!) to mitigate risk. Reorg caps in clients do not mitigate risk: they _increase_ it by potentially antagonizing and prohibiting necessary consensus functions.

- __Can reorg caps be implemented as configuration values if we use a hard fork?__

No. Well, yes... but no, definitely not. 

You can write a software ~~feature~~ bug that will cause a node to begin to use a certain reorg cap once it sees a certain hard forking block (number) become available. And you can theoretically write code for the clients so that they all use the same cap value, and activate it at the same hard fork number.

But you can't get the all nodes to access and process the same network state(s) at the same time, which means that although they'll use the same cap value beginning at the same activation number, they won't necessarily _utilize_ that logic in ways that concur with each other. The logic can be implemented for the node, but not the network. 

- __What confirmation delay value should I/we use?__

ETC Labs is frequently asked for advice from Exchanges in deciding what confirmation number they should use for Ethereum Classic. __We never provide a number.__ It is not our decision to make: it's a value that directly represents the desired risk profile and risk assessment capabilities of an Exchange. Our job is to make sure the chain and network function as designed, and to do what we can to make sure information about the design and protocol are accessible and actionable. But it cannot (and should not) be our job to tell anyone _how_ to use the chain, only to help users -- both institutional and individuals -- make informed decisions. 

### References

- > It is strictly necessary that the longest chain is always considered the valid one. Nodes that were present may remember that one branch was there first and got replaced by another, but there would be no way for them to convince those who were not present of this. We can't have subfactions of nodes that cling to one branch that they think was first, others that saw another branch first, and others that joined later and never saw what happened. The CPU power proof-of-work vote must have the final say. The only way for everyone to stay on the same page is to believe that the longest chain is always the valid one, no matter what.
  > https://satoshi.nakamotoinstitute.org/emails/cryptography/6/
  


