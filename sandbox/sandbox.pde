// Number of columns and rows in our system
int cols = 200; //nb of colones
int rows = 200;
int sizeCell = 4; //size of scare 
int[][] grid;
ArrayList<Move> moves = new ArrayList<Move>(); //list de tous les mouvements a executer chque tour 

int _air = 0;
int _sand = 1;
int _water = 2;
int _stone = 3;
int _salte = 4;

int mouseType = _sand;

void settings() {
    size(cols * sizeCell, rows * sizeCell);
}

void setup() {
    grid = new int[cols][rows];
    moves = new ArrayList<Move>();
    for (int j = 0; j < rows; j++) {
        for (int i = 0; i < cols; i++) {
            grid[i][j] = _air;
        }
    }
    noStroke();
    frameRate(100);
}

void draw() {

    //pour ajouter du sable
    if (mousePressed) {
        if (V(mouseX / sizeCell, mouseY / sizeCell)) {
            int x = mouseX / sizeCell;
            int y = mouseY / sizeCell;
            int type = mouseType;
            AddCell(x,y,type);
            AddCell(x+1,y,type);
            AddCell(x+2,y,type);
            AddCell(x,y+1,type);
            AddCell(x+1,y+1,type);
            AddCell(x+2,y+1,type);
            AddCell(x,y+2,type);
            AddCell(x+1,y+2,type);
            AddCell(x+2,y+2,type);
        }
    }

    moves.clear(); //reset les mouvements 

    //update, chek, push changes
    for (int j = rows - 1; j >= 0; j--) {
        for (int i = 0; i < cols; i++) {
            int type = grid[i][j];

            if(type == _sand ){Sand(i, j);}
            if(type == _salte ){Salte(i, j);}
            if(type == _water ){Water(i, j);}


        }
    }

    //execute all moves (in random order to avoid paterne)
    while (moves.size() > 0) {
        int i = int(random(0,moves.size()));
        moves.get(i).ChekAndMove();
        moves.remove(i);
    }


    //draw
    for (int j = rows - 1; j >= 0; j--) {
        for (int i = 0; i < cols; i++) {
            fill(ColType(grid[i][j]));
            rect(i * sizeCell, j * sizeCell, sizeCell, sizeCell);
        }
    }
}

void Salte(int x, int y){
    boolean b = CheckMove(x, y + 1, _air);
    boolean bWater = CheckMove(x, y + 1, _water);
    boolean aroundAround = CheckMove(x, y + 1, _water) || CheckMove(x, y - 1, _water) ||  CheckMove(x+1, y, _water) ||  CheckMove(x-1, y, _water);
    boolean bl = CheckMove(x - 1, y + 1, _air);
    boolean br = CheckMove(x + 1, y + 1, _air);


       
    if(aroundAround && random(0,1) < 0.01){
        AddMove(x, y, x, y, _salte, _salte, _air);
    }else if (b) {
        AddMove(x, y, x, y + 1, _salte, _air, _air);
    } else if (bWater) {
        AddMove(x, y, x, y + 1, _salte, _water, _water);
    } else if (bl && br) {
        if (ran(2)) {
            AddMove(x, y, x - 1, y + 1, _salte, _air, _air);
        } else {
            AddMove(x, y, x + 1, y + 1, _salte, _air, _air);
        }
    } else if (bl) {
        AddMove(x, y, x - 1, y + 1, _salte, _air, _air);
    } else if (br) {
        AddMove(x, y, x + 1, y + 1, _salte, _air, _air);
    }
}

void Sand(int x, int y) {

    boolean b = CheckMove(x, y + 1, _air);
    boolean bWater = CheckMove(x, y + 1, _water);

    boolean bl = CheckMove(x - 1, y + 1, _air);
    boolean br = CheckMove(x + 1, y + 1, _air);

    if (b) {
        AddMove(x, y, x, y + 1, _sand, _air, _air);
    } else if (bWater) {
        AddMove(x, y, x, y + 1, _sand, _water, _water);
    } else if (bl && br) {
        if (ran(2)) {
            AddMove(x, y, x - 1, y + 1, _sand, _air, _air);
        } else {
            AddMove(x, y, x + 1, y + 1, _sand, _air, _air);
        }
    } else if (bl) {
        AddMove(x, y, x - 1, y + 1, _sand, _air, _air);
    } else if (br) {
        AddMove(x, y, x + 1, y + 1, _sand, _air, _air);
    }
}

void Water(int x, int y){
    boolean b = CheckMove(x, y + 1, _air);
    boolean salteAround = CheckMove(x, y + 1, _salte) || CheckMove(x, y - 1, _salte) ||  CheckMove(x+1, y, _salte) ||  CheckMove(x-1, y, _salte);
    boolean bl = CheckMove(x - 1, y + 1, _air);
    boolean br = CheckMove(x + 1, y + 1, _air);
    boolean r = CheckMove(x + 1, y, _air);
    boolean l = CheckMove(x - 1, y, _air);
    boolean rr = CheckMove(x + 2, y, _air);
    boolean ll = CheckMove(x - 2, y, _air);

    /*if(salteAround && random(0,1) < 0.02){
        AddMove(x, y, x, y + 1, _water, _salte, _water);
    }else*/ if (b) {AddMove(x, y, x, y + 1, _water, _air, _air);} 
    else if (bl && br) {
        if (ran(2)) { AddMove(x, y, x - 1, y + 1, _water, _air, _air);} 
        else { AddMove(x, y, x + 1, y + 1, _water, _air, _air);}
    } 
    else if (bl) {AddMove(x, y, x - 1, y + 1, _water, _air, _air);} 
    else if (br) {AddMove(x, y, x + 1, y + 1, _water, _air, _air);}
    else if (!l && r) {AddMove(x, y, x + 1, y, _water, _air, _air);} 
    else if (!r && l) {AddMove(x, y, x - 1, y, _water, _air, _air);} 
    else if (!ll && l && r && rr) {AddMove(x, y, x + 1, y, _water, _air, _air);} 
    else if (!rr && r && l && ll) {AddMove(x, y, x - 1, y, _water, _air, _air);} 
}


class Move {
    int Fx, Fy; //co de la cell actu
    int Tox, Toy; //co de la cell après 
    int Fcell; //type de la cell 
    int ToCell; //type de la cell qu'elle va remplacer 
    int TypeLeave; //type de la cell qu'elle va laisser après le mov

    Move(int FX, int FY, int TOX, int TOY, int FCELL, int TOCELL, int TYPELEAVE) {
        Fx = FX;
        Fy = FY;
        Tox = TOX;
        Toy = TOY;
        Fcell = FCELL;
        ToCell = TOCELL;
        TypeLeave = TYPELEAVE;
    }

    void ChekAndMove() {

        if (grid[Fx][Fy] == Fcell && grid[Tox][Toy] == ToCell) {
            grid[Tox][Toy] = Fcell;
            grid[Fx][Fy] = TypeLeave;
        }
    }

}

void AddMove(int x, int y, int tx, int ty, int type, int type2, int leaveCell) {
    moves.add(new Move(x, y, tx, ty, type, type2, leaveCell));
    //move = (Move[]) append(move, new Move(x, y, tx, ty, type, type2, leaveCell));
}

void AddCell(int x, int y, int type){
    if (V(x,y)) {
        grid[x][y] = type;
    }
}

void keyPressed() {
    if(key == 'a'){mouseType = _air;}
    if(key == 's'){mouseType = _sand;}
    if(key == 'w'){mouseType = _water;}
    if(key == 't'){mouseType = _stone;}
    if(key == 'l'){mouseType = _salte;}
    /*if (keyCode == CONTROL) {
        if (mouseType == _sand) {
            mouseType = _water;
        }else{
            mouseType = _sand;
        }
    }*/
}

boolean ran(int r){
    return random(0,1) < 1/r;
}


boolean CheckMove(int x, int y, int type) {
    if (V(x, y)) {
        return grid[x][y] == type;
    }
    return false;
}


boolean V(int x, int y) {
    //to now if the x y case is in grid and avoid ArrayIndexOutOfBoundsException
    return x >= 0 && x < cols && y >= 0 && y < rows;
}


color ColType(int type) {
    if(type == _air){return color(50);}
    if(type == _sand){return color(220, 150, 30);}
    if(type == _water){return color(50, 50, 200);}
    if(type == _stone){return color(100, 100, 100);}
    if(type == _salte){return color(220, 220, 220);}
    return color(255);
}
