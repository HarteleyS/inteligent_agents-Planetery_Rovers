// Agent blank in project ia_submission

/* Initial beliefs and rules */
/* Initial goals */
moving_to(1).
returned(0).
//!start.

/* Plans */

/* +!start : true <- .print("hello world.");
					move(-1,-1).
					*/


//execute this goal as soon as the agent is in the environment
! move_up_left.

+! move_up_left : true
	<- .print("Moving up left");
	   move(-3,-2);
	   rover.ia.log_movement(-3,-2);
	   scan(6);
	   ?moving_to(D);
	   -+moving_to(1);
	   .

+! move_up_right : true
	<- .print("Moving up right");
	   move(3,-2);
	   rover.ia.log_movement(3,-2);
	   scan(6);
	   ?moving_to(D);
	   -+moving_to(2);
	   .

+! move_bot_left : true
	<- .print("Moving bot left");
	   move(2,3);
	   rover.ia.log_movement(2,3);
	   scan(6);
	   ?moving_to(D);
	   -+moving_to(3);
	   .
	   
+! move_bot_right : true
	<- .print("Moving bot right");
	   move(-2,3);
	   rover.ia.log_movement(-2,3);
	   scan(6);
	   ?moving_to(D);
	   -+moving_to(4);
	   .
	   
+ move_around[source(TD)]: true
	<- - move_around[source(TD)]
	   .print("told to move");
	   move(-2,-2);
	   rover.ia.log_movement(-2,-2);
	   scan(6);
	   ?moving_to(D);
	   -+moving_to(1);
	   .		
				
//move if find nothing
+ resource_not_found[source(DG)] : true
	<- 	?moving_to(D)
		if(D == 1){
			! move_up_left;
		}elif(D == 2){
			! move_up_right;
		}elif(D == 3){
			! move_bot_left;
		}elif(D == 4){
			! move_bot_right;
		}
		- resource_not_found[source(DG)];
	   	.
	   
+! go_another_way: true
 	<- ?returned(X);
 		if(X == 1){
			! move_up_right;
		}elif(X == 2){
			! move_bot_left;
		}elif(X > 2){
			! move_bot_right;
		}
	   .
	   
	   
//move to any resource you find
//@ resource_found("Diamond", Qty, Xdist, Ydist)[atomic]
+ resource_found("Diamond", Qty, Xdist, Ydist) : true
	<-  //move(Xdist, Ydist);
		//rover.ia.log_movement(Xdist, Ydist);
		rover.ia.get_distance_from_base(XFromBase, YFromBase);
	    .print("found ",Qty, " Diamond");
		.send(testDiamond_4, tell, collecting_resource(-XFromBase+Xdist, -YFromBase+Ydist));
		.
					
					
//move to any resource you find
//@ resource_found("Gold", Qty, Xdist, Ydist)[atomic]
+ resource_found("Gold", Qty, Xdist, Ydist) : true
	<-  //move(Xdist, Ydist);
	    //rover.ia.log_movement(Xdist, Ydist);
	    rover.ia.get_distance_from_base(XFromBase, YFromBase);
		.print("found ",Qty, " Gold");
		.send(testGold_4, tell, collecting_resource(-XFromBase+Xdist, -YFromBase+Ydist));
	    .

//@ resource_found("Obstacle", Qty, Xdist, Ydist)[atomic]
+ resource_found("Obstacle", Qty, Xdist, Ydist) : true
	<- 	! go_another_way;
		//- resource_found("Obstacle", Qty, Xdist, Ydist)[source(percept)];
	   	. 




//move if obstructed by agent
//@ obstructed(XT, YT, X_left, Y_left)[atomic]
+ obstructed(XT, YT, X_left, Y_left) : true
	<- 	.print("obstructed");
		! return_to_base(XT, YT);
		? returned(X);
		-+ returned(X+1);
		! go_another_way;
		.




// agents obstructed for both.   
+ obstructed_agentD(X,Y,H)[source(TD)]: true
	<- - obstructed_agentD(X,Y,H)[source(TD)];
	   .print("giving space");
	   move(2,2);
	   rover.ia.log_movement(2,2);
	   if (H == 0){
	   	.print("Diamond go again!");
	   	//.send(testDiamond_4, tell, ob_collecting_resource(X, Y));
	   }
	   else{
	   	.print("Diamond back!");
	   	//.send(testDiamond_4, tell, ob_return_to_deposit(X, Y));
	   }
	   .

+ obstructed_agentG(X,Y,H)[source(TG)]: true
	<- - obstructed_agentG(X,Y,H)[source(TG)];
	   .print("giving space");
	   move(2,2);
	   rover.ia.log_movement(2,2);
	   if (H == 0){
	   	.print("Gold go again!");
	   	//.send(testGold_4, tell, ob_collecting_resource(X, Y));
	   }
	   else{
	   	.print("Gold back!");
	   	//.send(testGold_4, tell, ob_return_to_deposit(X, Y));
	   }
	   .
	   

					
					
+! return_to_base(X, Y): true
		<-.print("return to base bcs of invalid action");
		  //rover.ia.get_distance_from_base(XFromBase, YFromBase);
		  .print(X, Y);
		  move(-X, -Y);
		  rover.ia.clear_movement_log;
		  .			
					
					
					
					
					
					
					
					
					
					
					
					
					
					