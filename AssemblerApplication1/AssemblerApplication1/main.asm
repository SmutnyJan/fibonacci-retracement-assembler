;
; AssemblerApplication1.asm
;
; Created: 07.12.2020 8:19:14
; Author : jansmut018
;

 


.INCLUDE "m64def.inc" ; vloení definièního souboru pro ATmega64

 

.DEVICE ATMEGA64    ; typ procesoru

 

.DEF x0 = R20    ; pojmenování registrù
.DEF x1 = R21
.DEF x2 = R22
.DEF i = R25


 

.EQU FREQ = 16000000    ; definice frekvence krystalu
.EQU TLAC = PORTD        ; alternativní pojmenování IO registru (pozdìji nelze zmìnit)

 

.SET DISP = 0x20        ; pøiøazení jména hodnotì (lze pozdìji pøedefinovat)

 

.DSEG    ; pamì dat
;.ORG 0x200                ; urèení umístìní v pamìti 
    poradi:    .BYTE 1
	vysledek:    .BYTE 1


;.EQU cislo1 = SRAM_START
;.EQU cislo2 = SRAM_START + 1

 

.ESEG    ; pamì EEPROM pro data
        .DB 0x3F; ulozeni konstant do pameti EEPROM

 

.MACRO     SUBI16               ; Start macro definition
    subi    @1,low(@0)    ; Subtract low byte
    sbci    @2,high(@0)   ; Subtract high byte
.ENDMACRO

 

;SUBI16 0x1234,r16,r17

 

.CSEG    ; pamì programu
.ORG 0x100    ; umístìní následujích instrukcí v pamìti programu


LDS R25, poradi
CLR R22
CP R25, R22
BREQ konec02
LDI R22, 1
CP R20, R22
BREQ konec02
CLR R20
LDI R21, 1
cykl02:
	MOV R22, R20
	ADD R22, R21
	MOV R20, R21
	MOV R21, R22
	DEC R25
	BRNE cykl02
konec02:
	STS vysledek, R22
NOP


