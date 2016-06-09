ligne(0, 'A', "Le Haillan Rostand").
ligne(1, 'A', "Les Pins").
ligne(2, 'A', "Frères Robinson").
ligne(3, 'A', "Hôtel de Ville Mérignac").
ligne(4, 'A', "Pin Galant").
ligne(5, 'A', "Mérignac Centre").
ligne(6, 'A', "Lycées de Mérignac").
ligne(7, 'A', "Quatre Chemins").
ligne(8, 'A', "Pierre Mendès-France").
ligne(9, 'A', "Alfred de Vigny").
ligne(10, 'A', "Fontaine d'Arlac").
ligne(11, 'A', "Peychotte").
ligne(12, 'A', "François Mitterrand").
ligne(13, 'A', "Saint-Augustin").
ligne(14, 'A', "Hôpital Pellegrin").
ligne(15, 'A', "Stade Chaban-Delmas").
ligne(16, 'A', "Gaviniès").
ligne(17, 'A', "Hôtel de Police").
ligne(18, 'A', "Saint-Bruno - Hôtel de Région").
ligne(19, 'A', "Mériadeck").
ligne(20, 'A', "Palais de Justice").
ligne(21, 'A', "Hôtel de Ville").
ligne(22, 'A', "Sainte-Catherine").
ligne(23, 'A', "Place du Palais").
ligne(24, 'A', "Porte de Bourgogne").
ligne(25, 'A', "Stalingrad").
ligne(26, 'A', "Jardin botanique").
ligne(27, 'A', "Thiers - Benauge").
ligne(28, 'A', "Galin").
ligne(29, 'A', "Jean Jaurès").
ligne(30, 'A', "Cenon Gare").
ligne(31, 'A', "Carnot - Mairie de Cenon").
ligne(32, 'A', "Buttinière").
ligne(33, 'A', "Palmer").
ligne(34, 'A', "Pelletan").
ligne(35, 'A', "La Morlette").
ligne(36, 'A', "Jean Zay").
ligne(37, 'A', "La Marègue").
ligne(38, 'A', "Floirac - Dravemont").
ligne(39, 'A', "Iris").
ligne(40, 'A', "Gravières").
ligne(41, 'A', "Bois Fleuri").
ligne(42, 'A', "Lauriers").
ligne(43, 'A', "Mairie de Lormont").
ligne(44, 'A', "Carriet").
ligne(45, 'A', "La Gardette-Bassens-Carbon-Blanc").

ligne(46, 'B', "Berges de la Garonne").
ligne(47, 'B', "Claveau").
ligne(48, 'B', "Brandenburg").
ligne(49, 'B', "New-York").
ligne(50, 'B', "Rue Achard").
ligne(51, 'B', "Bassins à Flot").
ligne(52, 'B', "Les Hangars").
ligne(53, 'B', "Cours du Médoc").
ligne(54, 'B', "Chartrons").
ligne(55, 'B', "CAPC (Musée d'Art Contemporain)").
ligne(56, 'B', "Quinconces").
ligne(57, 'B', "Grand Théâtre").
ligne(58, 'B', "Gambetta").
ligne(59, 'B', "Hôtel de Ville").
ligne(60, 'B', "Musée d'Aquitaine").
ligne(70, 'B', "Victoire").
ligne(71, 'B', "Saint-Nicolas").
ligne(72, 'B', "Bergonié").
ligne(73, 'B', "Barrière Saint-Genès").
ligne(74, 'B', "Roustaing").
ligne(75, 'B', "Forum").
ligne(76, 'B', "Peixotto").
ligne(77, 'B', "Béthanie").
ligne(78, 'B', "Arts et Métiers").
ligne(79, 'B', "François Bordes").
ligne(80, 'B', "Doyen Brus").
ligne(81, 'B', "Montaigne-Montesquieu").
ligne(82, 'B', "UNITEC").
ligne(83, 'B', "Saige").
ligne(84, 'B', "Bougnard").
ligne(85, 'B', "Camponac Médiathèque").
ligne(86, 'B', "Pessac Centre").

:-dynamic verifLigne/1.
verifLigne(0).

verifierNomLignes(L1,L2):-ligne(_,_,L1),ligne(_,_,L2),retract(verifLigne(_)),assert(verifLigne(1)),write("Le départ est l'arrivée sont valides"),nl.
verifierNomLignes(L1,L2):-not(ligne(_,_,L1)),ligne(_,_,L2),retract(verifLigne(_)),assert(verifLigne(0)),write("le départ n'est pas valide"),nl.
verifierNomLignes(L1,L2):-ligne(_,_,L1),not(ligne(_,_,L2)),retract(verifLigne(_)),assert(verifLigne(0)),write("L'arrivée n'est pas valide"),nl.
verifierNomLignes(L1,L2):-not(ligne(_,_,L1)),not(ligne(_,_,L2)),retract(verifLigne(_)),assert(verifLigne(0)),write("Le départ et l'arrivée ne sont pas valides"),nl.

:-dynamic sensDeCirculation/1.
sensDeCirculation("").

verifierSensDeCirculation(L1,L2):-ligne(I1,_,L1),ligne(I2,_,L2),I1>I2,retract(sensDeCirculation(_)),assert(sensDeCirculation("recule")),write("Le tram recule"),nl,write("Le trajet à suivre est : "),nl,afficherListeArrets(I1,I2).
verifierSensDeCirculation(L1,L2):-ligne(I1,_,L1),ligne(I2,_,L2),I1<I2,retract(sensDeCirculation(_)),assert(sensDeCirculation("avance")),write("Le tram avance"),nl,write("Le trajet à suivre est : "),nl,afficherListeArrets(I1,I2).

afficherListeArrets(ID,IF):-sensDeCirculation("avance"),ID<IF,ligne(ID,L,N),write("  - ligne "),write(L),write(" :  "),write(N),nl,ID2 is ID + 1,afficherListeArrets(ID2,IF).
afficherListeArrets(ID,IF):-sensDeCirculation("recule"),ID>IF,ligne(ID,L,N),write("  - ligne "),write(L),write(" :  "),write(N),nl,ID2 is ID - 1,afficherListeArrets(ID2,IF).
afficherListeArrets(ID,IF):-ID=IF,ligne(ID,L,N),write("  - ligne "),write(L),write(" :  "),write(N),nl.

trajet(D,F):-verifierNomLignes(D,F),verifLigne(1),verifierSensDeCirculation(D,F).
