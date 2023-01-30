// Agent blank in project ia_submission

/* Initial beliefs and rules */
/* Initial goals */

//!start.

/* Plans */

/* +!start : true <- .print("hello world.");
					move(-1,-1).
					*/


//execute this goal as soon as the agent is in the environment
! move_around.

	   
+! move_around : true
	<- .print("Moving to scan");
	   move(-3,-2);
	   rover.ia.log_movement(-3,-2);
	   scan(6);
	   .
	   
+ move_around[source(TD)]: true
	<- - move_around[source(TD)]
	   .print("Moving to scan");
	   move(-3,-2);
	   rover.ia.log_movement(-3,-2);
	   scan(6);
	   .		
				
//move if find nothing
+ resource_not_found : true
	<- ! move_around;
	   .
	   
//move to any resource you find
@ resource_found("Diamond", Qty, Xdist, Ydist)[atomic]
+ resource_found("Diamond", Qty, Xdist, Ydist) : true
	<-  rover.ia.get_map_size(Width, Height);
	   	rover.ia.get_distance_from_base(XFromBase, YFromBase);
	   	.print("I found Diamond, with ", Qty, " dist from base:", -XFromBase+Xdist,",", -YFromBase+Ydist);
	   	ia_submission.short_path(XFromBase, Xdist, YFromBase, Ydist, Width, Height, XMod, YMod);
	   	if (XMod > 18 & YMod < -18){
	   		.send(testDiamond_3, tell, collecting_resource(XMod-Width, YMod+Height));
	   	}elif (XMod < -18 & YMod > 18){
	   		.send(testDiamond_3, tell, collecting_resource(XMod+Width, YMod-Height));
	   	}elif (XMod < -18 & YMod < -18){
	   		.send(testDiamond_3, tell, collecting_resource(Width+XMod, Height+YMod));
	   	}elif (XMod > 18 & YMod > 18){
	   		.send(testDiamond_3, tell, collecting_resource(XMod-Width, YMod-Height));
	   	}else{
	   		.send(testDiamond_3, tell, collecting_resource(XMod, YMod));
	   	}
	    .
					
					
//move to any resource you find
@ resource_found("Gold", Qty, Xdist, Ydist)[atomic]
+ resource_found("Gold", Qty, Xdist, Ydist) : true
	<-  rover.ia.get_map_size(Width, Height);
	   	rover.ia.get_distance_from_base(XFromBase, YFromBase);
	   	.print("I found Gold, with ", Qty, " dist from base:", -XFromBase+Xdist,",", -YFromBase+Ydist);
	   	ia_submission.short_path(XFromBase, Xdist, YFromBase, Ydist, Width, Height, XMod, YMod);
	   	if (XMod > 18 & YMod < -18){
	   		.send(testGold_3, tell, collecting_resource(XMod-Width, YMod+Height));
	   	}elif (XMod < -18 & YMod > 18){
	   		.send(testGold_3, tell, collecting_resource(XMod+Width, YMod-Height));
	   	}elif (XMod < -18 & YMod < -18){
	   		.send(testGold_3, tell, collecting_resource(Width+XMod, Height+YMod));
	   	}elif (XMod > 18 & YMod > 18){
	   		.send(testGold_3, tell, collecting_resource(XMod-Width, YMod-Height));
	   	}else{
	   		.send(testGold_3, tell, collecting_resource(XMod, YMod));
	   	}
	    .
	

//move if obstructed by agent
+ obstructed(XT, YT, X_left, Y_left) : true
	<- .print("obstructed");
	   move(3,3);
	   rover.ia.log_movement(3,3);
	   .

	   
+ obstructed_agentD(X,Y,H)[source(TD)]: true
	<- - obstructed_agentD(X,Y,H)[source(TD)];
	   .print("giving space");
	   move(2,2);
	   rover.ia.log_movement(2,2);
	   if (H == 0){
	   	.print("Diamond go again!");
	   	.send(testDiamond_3, tell, ob_collecting_resource(X, Y));
	   }
	   else{
	   	.print("Diamond back!");
	   	.send(testDiamond_3, tell, ob_return_to_deposit(X, Y));
	   }
	   .

+ obstructed_agentG(X,Y,H)[source(TG)]: true
	<- - obstructed_agentG(X,Y,H)[source(TG)];
	   .print("giving space");
	   move(2,2);
	   rover.ia.log_movement(2,2);
	   if (H == 0){
	   	.print("Gold go again!");
	   	.send(testGold_3, tell, ob_collecting_resource(X, Y));
	   }
	   else{
	   	.print("Gold back!");
	   	.send(testGold_3, tell, ob_return_to_deposit(X, Y));
	   }
	   .
	   

					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					