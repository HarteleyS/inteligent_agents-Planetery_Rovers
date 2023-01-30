// Agent blank in project ia_submission

/* Initial beliefs and rules */
resources_held(3, 0).
task(0).
e_movement(0,0).
right(0).
updateX(0).
updateY(0).
left(0).
/* Initial goals */

//!start.

/* Plans */

/* +!start : true <- .print("hello world.");
					move(-1,-1).
					*/
	   
	
//collecting resources	
@ collecting_resource(X,Y)[atomic]
+ collecting_resource(X, Y)[source(SS)]: true
	<-	?task(N);
		-+task(1);
	    - collecting_resource(X, Y)[source(SS)];
	    .print(scanner_4, " found Diamond");
	    .print(X,",",Y);
	    ?e_movement(Xm,Ym);
	    +e_movement(Xm+X,Ym+Y);
	    -e_movement(Xm,Ym);
	    move(X, Y);
	    rover.ia.log_movement(X, Y);
	    //move(Xdist, Ydist);
	    //rover.ia.log_movement(X,Y);
		.print("collecting"); 
		?resources_held(Max, Held);
    	for ( .range(I,Held,Max-1)) {
       		collect("Diamond");
       		-resources_held(Max, Held+I-1+1);
       		+resources_held(Max, Held+I+1);
     	}
     	! return_to_deposit;
		.
		
		
		
+! collecting_resource(X, Y): true
	<-	?task(N);
		-+task(1);
	    .print(scanner_4, " found Diamond");
	    .print(X,",",Y);
	    ?e_movement(Xm,Ym);
	    +e_movement(Xm+X,Ym+Y);
	    -e_movement(Xm,Ym);
	    move(X, Y);
	    rover.ia.log_movement(X, Y);
	    //move(Xdist, Ydist);
	    //rover.ia.log_movement(X,Y);
		.print("collecting"); 
		?resources_held(Max, Held);
    	for ( .range(I,Held,Max-1)) {
       		collect("Diamond");
       		-resources_held(Max, Held+I-1+1);
       		+resources_held(Max, Held+I+1);
     	}
     	! return_to_deposit;
		.
		
	
@ ob_collecting_resource(X,Y)[atomic]
+ ob_collecting_resource(X, Y)[source(SS)]: true
	<-	?task(N);
		-+task(1);
	    - ob_collecting_resource(X, Y)[source(SS)];
	    .print(scanner_4, " found Diamond");
	    .print(X,",",Y);
	    move(X, Y);
	    rover.ia.log_movement(X, Y);
	    //move(Xdist, Ydist);
	    //rover.ia.log_movement(X,Y);
		.print("collecting"); 
		?resources_held(Max, Held);
    	for ( .range(I,Held,Max-1)) {
       		collect("Diamond");
       		-resources_held(Max, Held+I-1+1);
       		+resources_held(Max, Held+I+1);
     	}
     	! return_to_deposit;
		.
	
//move if resources run out of quantity 
+ invalid_action(collect, unmet_requirement) : true
	<- .print("No Diamond");
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
	   
	   //?resources_held(M,H);
	   //?e_movement(Xm,Ym);
	   //.send(scanner_4, tell, obstructed_agentD(X_left, Y_left, H));
	   //! collecting_resource(X_left, Y_left);
	   //.
	   
	   
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
	   
	   
// return to deposit
+ ob_return_to_deposit(X,Y)[source(SS)] : true
		<-?task(N);
		  .print("I am returning to deposit");
		  //rover.ia.get_distance_from_base(XFromBase, YFromBase);
	      move(X, Y);
	      deposit("Diamond");
	      deposit("Diamond");
	      deposit("Diamond");
	      -+resources_held(3, 0);
	      rover.ia.clear_movement_log;
	      - ob_return_to_deposit(X,Y)[source(SS)];
	      .print("scanner_4 move around!");
	      -+task(0);
	      .send(scanner_4,tell,resource_not_found);
	      .
	   
	
// return to deposit
@return_to_deposit[atomic]
+! return_to_deposit : true
		<-?task(N);
		  .print("I am returning to deposit");
		  //rover.ia.get_distance_from_base(XFromBase, YFromBase);
		  ?e_movement(X, Y);
	      move(-X, -Y);
	      deposit("Diamond");
	      deposit("Diamond");
	      deposit("Diamond");
	      -+resources_held(3, 0);
	      rover.ia.clear_movement_log;
	      -+e_movement(0,0);
	      .print("scanner_4 move around!");
	      -+task(0);
	      .send(scanner_4,tell,resource_not_found);
	      .


+! return_to_base: true
		<-.print("return to base bcs of invalid action");
		  ?e_movement(X,Y);
		  .print(X,Y);
		  //rover.ia.get_distance_from_base(XFromBase, YFromBase);
		  move(-X, -Y);
		  rover.ia.clear_movement_log;
		  -+e_movement(0,0);
		  .print("scanner_4 move again!");
		  .send(scanner_4, tell, resource_not_found);
		  .
	   
	 
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					