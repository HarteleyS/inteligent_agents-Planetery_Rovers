// Agent blank in project ia_submission

/* Initial beliefs and rules */
resources_held(3, 0).
e_movement(0,0).
/* Initial goals */

//!start.

/* Plans */

/* +!start : true <- .print("hello world.");
					move(-1,-1).
					*/
	   
	
//collecting resources	
@ collecting_resource(X,Y)[atomic]
+ collecting_resource(X, Y)[source(SS)]: true
	<-	- collecting_resource(X, Y)[source(SS)];
	    .print(scanner_4, " found Gold");
	    .print(X,",",Y);
	    ?e_movement(Xm,Ym);
	    + e_movement(Xm+X,Xm+Y);
	    -e_movement(Xm,Ym);
	    move(X, Y);
	    rover.ia.log_movement(X, Y);
		.print("collecting"); 
		?resources_held(Max, Held);
    	for ( .range(I,Held,Max-1)) {
       		collect("Gold");
       		-resources_held(Max, Held+I-1+1);
       		+resources_held(Max, Held+I+1);
     	}
     	! return_to_deposit;
		.
	
+! collecting_resource(X, Y): true
	<-	.print(scanner_4, " found Gold");
	    .print(X,",",Y);
	    ?e_movement(Xm,Ym);
	    + e_movement(Xm+X,Xm+Y);
	    -e_movement(Xm,Ym);
	    move(X, Y);
	    rover.ia.log_movement(X, Y);
		.print("collecting"); 
		?resources_held(Max, Held);
    	for ( .range(I,Held,Max-1)) {
       		collect("Gold");
       		-resources_held(Max, Held+I-1+1);
       		+resources_held(Max, Held+I+1);
     	}
     	! return_to_deposit;
		.	
	
	
@ ob_collecting_resource(X,Y)[atomic]
+ ob_collecting_resource(X, Y)[source(SS)]: true
	<-	- ob_collecting_resource(X, Y)[source(SS)];
	    .print(scanner_4, " found Gold");
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
     	! return_to_deposit;
		.
		
		
	
//move if resources run out of quantity 
+ invalid_action(collect, unmet_requirement) : true
	<- .print("No Gold");
	   ! return_to_base;
	   .
	   

//move if obstructed by agent
+ obstructed(XT, YT, X_left, Y_left) : true
	<- .print("obstructed");
	   ? resources_held(M,H);
	   .send(scanner_4, tell, obstructed_agentG(X_left, Y_left, H));
	   if(Y_left > 0){
	   	.print(Y_left, "> 0");
	   	?e_movement(X,Y);
	   	?updateX(X);
	   	?updateY(Y);
	   	?right(D);
	   	if (D == 0){
	   		.print("trying right");
	   		-+ right(1);
	   		move(1, 0);
	   		-+ updateX(X+1);
	   		-+ e_movement(X+1, Y);
	   		-+ right(0);
	   		move(0, 1);
	   		-+ updateY(Y+1);
	   		-+ e_movement(X, Y+1);
	   		! return_to_og_positionY(X_left,Y_left);
	   	 }else{
	   	 	.print("going opposite directions");
	   		! return_to_base;
	   	 }
	   	}
	   	else{
	   	 .print(X_left, "< 0");
	   	 ?e_movement(X,Y);
	   	 ?updateX(X);
	   	 ?updateY(Y);
	   	 ?right(D);
	   	 if (D == 0){
	   	 	.print("trying right");
	   		-+ right(1);
	   		move(1, 0);
	   		-+ updateX(X+1);
	   		-+ e_movement(X+1, Y);
	   		-+ right(0);
	   		move(0, -1);
	   		-+ updateY(Y+1);
	   		-+ e_movement(X, Y+1);
	   		! return_to_og_positionY(X_left,Y_left);
	   	  }else{
	   	  	.print("going opposite direction");
	   		! return_to_base;
	   	  }
	   	}
	   .
	  // ?resources_held(M,H);
	   // ?e_movement(Xm,Ym);
	   // .send(scanner_4, tell, obstructed_agentG(X_left, Y_left, H));
	   //! collecting_resource(X_left, Y_left);
	   // .
	   
	
// return to deposit
@return_to_deposit[atomic]
+! return_to_deposit : true
		<-.print("I am returning to deposit");
		  ?e_movement(X,Y);
		  //rover.ia.get_distance_from_base(XFromBase, YFromBase);
	      move(-X, -Y);
	      deposit("Gold");
	      deposit("Gold");
	      deposit("Gold");
	      -+resources_held(3, 0);
	      rover.ia.clear_movement_log;
	      -+e_movement(0,0);
	      .print("scanner_4 move again!");
	      .send(scanner_4, tell, resource_not_found);
	      .
	      
// return to deposit
+ ob_return_to_deposit(X, Y)[source(SS)] : true
		<-.print("I am returning to deposit");
	      move(X, Y);
	      deposit("Gold");
	      deposit("Gold");
	      deposit("Gold");
	      -+resources_held(3, 0);
	      rover.ia.clear_movement_log;
	      - ob_return_to_deposit(X, Y)[source(SS)];
	      .print("scanner_4 move again!");
	      .send(scanner_4, tell, resource_not_found);
	      .

+! return_to_base: true
		<-.print("return to base bcs of invalid action");
		  ?e_movement(X,Y);
		  //rover.ia.get_distance_from_base(XFromBase, YFromBase);
		  .print(X,Y);
		  move(-X, -Y);
		  rover.ia.clear_movement_log;
		  -+e_movement(0,0);
		  .print("scanner_4 move again!");
		  .send(scanner_4, tell, resource_not_found);
		  .
	   
	 
					
+! return_to_og_positionY(X_left, Y_left): true
	<- .print("returning to original position");
	   ?updateX(X);
	   ?updateY(Y);
	   if(Y_left < 0){
	   	move(0, -1);
	   	-+updateY(Y+1);
	   	move(X, 0);
	   	! collectiong_resource(X_left, Y_left+Y);
	   }
	   else{
	   	move(0, 1);
	   	-+updateY(Y+1);
	   	move(X, 0);
	   	! collectiong_resource(X_left, Y_left-Y);
	   }
	   .		
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					