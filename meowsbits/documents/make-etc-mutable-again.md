# Make ETC Mutable Again?

On July 31, 2020 and again on August 5, 2020, the Ethereum Classic network saw 2 massive chain reorganizations. In both cases, a single miner privately generated chain segments on the order of 3000 and 4000 blocks, respectively, which were then broadcast to the network. These chain segments were valid by all consensus rules, and were found to have been endowed with greater `total difficulty` than the existing chain sections they replaced. Since total difficulty represents the ultimate and decisive arbitration value in the blockchain's construction, these blocks were preferred by the correctly-functioning nodes. 

Unfortunately, simultaneous to the generation and broadcast of these blocks, this miner behaved fraudulently in external contexts around and relating to the chain, notably in interactions with a few cryptocurrency exchange marketplaces.

The miner exploited this rare, but design-intentional, behavior of the blockchain by swindling gullible marketplace providers who found themselves unprepared and ill-adapted to the potentials of the Proof-of-Work chain. The miner was able to trick them into withdrawals that he or she would later invalidate with the privately-generated chain segment.

Only marketplaces with inadequate risk management policies were affected by the fraud.

Miners on the competing (and ultimately abandoned) chain saw their previously-accounted rewards lost for the span of the reorganized chain sections. Although the scale of this forced re-accounting was rare, smaller magnitudes of the same logic apply in historically normal chain operation with around 5-minute regularity. 

Like the case of the DAO hack and it's subsequent arbitrary and irregular state mutations (ie protocol-based refunds for use-based mistakes) endorsed by the Ethereum Foundation<sup>:registered:</sup>, the case currently considered at Ethereum Classic is _not predicated by any malfunction of the chain or network_. The Ethereum Classic chain has _always_ behaved exactly as designed. The unfortunate outcomes involving the ETC network were the sole result of unprepared or ill-advised chain users caught in vulnerable positions by circumstances their risk-management policies were unequipped for.

At the time of writing, the Ethereum Classic's `ETC` asset has a supply of 116,313,299 ETC, corresponding to a fiat market cap of $835,568,983. The estimated value lost by the affected marketplaces is about 807,000 ETC, equivalent to about $5,600,000, or about 0.7% of the chain's supply.

Comparatively, the DAO hacker diverted 3.6 million Ether (ETH) from a faulty contract relative to a time-of-writing supply of 112,081,212 ETH, placing it at a minimum 3.2% of unadjusted supply (there would have been a lower total supply of ETH in 2016). The value was then worth around $150,000,000, and would now be worth at least 10 times that amount.


## Finality, Finally

This section will briefly explore the policy failures of the marketplace services that exposed themselves to the attacking miner's chain reorganization.

For a Proof-of-Work blockchain, the term _finality_ describes the _probability of permanence_ for a given transaction made on chain. The graph of a PoW chain's finality would look like this this:

![graph](https://user-images.githubusercontent.com/45600330/89654738-bc0ac700-d88e-11ea-85e4-c380552d8574.png)

Just like the complexities of common portfolio management are governed by the risk-tolerance of investors, so is the the value `N` representative of the risk-tolerance of a blockchain user in regard to the permanence ("finality") of their on-chain transactions.

Like portfolio management, risk represents a measure of potential loss relative to potential gain.

In the context of the cryptocurrency exchange marketplaces in context, let's quickly explore what this risk represents in some concrete, though generalized, terms.

First, an Exchange (here capitalized to differentiate from the verb _\[to\] exchange_) is a service provider. They connect buyers and sellers, and facilitate transactions between them. Doing so necessitates the Exchange's own interoperation with the bespoke resources, namely handling deposits and withdrawals in various currencies. For this service, they charge a fee, usually to both the buyer and seller. In the context of these negotiations, the Exchange must assume its desired risk profiles; between the buyer and seller, and between themselves and the resource in question. 

From the graph above, in the context of their relationship with a Proof-of-Work currency, an Exchange must use a value `N` that reflects their desired risk profile with the currency. A smaller value (shorter confirmation times) provide a snappier user experience, and thereby potentially more, and happier customers. A greater value `N`, ie. longer confirmation times, causes customers to wait longer for deposit and withdrawal approvals, but reduces the Exhange's risk of being swindled by vulnerable assumptions of transaction permanence. 

Coinbase, the 2nd largest Exchange by volume, reportedly uses an ETC confirmation value of 40,000. On the other hand, proven by their unfortunately demonstrated vulnerability, the Exchanges victimized in the cases above must have been using values lower than the size of the reorganized chain segments... probably around 3,000, or less. [2] 

Quick Googling (don't cite me here) reports a cumulative cryptocurrency market capitalization of 237.1 billion USD in 2019, and [some random Medium article](https://medium.com/@TokenInsight/2019-cryptocurrency-spot-exchange-industry-annual-report-d022d1c29e3f) reports 13.8 trillion USD in annual cryptocurrency spot Exchange trading volume in January 2020. At an assumed 0.5% exchange fee, this would generate 69 billion USD in revenue annually.

## Immutability FAQ

- __Did the big reorgs break immutability promises of the chain?__

No. Reorganizations are just the practical way that network nodes update their state databases in adherence of the "heaviest chain wins" Proof-of-Work consensus rules. Large reorganizations are indeed rarer than small ones, but conform to exactly the same rules.

- __Did the latest ETC "Phoenix" Fork break immutability?__

No. The fork introduced new opcodes and repriced some gas costs for EVM operations, which modified the behavior of a few existing contracts that relied on hardcoded assumptions of costs. New opcodes were first introduced to the Ethereum chain in March 2016 in the "Homestead" hard fork at block 1,150,000. Ethereum Classic originated with a rejection of the arbitrary state mutation introduced at the "DAO" hard fork at block 1,920,000, in July 2016. If modifying potential EVM operations breaks immutability guarantees, those guarantees have been invalid since before Ethereum Classic was born. [1]

- Ok, so __what is Immutability?__

The Immutability Promise of Ethereum Classic, and it's _raison d'etre_, means that if the database and network behave as designed (ie. no bugs, of which there have been none meeting this classification), it can be expected that chain state will be an untampered-with product of the protocol design. This is why the addage "Code is Law" is quickly and frequently associated with the idea, where "Code" refers first to the protocol specification (ie. the Yellow Paper), and by association and the _double entendre_ to its materialization as software.

As such, a 51% attack is not external to chain or network design, nor does it encroach on the Immutability Promise. Further, the concept and implication of "attack" is only relevant _outside_ of the domain of the database and network, and is only engendered with that negative connotation in the wake of failed risk-management policies and utilization strategies of chain and network users.


---

[1]: Contracts relying on hardcoded gas prices or non-existing opcodes have been brittle to these types anticipated protocol modifications since the Homestead fork, and presumably before it.

[2]: And hearsay reports that some implicated exchanges were using 30.



