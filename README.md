# The Future of Royalties, the Creator Pool.
### A concept written by z.ftm for the Magic Eden Creator Monetization Hackathon

Code written in Solidity can be used on Solana using Solang, through the `solang.exe` file provided ([hyperledger/solang](https://github.com/hyperledger/solang)). Linux/MacOS binaries can be found [here](https://solang.readthedocs.io/en/latest/installing.html). Please note none of the code has been audited!

## An introduction
This is ripped from the whitepaper.<br>

A Creator Pool is a royalties model which works more as a pay check, rather than a constant stream of income. The basic idea behind this model is that royalties do not go directly to the creator, instead, royalties are sent to a pool. This pool gets emptied out in intervals, and every NFT collection’s creator is paid out in proportion to what they contributed.  

## Submission
#### A description of what your project does and why you decided to build it
The VCP model is a revamped royalty payout method that allows both the NFT marketplace and the NFT creators to capitulate on the billions flowing through royalties every year. I decided to build it for this exact reason.

#### Demo video or presentation slides. Your video should be under 1 minute and include a demo of your working project. (Videos must be made publicly visible).
Presentation can be found at `Presentation.{pdf|ppsx}`
Whitepaper can be found at `The Future Of Royalties.pdf`

## bVCP
A bVCP is the pool referred to above. A creator's payout is defined by the equation:
```
c = P
```
Where `c` is the amount a creator contributes to the pool, and `P` is their payout amount.

## iVCP
An iVCP is a bVCP where the funds from royalties can be invested, and contribute to payouts. This is defined by the equation:
```
ct/d = P
```
Where `t` is the total funds in the pool, and `d` is the total amount deposited by all creators.

## iICVCP
An iICVCP is an iVCP where a creator's share in a pool is capped. This is defined by the equation:
```
0.05t∙[d^(-c)≥0.05] + d^(-ct)∙[d^(-c)<0.05] = P
```
Where a creator's share is capped to 5% (0.05 in decimal form).

## Adapting to Solana's restrictions
A big part of the way this would work on an EVM chain is using `payable` functions, where native value can be sent on a contract call. On Solana, this is not possible, though it is using SPL tokens. I preferred to use native SOL, though this can be changed with minimal changes to the code. My workaround for this was to have the marketplace contract send the SOL before calling the `deposit()` function. The `deposit()` function is permissioned, and increases the payout amount for each creator without checking if the funds have been sent. This requires the function to be permissioned.

## Reading the code
The code (as previously mentioned) is written in Solidity, so if you have previous experience in JavaScript/C/Java/Rust you will have an easy time understanding it. There are comments placed throughout the files such as headings and comments explaining what each line does. To find the model and gas cost solution you want, go into `/contracts/{model}/{model}_gas_costs_solution_{solution}`, with `solana_` in front of the file name to find the Solana program.

## Viewing the frontend
The frontend is very mediocre and simulates what the creators would see when claiming/viewing their royalty payouts. All 4 gas cost solutions are incorporated.<br>
It is React app using Vite, so to run it you can use:
```sh
cd frontend
npm install # only if not already installed
npx vite --port 3000
```

The frontend should now be live at `https://localhost:3000/`

You can see it [here](https://vested-creator-pools.vercel.app/)

## Using the `compile_all` utility
`compile_all` is a utility to compile all the contracts in `/contracts`, for ease of use. It takes a single argument, the target chain, one of the following:

- `solana`
- `evm`
- `all`

It may need to be edited for use in non-windows systems.

#### More on the different types of pools can be found in the whitepaper.
