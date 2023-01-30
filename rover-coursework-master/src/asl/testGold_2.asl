// Agent blank in project ia_submission

/* Initial beliefs and rules */
resources_held(5, 0).
task(0).
/* Initial goals */

//!start.

/* Plans */

/* +!start : true <- .print("hello world.");
					move(-1,-1).
					*/
	   
	
//collecting resources	
@ collecting_resource[atomic]
+ collecting_resource(X, Y)[source(SG)]: true
	<-	?task(N);
		-+task(1);
	    - collecting_resource(X, Y)[source(SG)];
	    .print(scannerGold_2, " found Gold");
	    .print(X,",",Y);
	    move(X, Y);
	    rover.ia.log_movement(X, Y);
	    //move(Xdist, Ydist);
	    //rover.ia.log_movement(X,Y);
		.print("collecting"); 
		?resources_held(Max, Held);
    	for ( .range(I,Held,Max-1)) {
       		collect("Gold");
       		-resources_held(Max, Held+I-1+1);
       		+resources_held(Max, Held+I+1);
     	}
     	! return_to_deposit(X, Y);
		.
	
+! collecting_resource(X, Y): true
	<-	?task(N);
		-+task(1);
	    //.print(scannerGold_2, " found Gold");
	    .print(X,",",Y);
	    move(X, Y);
	    rover.ia.log_movement(X, Y);
	    //move(Xdist, Ydist);
	    //rover.ia.log_movement(X,Y);
		.print("collecting"); 
		?resources_held(Max, Held);
    	for ( .range(I,Held,Max-1)) {
       		collect("Gold");
       		-resources_held(Max, Held+I-1+1);
       		+resources_held(Max, Held+I+1);
     	}
     	! return_to_deposit(X, Y);
		.
	
//move if resources run out of quantity 
+ invalid_action(collect, unmet_requirement) : true
	<- .print("No Gold");
	   ! return_to_base;
	   .print("scannerGold_2 move around!");
	   .
	   

//move if obstructed by agent
+ obstructed(XT, YT, X_left, Y_left) : true
	<- .print("obstructed");
	   move(1,1);
	   ! return_to_base(-XT, -YT);
	   move(-1,-1);
	   .
	   
	
// return to deposit
@return_to_deposit[atomic]
+! return_to_deposit(X, Y) : true
		<-?task(N);
		  .print("I am returning to deposit");
		  rover.ia.get_distance_from_base(XFromBase, YFromBase);
	      move(XFromBase, YFromBase);
	      deposit("Gold");
	      deposit("Gold");
	      deposit("Gold");
	      deposit("Gold");
	      deposit("Gold");
	      -+resources_held(5, 0);
	      rover.ia.clear_movement_log;
	      .print(X,",",Y);
	      move(X, Y);
	      rover.ia.log_movement(X, Y);
		  .print("collecting"); 
		  ?resources_held(Max, Held);
    	  for ( .range(I,Held,Max-1)) {
       		collect("Gold");
       		-resources_held(Max, Held+I-1+1);
       		+resources_held(Max, Held+I+1);
     	  }
	      .print("I am returning to deposit");
		  rover.ia.get_distance_from_base(XFromBase, YFromBase);
	      move(XFromBase, YFromBase);
	      deposit("Gold");
	      deposit("Gold");
	      deposit("Gold");
	      deposit("Gold");
	      deposit("Gold");
	      -+resources_held(5, 0);
	      rover.ia.clear_movement_log;
	      .print("scan again");
	      .send(scannerGold_2,tell,move_around);
	      .
	      
+! back_to_resources(X, Y): true
	<- .print("Going back to resource location");
	   ! collecting_resource(X, Y);
	   .


+! return_to_base: true
		<-.print("return to base bcs of invalid action");
		  rover.ia.get_distance_from_base(XFromBase, YFromBase);
		  move(XFromBase, YFromBase);
		  rover.ia.clear_movement_log;
		  .send(scannerGold_2,tell,move_around);
		  .
	   
	 
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					