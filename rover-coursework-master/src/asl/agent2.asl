// Agent blank in project ia_submission

/* Initial beliefs and rules */
resources_held(3, 0).
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
	   move(-2,3);
	   rover.ia.log_movement(-2,3);
	   scan(3);
	   .
				
				
//move if find nothing
+ resource_not_found : true
	<- ! move_around;
	   .
					
					
//move to any resource you find
+ resource_found(ArtefactType, Qty, Xdist, Ydist) : true
	<- .print("I am moving to a ", ArtefactType, " location");
	   move(Xdist, Ydist);
	   rover.ia.log_movement(Xdist, Ydist);
	   ! collecting_resource(ArtefactType);
	   //collect("Gold");
	   //collect("Gold");
	   //collect("Gold");
	   ! return_to_deposit(ArtefactType);
	   .
	
+! collecting_resource(ArtType) : true
	<- .print("collecting"); 
	?resources_held(Max, Held);
    for ( .range(I,Held,Max-1) ) {
       collect(ArtType);
       -resources_held(_, _);
       +resources_held(Max, Held+I);
    }
	.
	
//move if resources run out of quantity  
+ invalid_action(collect, unmet_requirement) : true
	<- ?resources_held(Max, Held);
	   .print(Held);
	   if (Held == 1){
	   .print("Max. capacity");
	   ! return_to_deposit;
	   }
	   else{
	   .print("qty not enough");
	   ! move_around;
	   }
	   .

//move if obstructed by agent
+ obstructed(XT, YT, X_left, Y_left) : true
	<-.print("obstructed");
	   ! move_around;
	   .
	
	   // todo: return to base
+! return_to_deposit(ArtType) : true
		<-.print("I am returning to deposit");
		  rover.ia.get_distance_from_base(XFromBase, YFromBase);
	      move(XFromBase, YFromBase);
	      deposit(ArtType);
	      deposit(ArtType);
	      deposit(ArtType);
	      -resources_held(_, _);
	      +resources_held(3, 0);
	      rover.ia.clear_movement_log;
	      ! back_to_resource(ArtType, -XFromBase, -YFromBase);
	      .
	   
	   //go back to collect other resources
+! back_to_resource(ArtType, X, Y) : true
	   <- .print("I am going back to the resources");
	      move(X, Y);
	      rover.ia.log_movement(X, Y);
	      ! collecting_resource(ArtType);
	      //collect("Gold");
	      //collect("Gold");
	      //collect("Gold");
	      ! return_to_deposit(ArtType);
	      .
	   //rover.ia.clear_movement_log;
	   //! move_around
       //.
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					