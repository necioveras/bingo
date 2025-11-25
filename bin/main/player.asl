// Agent player in project prj_MAS_Bingo

/* Initial beliefs and rules */

/* Initial goals */

!participate.

/* Plans */

+!participate: true<- 
	//?myArtifact (ID);	
	//focus(ID);		
	.send(owner,askOne, buildCard, Card);
	+myCard(Card);
	sell;   //buy	- informa que adquiriu uma cartela
	.print("Estou no bingo! Registrei minha cartela.").	

/*	
+?myArtifact(C) : true <-
	lookupArtifact("bingo", C).	*/

/*	
-?myArtifact(Art) : true <-
	.wait(1000);
	.print("Esperando por um bingo.");
	!participate.	*/
   
//Perceptions of the signals

+myCard(Card) <-
	.concat("Cartela:", Card,S);	
     .print(S);
     Hit = 0;
     +myHits(Hit).                                      //adiciona uma nova crença com o total de acertos
	
+status(S) : S == "sorted" & myCard(Card) & myHits(Hit) <-	
	?numSorted(V);
	.print("Opa, percebi um numero sorteado ... ", V);
	if (.member(V, Card) ) {		
		+myHits(Hit+1);
		.print("acertei:", V, " Ate agora acertei ", Hit+1, " numero(s) em um total de ", .length(Card));
	}.
	
+myHits(Hit) : myCard(Card) <-
	if (Hit == .length(Card)){
		 .print("Gaaaaaaaaaaaaaaaaaaaannnnnnnnnnnnhhhhhhhhhhheeeeeeeeiiiiiii!!");
		 winner;
	}.
	

+status(S) : 	S == "started" <-
	.print("Legal! Bingo inciado!").
	
+status(S) : 	S == "stoped" <-
   .print("Ahhhh .. já acabou.").   	
	
//Percepctions of the Observable Properties	
+numSorted(V).

{ include("$jacamo/templates/common-cartago.asl") }
{ include("$jacamo/templates/common-moise.asl") }
