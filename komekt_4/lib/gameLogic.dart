class gameLogic{
     int player = -1;

    // Constructor
    Connect4() {
      List.generate(7, (i) => (List.generate(6, ((index) => 0), growable: false)));
    }

    deepCopy(List<List<int>> org) {

        if (org == null) {
            return null;
        }

        final List<List<int>> res =
         List.generate(7, (i) => org[i]);
        return res;
    }


   List<List<int>> makeMove(int x, int movingPlayer, List<List<int>> state) {
      List<List<int>> newState = deepCopy(state);
        if (getValidMoves(state).contains(x)) {
            for (int i = 0; i < 4; i++) {
                if (newState[x][i] == 0){
                    newState[x][i] = movingPlayer;
                    break;
                }
            }
            return newState;
        } else {
            return deepCopy(state);
        }


    }
   List<int> getValidMoves(List<List<int>> state) {
        List<int> moves = [];
        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 4; j++) {
                if (state[i][j] == 0) {
                    moves.add(i);
                    break;
                }
            }
        }
        return moves;
    }

    int winner(List<List<int>> state) {
        for (int i = 0; i < 5; i++) {
            for (int j = 0; j < 4; j++) {
                if (state[i][j] == 0) {
                    continue;
                }
                if (i<2){
                    if (state[i][j] == state[i+1][j] &&
                            state[i][j] == state[i+2][j] &&
                            state[i][j] == state[i+3][j]){
                        return state[i][j];
                    }
                }
                if (i<2 && j<1) {
                    if (state[i][j] == state[i+1][j+1] &&
                            state[i][j] == state[i+2][j+2] &&
                            state[i][j] == state[i+3][j+3]){
                        return state[i][j];
                    }
                }
                if (i<2 && j>2) {
                    if (state[i][j] == state[i+1][j-1] &&
                            state[i][j] == state[i+2][j-2] &&
                            state[i][j] == state[i+3][j-3]){
                        return state[i][j];
                    }
                }
                if (j<1){
                    if (state[i][j] == state[i][j+1] &&
                            state[i][j] == state[i][j+2] &&
                            state[i][j] == state[i][j+3]){
                        return state[i][j];
                    }
                }
            }
        }
        if (getValidMoves(state).isEmpty) {
            return 0;
        }
        return 0;
    }
}

