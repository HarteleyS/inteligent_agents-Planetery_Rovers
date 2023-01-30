// Internal action code for project ia_submission

package ia_submission;

import jason.*;
import jason.asSemantics.*;
import jason.asSyntax.*;

public class short_path extends DefaultInternalAction {

    @Override
    public Object execute(TransitionSystem ts, Unifier un, Term[] args) throws Exception {
       
    	// xbase, xdist, ybase, ydist, width, height, xout, yout\
    	int xBase = (int) ((NumberTerm) args[0]).solve();
    	int x = (int) ((NumberTerm) args[1]).solve();
    	int yBase = (int) ((NumberTerm) args[2]).solve();
    	int y = (int) ((NumberTerm) args[3]).solve();
    	int w = (int) ((NumberTerm) args[4]).solve();
    	int h = (int) ((NumberTerm) args[5]).solve();
    	
    	
    	int xout = (-xBase+x)%w;
    	int yout = (-yBase+y)%h;
        return un.unifies(new NumberTermImpl(xout), args[6])  && un.unifies(new NumberTermImpl(yout), args[7]);
    }
}
