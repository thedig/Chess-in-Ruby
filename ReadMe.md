# Chess CLI

Command line based Chess game written in Ruby.

## Chess Pieces

Each type of chess piece is categorized as either a sliding piece, stepping piece or a pawn (special rules). Subclasses within these categories map to the standard rook, bishop, queen, knight and king. Pawn is given separate set of rules due to special movements (can move two spots on first move, and only forward).

Game successfully verifies if player is in check, if chekc mate has occurred and prevents player from moving into check.


## UI / Colorize

Text based command line UI that runs in the terminal, taking move inputs from user.  Uses Colorize gem and Unicode chess characters to make a more user friendly / visual experience.

## Additional features to come

- _Ability to Castle_
- _Tracking of move history_
- _Ability to move pieces with keyboard directional instead of input letter/number combos_
