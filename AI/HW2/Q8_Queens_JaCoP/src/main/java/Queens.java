/*
Problem : N-Queens
Programming Language : Java - JaCoP

Description : Place n queens on a chessboard of size nxn
              so none queen checks another queen
              This program uses only primitive (basic) constraints
              Example of queen placement in 4x4 chessboard
              - - Q -
              Q - - -
              - - - Q
              - Q - -
-------------------------------------------------------------------------------
Input Format : an integer number N

Output Format : the permutation of queens
                * e.g. for 4-Queens :
                    ****** Solution Found ******
                    - - Q -
                    Q - - -
                    - - - Q
                    - Q - -
                    ****** Solution Found ******
-------------------------------------------------------------------------------
? How to run it :
~$ cd Q8_Queens_JaCoP
~$ mvn compile
~$ mvn exec:java -Dexec.mainClass=Queens
-------------------------------------------------------------------------------
Author   : Maryam Saeedmehr
Std. NO. : 9629373

Enjoy it :)
 */

import org.jacop.constraints.*;
import org.jacop.core.*;
import org.jacop.search.*;

import java.util.Scanner;

public class Queens {
    /* It specifies the size of chessboard to be used in the model */
    public int n;

    // Define FD(Finite Domain) Store --------------------------------
    /*
     JaCoP support both finite domain variables (integer variables)
     and set variables.Both variables and constraints are stored in
     the store (Store).The store has to be created before variables
     and constraints.
    */
    Store store = new Store();

    public Queens(int numberQueens) {
        n = numberQueens;
    }

    public void model() {
        // Define needed Variables and their Domains -----------------
        /*
         I-th queen variable represents the placement
         of a queen in i-th column
         There are n columns so there are n variables
        */
        IntVar[] queens = new IntVar[n];
        IntVar[] diagonalUp = new IntVar[queens.length];
        IntVar[] diagonalDown = new IntVar[queens.length];

        /*
         Each queen variable has a domain from 1 to n
         Value of queen variable represents the row
        */
        for (int i = 0; i < n; i++) {
            // Variable queens[i] = Qi :: 1..n
            queens[i] = new IntVar(store, "Q" + (i + 1), 1, n);
        }

        diagonalUp[0] = queens[0]; // diagonal like this /
        diagonalDown[0] = queens[0]; // diagonal like this \

        // Define Constraints ----------------------------------------
        /* Row Constraint */
        store.impose(new Alldiff(queens));

        for (int i = 1; i < queens.length; i++) {
            /*
             Position of every queen is shifted based on a distance
             to column 1, If any queen can check another on diagonal
             then the position after shifting will be equal to the
             position of the checked queen. Therefore the diagonal list
             is used in Alldifferent constraint
            */
            diagonalUp[i] = new IntVar(store, -2 * n, 2 * n);
            store.impose(new XplusCeqZ(queens[i], i, diagonalUp[i]));

            diagonalDown[i] = new IntVar(store, -2 * n, 2 * n);
            store.impose(new XplusCeqZ(queens[i], -i, diagonalDown[i]));
        }
        /*
        Imposes constraints so queens can not check each other
        using diagonals.
         */
        store.impose(new Alldiff(diagonalUp));
        store.impose(new Alldiff(diagonalDown));

        // search for a solution and print results -------------------
        Search<IntVar> search = new DepthFirstSearch<>();
        SelectChoicePoint<IntVar> select;
        select = new InputOrderSelect<>(
                store,
                queens,
                new IndomainMin<>()
        );
        boolean result = search.labeling(store, select);
        if (result) {
            System.out.println("****** Solution Found ******");
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    if (Integer.parseInt(queens[j].toString().substring(queens[j].toString().lastIndexOf("= ") + 1).trim()) == i + 1)
                        System.out.print("Q ");
                    else
                        System.out.print("- ");
                }
                System.out.println();
            }
            System.out.println("****** Solution Found ******");
        } else
            System.out.println("**** Solution Not Found ****");
    }

    public static void main(String[] args) {
        // input : n -------------------------------------------------
        Scanner sc = new Scanner(System.in);
        System.out.print("Enter the number of Queens: ");
        while (!sc.hasNextInt()) {
            System.out.println("Oops! You have to enter a number...");
            sc.next();
        }

        // Making a model of the CSP ---------------------------------
        Queens example = new Queens(sc.nextInt());
        example.model();
    }
}
