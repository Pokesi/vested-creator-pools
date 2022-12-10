@echo off
if "%1"=="solana" (
  solang compile --target solana -v -o output contracts/bVCP/solana_bVCP_gas_costs_solution_1.sol
  solang compile --target solana -v -o output contracts/bVCP/solana_bVCP_gas_costs_solution_2.sol
  solang compile --target solana -v -o output contracts/bVCP/solana_bVCP_gas_costs_solution_3.sol
  solang compile --target solana -v -o output contracts/bVCP/solana_bVCP_gas_costs_solution_4.sol

  solang compile --target solana -v -o output contracts/iVCP/solana_iVCP_gas_costs_solution_1.sol
  solang compile --target solana -v -o output contracts/iVCP/solana_iVCP_gas_costs_solution_2.sol
  solang compile --target solana -v -o output contracts/iVCP/solana_iVCP_gas_costs_solution_3.sol
  solang compile --target solana -v -o output contracts/iVCP/solana_iVCP_gas_costs_solution_4.sol

  solang compile --target solana -v -o output contracts/iICVCP/solana_iICVCP_gas_costs_solution_1.sol
  solang compile --target solana -v -o output contracts/iICVCP/solana_iICVCP_gas_costs_solution_2.sol
  solang compile --target solana -v -o output contracts/iICVCP/solana_iICVCP_gas_costs_solution_3.sol
  solang compile --target solana -v -o output contracts/iICVCP/solana_iICVCP_gas_costs_solution_4.sol

)
if "%1"=="evm" (
  npx hardhat compile
)
if "%1"=="all" (
  solang compile --target solana -o output contracts/bVCP/solana_bVCP_gas_costs_solution_1.sol
  solang compile --target solana  -o output contracts/bVCP/solana_bVCP_gas_costs_solution_2.sol
  solang compile --target solana -o output contracts/bVCP/solana_bVCP_gas_costs_solution_3.sol
  solang compile --target solana -o output contracts/bVCP/solana_bVCP_gas_costs_solution_4.sol

  solang compile --target solana -o output contracts/iVCP/solana_iVCP_gas_costs_solution_1.sol
  solang compile --target solana -o output contracts/iVCP/solana_iVCP_gas_costs_solution_2.sol
  solang compile --target solana -o output contracts/iVCP/solana_iVCP_gas_costs_solution_3.sol
  solang compile --target solana -o output contracts/iVCP/solana_iVCP_gas_costs_solution_4.sol

  solang compile --target solana -o output contracts/iICVCP/solana_iICVCP_gas_costs_solution_1.sol
  solang compile --target solana -o output contracts/iICVCP/solana_iICVCP_gas_costs_solution_2.sol
  solang compile --target solana -o output contracts/iICVCP/solana_iICVCP_gas_costs_solution_3.sol
  solang compile --target solana -o output contracts/iICVCP/solana_iICVCP_gas_costs_solution_4.sol
  npx hardhat compile
)
