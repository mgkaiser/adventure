.scope
.define current_file "main.s"

.include "mac.inc"
.include "main.inc"
.include "rooms.inc"
.include "actor.inc"
.include "print.inc"
.include "basicstub.inc"    ; ONLY include this in main.s.  MUST be last include

.segment "MAIN"

; Define exports for all public functions in this module

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Variables that do not require initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "BSS"

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Variables that DO require initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "DATA"


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Main Program Code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                
.segment "MAIN"
.proc main: near

    ; Jump to main program
    jmp start

.endproc

; Main program entry point
; Usage:
;   Nothing
; Returns:
;   Nothing
; Results:
;   Main program loop executed
; Destroys:
;   All registers
.proc start: near
    
    ; Make the background black and the text light green
    lda #VIC_COL_BLACK              ; Color value 
    sta VIC_BORDER_COL              ; Border color
    lda #VIC_COL_LIGHT_GRAY         ; Color value
    sta VIC_BG_COL                  ; Background color
    
    ; Clear the screen
    scnclr        

    ; Initialize actors    
    jsr actor_init

    ; Set the current room
    lda #$00
    sta current_room        ; Start in room 0
    sta difficulty_level    ; Start in easy mode    
    jsr display_room
    
    ; Display the player
    ;mov_imm_16 R0, player    
    ;jsr actor_move     
    ;jsr actor_update_sprite


    rts

.endproc

.endscope