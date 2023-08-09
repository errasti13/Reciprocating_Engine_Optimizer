# 4-Stroke Engine Optimization

This repository contains MATLAB code for optimizing parameters related to a 4-stroke engine using various optimization techniques. The optimization aims to find optimal values for parameters that impact the engine's performance. The code includes implementations of gradient-based optimization (fmincon), genetic algorithms (ga), and derivative-free optimization (fminsearch).

## Table of Contents

- [Description](#description)
- [Optimization Methods](#optimization-methods)
- [Model Overview](#model-overview)
- [Usage](#usage)
- [License](#license)

## Description

This MATLAB code performs optimization on parameters related to a 4-stroke engine using different optimization techniques. It includes the following components:

- `main.m`: The main script that orchestrates the optimization process using different techniques.
- `F.m`: The objective function that calculates the fitness of the engine parameters.
- `constraints.m`: The function defining any constraints for the optimization problem.
- `Engine_Model/`: A subdirectory containing the engine model used in the optimization process.

## Model Overview

The thermodynamic cycle followed by the engine consists of 4 strokes: during the first revolution of the crankshaft, intake and compression of gases occur, and during the second revolution, combustion and exhaust take place. To model this cycle, the following assumptions are made:

- Ideal gases are assumed during intake and exhaust.
- Combustion is adiabatic, and viscous effects are neglected.
- Chemical reactions occur under equilibrium conditions.
- Heat input is carried out at constant volume.
- The combustion chamber is divided into two zones: reactants and products.

In order to achieve a higher cycle efficiency, the delay in the closure of intake (RCA), the advancement of exhaust valve opening (AAE), and the advancement of combustion initiation (AICB) are considered as variables. The first variable corresponds to the angle covered by the crankshaft from the piston's TDC (Top Dead Center) to the closure of the intake valve. The improvement in cycle behavior caused by this delay is due to the delayed transmission of information among gas particles, allowing the intake process to continue during the beginning of the compression stage. Similarly, the opening of the exhaust valve can be advanced, starting the exhaust stage before the piston reaches TDC, in the case of AAE. Finally, AICB can be adjusted to improve combustion while controlling the risk of mixture detonation.

These considerations form the basis of the model used for the optimization of engine parameters in this repository.


## Optimization Methods

The code employs three distinct optimization methods to find optimal engine parameters:

1. **Gradient-Based Optimization (fmincon):**
   Gradient-based optimization relies on the derivative (gradient) of the objective function to search for optimal solutions. The `fmincon` function is used for this method, which minimizes the objective function while adhering to inequality and equality constraints. This approach is effective for problems with smooth and well-behaved objective functions.

2. **Genetic Algorithms (ga):**
   Genetic algorithms are heuristic optimization techniques inspired by natural selection. The code uses the `ga` function to perform genetic algorithm optimization. It creates a population of potential solutions and evolves them through selection, crossover, and mutation operations. Genetic algorithms excel in handling problems with complex search spaces and non-differentiable objective functions.

3. **Derivative-Free Optimization (fminsearch):**
   Derivative-free optimization methods do not require the derivative of the objective function. The `fminsearch` function is utilized for this method, employing a pattern search algorithm. It explores the parameter space to find the minimum of the objective function. Derivative-free methods are suitable when the objective function is non-smooth or derivative information is unavailable.

Each optimization method has its advantages and limitations, and their suitability depends on the problem's characteristics. Gradient-based methods are efficient with derivative information, genetic algorithms excel in complex search spaces, and derivative-free methods are robust for non-smooth functions.


## Usage

1. Clone the repository to your local machine using `git clone`.

2. Open MATLAB and navigate to the `main` directory.

3. Run the `main.m` script in MATLAB.

4. The optimization results using different techniques will be displayed.

5. User may choose the optimization method to use by just running the different sections in the code.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

