��    ]           �      �     �     �          $  "   5  2   X  5   �  "   �  %   �  6   
	  %   A	     g	     }	     �	  -   �	     �	  E   �	  #   :
  #   ^
  >   �
  "   �
  #   �
                :     S  6   k     �     �  3   �      
  !   +  4   M  %   �  &   �  $   �  ,   �  -   !     O  :   k  )   �     �     �  ,   �  .   *  >   Y     �     �  =   �       -     /   M     }  !   �     �     �     �     �       !   "     D     _      |     �      �  !   �  #      *   $     O  !   b  #   �     �     �     �     �  	   �     �               &     /  
   8  v   C     �     �     �     �          4  6  T     �     �    �     �     �     �     �  (     6   8  8   o  (   �  8   �  =   
  *   H     s     �  "   �  :   �  1   �  Q   (  3   z  3   �  A   �  &   $  &   K     r     �  %   �  $   �  =   �     /     J  D   e  #   �  #   �  <   �  -   /  -   ]  +   �  2   �  4   �  "     0   B  #   s  !   �      �  5   �  6     E   G     �  *   �  B   �       1   0  1   b     �  "   �     �     �      �  $      &   @   &   g   !   �   !   �   '   �   '   �   ,   "!  (   O!  (   x!  .   �!     �!  *   �!  *   "     <"     Q"     _"     q"  
   w"  *   �"     �"  
   �"  
   �"  
   �"  
   �"  �   �"      |#     �#     �#  #   �#     �#  0   $  8  >$     w&     �&            *       "   %   '           ]      Y              6           /   M      7   Q              $   N   ;      0   <   >                G   V   @      5              E   X   I               	   (      C      \   4       :       P   L   A   H       [   #   T   D   J              !   9       S   =   8       )   
   ?             .       3       -   B   R   ,                 K   U   1   +   Z       &   F       W          2       O                                           00xy: Arpeggio 01xx: Pitch slide up 02xx: Pitch slide down 03xx: Portamento 04xy: Vibrato (x: speed; y: depth) 05xy: Volume slide + vibrato (compatibility only!) 06xy: Volume slide + portamento (compatibility only!) 07xy: Tremolo (x: speed; y: depth) 08xy: Set panning (x: left; y: right) 09xx: Set groove pattern (speed 1 if no grooves exist) 0Axy: Volume slide (0y: down; x0: up) 0Bxx: Jump to pattern 0Cxx: Retrigger 0Dxx: Jump to next pattern 0Fxx: Set speed (speed 2 if no grooves exist) 12xx: Set duty cycle (0 to 8) 20xx: Set channel mode (bit 0: square; bit 1: noise; bit 2: envelope) 21xx: Set noise frequency (0 to 1F) 21xx: Set noise frequency (0 to FF) 22xy: Set envelope mode (x: shape, y: enable for this channel) 23xx: Set envelope period low byte 24xx: Set envelope period high byte 25xx: Envelope slide up 26xx: Envelope slide down 27xx: Set noise AND mask 28xx: Set noise OR mask 29xy: Set auto-envelope (x: numerator; y: denominator) 2Exx: Write to I/O port A 2Fxx: Write to I/O port B 80xx: Set panning (00: left; 80: center; FF: right) 81xx: Set panning (left channel) 82xx: Set panning (right channel) 88xy: Set panning (rear channels; x: left; y: right) 89xx: Set panning (rear left channel) 8Axx: Set panning (rear right channel) 90xx: Set sample offset (first byte) 91xx: Set sample offset (second byte, ×256) 92xx: Set sample offset (third byte, ×65536) 9xxx: Set sample offset*256 Broken output volume - Episode 2 (PLEASE KEEP ME DISABLED) Broken output volume on instrument change Cxxx: Set tick rate (hz) E0xx: Set arp speed E1xy: Note slide up (x: speed; y: semitones) E2xy: Note slide down (x: speed; y: semitones) E3xx: Set vibrato shape (0: up/down; 1: up only; 2: down only) E4xx: Set vibrato range E5xx: Set pitch (80: center) E6xy: Quick legato (x: time (0-7 up; 8-F down); y: semitones) E7xx: Macro release E8xy: Quick legato up (x: time; y: semitones) E9xy: Quick legato down (x: time; y: semitones) EAxx: Legato EBxx: Set LEGACY sample mode bank ECxx: Note cut EDxx: Note delay EExx: Send external command F0xx: Set tick rate (bpm) F1xx: Single tick note slide up F2xx: Single tick note slide down F3xx: Fine volume slide up F4xx: Fine volume slide down F5xx: Disable macro (see manual) F6xx: Enable macro (see manual) F7xx: Restart macro (see manual) F8xx: Single tick volume slide up F9xx: Single tick volume slide down FAxx: Fast volume slide (0y: down; x0: up) FCxx: Note release FDxx: Set virtual tempo numerator FExx: Set virtual tempo denominator FFxx: Stop song Instrument %d Invalid effect Noise Sample %d Sega Genesis Extended Channel 3 Sega Genesis/Mega Drive Square 1 Square 2 Square 3 TI SN76489 a square/noise sound chip found on the Sega Master System, ColecoVision, Tandy, TI's own 99/4A and a few other places. cannot remove the last one file is empty file size is invalid! invalid wavetable header/data! max number of systems is %d no free patterns in channel %d! these compatibility flags are getting SO damn ridiculous and out of control.
as you may have guessed, this one exists due to yet ANOTHER DefleMask-specific behavior.
please keep this off at all costs, because I will not support it when ROM export comes.
oh, and don't start an argument out of it. Furnace isn't a DefleMask replacement, and no,
I am not trying to make it look like one with all these flags.

oh, and what about the other flags that don't have to do with DefleMask?
those are for .mod import, future FamiTracker import and personal taste!

end of rant too many samples! too many wavetables! Project-Id-Version: furnace 0.6.3
Last-Translator: Automatically generated
Language-Team: none
Language: sk
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Plural-Forms: nplurals=3; plural=(n==1) ? 0 : (n>=2 && n<=4) ? 1 : 2;
 00xy Arpeggio 01xx Tónovy šmyk nahor 02xx Tónovy šmyk nadol 03xx Portamento 04xy Vibráto (x: rýchlosť; y: hĺbka) 05xy: Hlasový šmyk + vibráto (iba kompatibilnosť!) 05xy: Hlasový šmyk + portamento (iba kompatibilnosť!) 07xy: Tremolo (x: rýchlosť; y: hĺbka) 08xy: Nastav stereo (x: ľavý kanál; y: pravý kanál) 09xx: Nastav gróv obrazca (rýchlosť 1 ak gróv neexistuje) 0Axy: Hlasový šmyk (0y: nadol; x0 nahor) 0Bxx: Skoč na obrazec 0Cxx: Zopakuj 0Dxx: Skoč na nasledovný obrazec 0Fxx: Nastav rýchlosť (rýchlosť 2 ak gróv neexistuje) 12xx: Nastav striedu štvorcovej vlny (od 0 do 8) 20xx: Nastav režím kanála (bit 0: štvorec; bit 1: biely šum; bit 2: obálka) 21xx: Nastav frekvenciu bielého šumu (od 0 do 1F) 21xx: Nastav frekvenciu bielého šumu (od 0 do FF) 22xy: Nastav režím obálky (x: tvar, y: zapni pre tento kanál) 23xx: Nastav dolný bajt časa obálky 24xx: Nastav horný bajt časa obálky 25xx: Šmyk obálky nahor 26xx: Šmyk obálky nadol 27xx: Nastav AND masku bielého šumu 28xx: Nastav OR masku bielého šumu 29xy: Nastav automatskú obálku (x: čitateľ; y: činiteľ) 2Exx: Vpíš do I/O port A 2Fxx: Vpíš do I/O port B 80xx: Nastav stereo (00: ľavý kanál; 80 stred; FF: pravý kanál) 81xx: Nastav stereo (ľavý kanál) 82xx: Nastav stereo (pravý kanál) 88xy: Nastav stereo zadných kanálov (x: ľavý; y: pravý) 89xx: Nastav stereo zadného ľavého kanálu 8Axx: Nastav stereo zadného pravého kanálu 90xx: Posuň začiatok snímky (prví bajt) 91xx: Posuň začiatok snímky (druhý bajt, x256) 92xx: Posuň začiatok snímky (tretí bajt, x65536) 9xxx: Posuň začiatok snímky*256 Pohubený hlas - Časť dva (NECHAJ MA VYPNÚTI) Pohubený hlas na zmene instrumenta Cxxx: Nastav intenzitu čipu (hz) E0xx: Nastav rýchlosť arpeggia E1xy: Notovy šmyk nahor (x: rýchlosť; y: poltóny) E2xy: Notovy šmyk nadol (x: rýchlosť; y: poltóny ) E3xx: Nastav tvar vibráta (0: hore/dolu; 1: iba nahor; 2: iba nadol) E4xx: Nastav šírku vibráta E5xx: Nastav Tón (80: stred, pravá nota) E6xy: Rýchly legato (x: čas (0-7 nahor; 8-F nadol); y: poltóny) E7xx: Makro uvoľnenie E8xy: Rýchly legato nahor (x: čas; y: poltóny) E9xy: Rýchly legato nadol (x: čas; y: poltóny) EAxx: Legato EBxx: Nastav STARÚ zvukovú banku ECxx: Prestaň hrať notu EDxx: Odohrať notu neskôr EExx: Odošli vonkajšiu komandu F0xx: Nastav rýchlosť piesne (bpm) F1xx: jedno-tikovy notový šmyk nahor F2xx: jedno-tikovy notový šmyk nadol F3xx: Jemný hlasový šmyk nahor F4xx: Jemný hlasový šmyk nadol F5xx: Vypni makro (pozri si príručku) F6xx: Zapni makro (pozri si príručku) F6xx: Reštartuj makro (pozri si príručku) F8xx: Jedno-tikový hlasový šmyk nahor F8xx: Jedno-tikový hlasový šmyk nadol FAxx: Fast volume slide (0y: nadol; x0: nahor) FCxx: Uvoľnenie noty FDxx: Nastav čitateľa virtualného tempa FExx: Nastav činiteľa virtualného tempa FFxx: Zastav pieseň Instrument %d Effekt neexistuje Noise Snímka %d Sega Mega Drive zo rošírenim 3. kanálom Sega Mega Drive Štvorec 1 Štvorec 2 Štvorec 3 TI SN76489 štvorcoý/nojsový čip, ktorý sa môže najsť vo Sega Master System-e, ColecoVision-eTandy-ne, TI-ovom 99/4A a ešte na niektorých systémach Nemožno vymazať posledný čip fajl je prazdny Nesprávna veľkosť fajla! Nespravny záhlavie/data wavetabla! Najviac môžete mať %d čipov nieto viacej slobodných obrazcob na kanále %d! Tieto kompatibilné nastavenia sú toľko blbé a hlúpe.
Možete uhadnuť, tento problem existuje kvôli EŠTE JEDNEJ DefleMask-ovej chybi.
Prosím vás, nechajte toto vypnúte ako keby vám život závisel od tochto, lebo nebudem podržiavať toto keď príde ROM vývoz.
Tak, nezačínajte spor vôkol tochto. Furnace nie je DefleMask 2.0,aj nechcem,
Aby sa zdalo kvôli tíchto nastaveniach.

No, a čo s týmito nastaveniami čo nemaju nič s DelfeMask-om?
To sú pre .mod učítanie, budúce famitracker učitanie aj pre osobný vkus!

koniec mojích mýšlienok Priveľa snímkou! Priveľa wavetablou! 