
;********************************************************************************
;*
;*   FILE	    : 01_Resta.asm
;*   DATE	    : 16 de Febrero del 2015
;*   DESCRIPTION	    : Archivo Principal
;*   CPU TYPE	    : PIC16F84a
;*   AUTHOR	    : Nemuel Shamir Pinedo
;*
;*   PROJECT	    : Manejo de bits de estado (z)
;*				    PROGRAMA QUE RESTA DOS NUMEROS E INDENTIFICA SI EL RESULTADO ES CERO (UN LED PRENDE) O ALGUN NUMERO (DOS LEDS PRENDEN)
;*
;*  COPYRIGHT 2017
;*  ALL RIGHTS RESERVED
;*
;********************************************************************************
;--------------------------------------------------------------------------------
;			CONFIGURACION GENERAL
;--------------------------------------------------------------------------------
	    LIST	    P="PIC16F84A"
	    INCLUDE	    "P16F84A.INC"
	    __CONFIG _XT_OSC & _WDT_OFF & _CP_OFF & _PWRTE_ON ;& _LVP_OFF
	    
;--------------------------------------------------------------------------------
;			DECLARACION DE VARIABLES
;--------------------------------------------------------------------------------

	    
	    NUMA	    EQU	    0X20	; Variable A
	    NUMB	    EQU	    0X21	; Variable B
	    NUMD	    EQU	    0X22	; Variable D

;--------------------------------------------------------------------------------
;			DIRECCIONAMIENTO DE PROGRAMA
;--------------------------------------------------------------------------------
	    
	    ORG 0X00			    ; Vector de RESET en 00h.
	    GOTO INICIO			    ; Salta al programa principal.
	    
;--------------------------------------------------------------------------------
;			CODIGO DE PROGRAMA PRINCIPAL
;--------------------------------------------------------------------------------
	    
INICIO

;********************************************************************************
			    BSF		    STATUS,5	    ; CONFIGRACION DE PUERTOS
			    
			    BCF		    TRISB,0	    ;PUERTO DE SALIDA
			    
			    BCF		    TRISB,6	    ;PUERTO DE SALIDA
			    BCF		    TRISB,7	    ;PUERTO DE SALIDA
			    
			    BCF		    STATUS,5	    ;FIN DE CONFIGURACION DE PUERTOS
;********************************************************************************
			    
INICIO1
			    BCF		    PORTB,0	    ; LED OFF
			    BCF		    PORTB,6	    ; LED OFF
			    
			    MOVLW	    D'10'	    ; mueve valor D'10' a W
			    MOVWF	    NUMA	    ; mueve valor de w a NUMA
			    MOVLW	    D'10'	    ; mueve valor  D'9' a W
			    MOVWF	    NUMB	    ; mueve valor de ww a NUMB
			    
			    MOVF	    NUMB,W	    ; mueve NUMB a w
			    SUBWF	    NUMA,W	    ; resta NUMA-NUMB y guarda resultado en w
			    
			    MOVWF	    NUMD	    ; mueve w resultado a NUMBD
			    
			    BTFSC	    STATUS,Z	    ; el status del bit de estado Z=0? Z=0 salta, z=1 sigue
			    
			    GOTO	    RESULCERO	    ; Z=1, NUMD = CERO;
			    GOTO	    RESULNUM	    ; Z=0, NUMD = CUALWUIER VALOR
			    
			    
RESULCERO		    
			    BSF		    PORTB,0	    ; LED ON
			    GOTO	    FIN		    ; IR A FIN
			    
RESULNUM		    
			    BSF		    PORTB,6	    ; LED ON
			    BSF		    PORTB,7	    ; LED ON
			   			    
;--------------------------------------------------------------------------------
;			    FIN DEL PROGRAMA
;--------------------------------------------------------------------------------
FIN
			    END
			    