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
	   move(2,-3);
	   rover.ia.log_movement(2,-3);
	   scan(6);
	   .
	   
+ move_around[source(TG)]: true
	<- - move_around[source(TG)]
	   .print("Moving to scan");
	   move(2,-3);
	   rover.ia.log_movement(2,-3);
	   scan(6);
	   .		
				
//move if find nothing
+ resource_not_found : true
	<- ! move_around;
	   .
	   
					
					
//move to any resource you find
@ resource_found[atomic]
+ resource_found(ArtefactType, Qty, Xdist, Ydist) : true
	<- rover.ia.get_map_size(Width, Height);
	   rover.ia.get_distance_from_base(XFromBase, YFromBase);
	   .print("I found Gold, with ", Qty, " dist from base:", -XFromBase+Xdist,",", -YFromBase+Ydist);
	   ia_submission.short_path(XFromBase, Xdist, YFromBase, Ydist, Width, Height, XMod, YMod);
	   if (XMod > 15 & YMod < -15){
	   	.send(testGold_2, tell, collecting_resource(XMod-Width, YMod+Height));
	   }elif (XMod < -15 & YMod > 15){
	   	.send(testGold_2, tell, collecting_resource(XMod+Width, YMod-Height));
	   }elif (XMod < -15 & YMod < -15){
	   	.send(testGold_2, tell, collecting_resource(Width+XMod, Height+YMod));
	   }elif (XMod > 15 & YMod > 15){
	   	.send(testGold_2, tell, collecting_resource(XMod-Width, YMod-Height));
	   }else{
	   	.send(testGold_2, tell, collecting_resource(XMod, YMod));
	   }
	   .
	

//move if obstructed by agent
+ obstructed(XT, YT, X_left, Y_left) : true
	<- .print("obstructed");
	   .

	   
+ obstruct_move: true
	<- move(1,1);
	   rover.ia.log_movement(1,1);
	   .

	   

					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					