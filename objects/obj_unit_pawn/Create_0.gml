event_inherited();

//Pawn can move in-line but can only hit diagonally
special = [	new VectorSpecialMove(1, 0, 1),
			new VectorSpecialMove(-1, 0, 1),
			new VectorSpecialMove(0, 1, 1),
			new VectorSpecialMove(0, -1, 1),
			
			new VectorSpecialMove(1, -1, 2),
			new VectorSpecialMove(1, 1, 2),
			new VectorSpecialMove(-1, 1, 2),
			new VectorSpecialMove(-1, -1, 2)]