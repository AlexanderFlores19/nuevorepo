PROCESSOR 18F57Q84
    #include <xc.inc>
    
    PSECT resetVect,class=CODE,reloc=2
    resetVect:
         goto Main
	 
PSECT CODE
 Main:
;--------------------------------------------------------------
; @file	   Programa_uC.s
; @brief   En este programa que hemos creado sirve para comparar el 
;          refistro f y el acumulador w, en este caso si f>w, si eso 
;	   fuese verdad el programa hara un salto a la etiqueta true
;	   y se ejecutara el bloque de codigo que se encuentra alli donde 
;          A=7x-9y o de lo contrario si fuese falso el programa no hace
;          el salto y ejecuta la siguiente instruccion que es el GOTO False
;	   de ese modo se dirigira a la etiqueta False y ejecuta el bloque
;	   de codigo que se encuentra alli que es A=5x+3y, finalmente el 
;	   programa termina con una etiqueta llamada Exit que contiene la 
;          instruccion Nop.
; @date    19/11/22
; @author  Alexander Arturo Flores Juarez
;------------------------------------------------------------------ 
    
    
    ;MOVWF f,a -STATUS:NOME
    MOVLW   2         ; (w)-->2
    MOVWF  0X501,a    ; (w)-->f
    ;BSF  0X501,1,a   ;1-->f<1>  , f-->2
    
    MOVLW    4        ; (w)-->4
    MOVWF 0x502,a     ; (w)-->f
    
    ;CPFSGT f,a -STATUS:NOME
    CPFSGT  0X501,a   ;skip if (f)>(w)  , x>y
    GOTO    False
True:
    ; A=7x-9y
    MOVLW 7           ;  7-->(w)
    MULWF 0X501,a     ; (w) x (f)-->PRODH:PRODL=(0X4F3)
    MOVF  0X4F3,w,a     ; (f)-->w
    MOVWF 0X505,a     ; (w)-->f
    
    MOVLW 9           ; 9-->(w)
    MULWF 0X502,a     ; (w) x (f)-->PRODH:PRODL=(0X4F3)
    MOVF  0X4F3,w,a     ; (f)-->w
    
    ;SUBWF  f,d,a  - STATUS [4:0]
    SUBWF 0X505,w,a   ; (f) - (w) --> f  
    MOVWF 0X500,a      
    GOTO  Exit
False:
    ; A=5x+3y     ; A-->0x500
    MOVLW 5            ;  5-->(w)
    MULWF 0x501,a      ; (w) x (f)-->PRODH:PRODL=(0X4F3)
    MOVF  0X4F3,w,a      ; (f)-->w
    MOVWF 0X504,a      ; (w)-->f
    
    MOVLW 3            ;  3-->(w)
    MULWF 0X502,a      ; (w) x (f)-->PRODH:PRODL=(0X4F3)
    MOVF  0X4F3,w,a    ; (f)-->w
    
    ;ADDWF: f,d,a - STATUS:[4:0]
    ADDWF 0X504,w,a    ; (w) + (f)---> w
    MOVWF 0X500,a      
    
    
Exit:    
    NOP
    
   
END resetVect   

