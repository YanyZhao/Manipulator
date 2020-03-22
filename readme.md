This zip files contains all the necessary functions for SRRT planner of Lynx robot. 
 - Main functions:
   -  Simulation function: runsim.m
   -  Generative function for static planning(main function): SRRT.m
   -  Generative function for dynamic planning: regrow.m
 
- Other functions:
   -  Sample function: sample.m
   -  Pick random node in space: RandomNode.m
   -  Neighbor finding function: neighbor.m
   -  Node extending function: extend.m
   -  Collision detection function: DetCol.m
   -  Path optimization function: path_opt.m
- Utils:
Those are helper functions either from p-code or m-code that I implemented in the former labs

6 maps are included, however, only 4 of them are typical and reported in the results.

- simulation results:

  - comparison between random sample and epsilon-greedy sample:
    ![](img/random.gif)
    ![](img/epsilon_greedy.gif)

  - comparison between raw and pruned path:
    ![](img/before_prun.gif)
    ![](img/after_prun.gif)
