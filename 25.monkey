% Initial state: monkey at floor, box at floor, banana at ceiling
initial(state(at_floor, at_floor, at_ceiling)).

% Define the allowed actions to change the state
% monkey_grab: monkey grabs banana if it's on the box
% monkey_climb: monkey climbs the box if it's at the floor
% monkey_push: monkey pushes the box if it's at the floor
action(state(at_ceiling, at_floor, at_ceiling), monkey_grab, state(at_ceiling, at_floor, at_ceiling)).
action(state(on_box, at_floor, at_ceiling), monkey_grab, state(on_box, at_floor, at_floor)).
action(state(at_floor, at_floor, at_ceiling), monkey_climb, state(on_box, at_floor, at_ceiling)).
action(state(at_floor, at_floor, at_ceiling), monkey_push, state(at_floor, on_box, at_ceiling)).

% Define the goal state: monkey has the banana
goal(state(_, _, at_floor)).

% Define a predicate to solve the problem
% Path: the list of actions to reach the goal state
solve(State, Path) :-
    goal(State),                  % If the current state is the goal state
    Path = [].                    % Then we have an empty list of actions
solve(State, [Action|Rest]) :-
    action(State, Action, NextState),  % Take an action from the current state
    solve(NextState, Rest).            % Recur with the next state

% Example query:
% ?- initial(InitialState), solve(InitialState, Path).
% Output: Path will be a sequence of actions to reach the goal.
