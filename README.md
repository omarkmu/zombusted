# zombusted

**zombusted** is a set of Lua scripts that help mock the PZ environment for testing with `busted`.
It also provides utilities for changing the state of the environment.

The mocking is currently very incomplete;
ultimately, it will be replaced with mocks generated using [`Umbrella`](github.com/PZ-Umbrella/Umbrella).

## Installation

To install, run `luarocks --local make zombusted-scm-0.rockspec` in the top-level directory.
