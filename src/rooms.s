.scope
.define current_file "rooms.s"

.include "mac.inc"
.include "rooms.inc"

.segment "MAIN"

; Define exports for all public variables in this module
.export current_room
.export difficulty_level

; Define exports for all public functions in this module
.export display_room
.export next_room


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Variables that do not require initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "BSS"

current_room:       .res 1  ; Current room number
difficulty_level:   .res 1  ;  Current difficulty level (0=easy, 1=medium, 2=hard)  

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Variables that DO require initialization
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
.segment "DATA"

roomDataTable:
    .byte <NumberRoom,>NumberRoom,                $04,$21,$00,$00,$00,$00         ;00; 'Number Room.                          Purple           
    .byte <BelowYellowCastle,>BelowYellowCastle,  $07,$A1,$08,$02,$80,$03         ;01; (Top Acess) Reflected/8 Clock Ball     Yellow           
    .byte <BelowYellowCastle,>BelowYellowCastle,  $05,$21,$11,$03,$83,$01         ;02; (Top Access)                           Green           
    .byte <LeftOfName,>LeftOfName,                $E8,$61,$06,$01,$86,$02         ;03; Left of Name                                            
    .byte <BlueMazeTop,>BlueMazeTop,              $86,$21,$10,$05,$07,$06         ;04; Top of Blue Maze                       Blue            
    .byte <BlueMaze1,>BlueMaze1,                  $86,$21,$1D,$06,$08,$04         ;05; Blue Maze #1                           Blue            
;  .byte <BlueMazeBottom,>BlueMazeBottom,        $86,$21,$07,$04,$03,$05         ;06; Bottom of Blue Maze                    Blue            
;  .byte <BlueMazeCenter,>BlueMazeCenter,        $86,$21,$04,$08,$06,$08         ;07; Center of Blue Maze                    Blue            
;  .byte <BlueMazeEntry,>BlueMazeEntry,          $86,$21,$05,$07,$01,$07         ;08; Blue Maze Entry                        Blue            
;  .byte <MazeMiddle,>MazeMiddle,                $08,$25,$0A,$0A,$0B,$0A         ;09; Maze Middle                            Invisible       
;  .byte <MazeEntry,>MazeEntry,                  $08,$25,$03,$09,$09,$09         ;0A; Maze Entry                             Invisible       
;  .byte <MazeSide,>MazeSide,                    $08,$25,$09,$0C,$1C,$0D         ;0B; Maze Side                              Invisible       
;  .byte <SideCorridor,>SideCorridor,            $98,$61,$1C,$0D,$1D,$0B         ;0C; (Side Corridor)                                         
;  .byte <SideCorridor,>SideCorridor,            $B8,$A1,$0F,$0B,$0E,$0C         ;0D; (Side Corridor)                                         
;  .byte <TopEntryRoom,>TopEntryRoom,            $A8,$21,$0D,$10,$0F,$10         ;0E; (Top Entry Room)                                        
    .byte <CastleDef,>CastleDef,                  $0C,$21,$0E,$0F,$0D,$0F         ;0F; White Castle                           White          
    .byte <CastleDef,>CastleDef,                  $00,$21,$01,$1C,$04,$1C         ;10; Black Castle                           Black          
    .byte <CastleDef,>CastleDef,                  $1A,$21,$06,$03,$02,$01         ;11; Yellow Castle                          Yellow          
    .byte <NumberRoom,>NumberRoom,                $1A,$21,$12,$12,$12,$12         ;12; Yellow Castle Entry                    Yellow          
;  .byte <BlackMaze1,>BlackMaze1,                $08,$25,$15,$14,$15,$16         ;13; Black Maze #1                          Invisible       
;  .byte <BlackMaze2,>BlackMaze2,                $08,$24,$16,$15,$16,$13         ;14; Black Maze #2                          Invisible       
;  .byte <BlackMaze3,>BlackMaze3,                $08,$24,$13,$16,$13,$14         ;15; Black Maze #3                          Invisible       
;  .byte <BlackMazeEntry,>BlackMazeEntry,        $08,$25,$14,$13,$1B,$15         ;16; Black Maze Entry                       Invisible       
;  .byte <RedMaze1,>RedMaze1,                    $36,$21,$19,$18,$19,$18         ;17; Red Maze #1                            Red             
;  .byte <RedMazeTop,>RedMazeTop,                $36,$21,$1A,$17,$1A,$17         ;18; Top of Red Maze                        Red             
;  .byte <RedMazeBottom,>RedMazeBottom,          $36,$21,$17,$1A,$17,$1A         ;19; Bottom of Red Maze                     Red             
;  .byte <WhiteCastleEntry,>WhiteCastleEntry,    $36,$21,$18,$19,$18,$19         ;1A; White Castle Entry                     Red             
;  .byte <TwoExitRoom,>TwoExitRoom,              $36,$21,$89,$89,$89,$89         ;1B; Black Castle Entry                     Red             
    .byte <NumberRoom,>NumberRoom,                $66,$21,$1D,$07,$8C,$08         ;1C; Other Purple Room                      Purple          
;  .byte <TopEntryRoom,>TopEntryRoom,            $36,$21,$8F,$01,$10,$03         ;1D; (Top Entry Room)                       Red             
    .byte <BelowYellowCastle,>BelowYellowCastle,  $66,$21,$06,$01,$06,$03         ;1E; Name Room                              Yellow        

; Room Exits Replacement Data
; When room number is >= $80, use these exit replacements
; to override the exits in the room data table above
; Replacement Room = RoomDiffs + (original room AND $7f) + level
RoomDiffs:                                                             
    .byte $10,$0F,$0F            ;Down from Room 01                         Replacement when room is $80                                      
    .byte $05,$11,$11            ;Down from Room 02                         Replacement when room is $83                                                                                         
    .byte $1D,$0A,$0A            ;Down from Room 03                         Replacement when room is $86                                         
    .byte $1C,$16,$16            ;U/L/R/D from Room 1B (Black Castle Room)  Replacement when room is $89                                     
    .byte $1B,$0C,$0C            ;Down from Room 1C                         Replacement when room is $8C                                      
    .byte $03,$0C,$0C            ;Up from Room 1D (Top Entry Room)          Replacement when room is $8F

; Repeat each line 3x and pad with 4 lines of spaces
NumberRoom:
    .byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0    
    .byte $a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0    
    .byte $a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0    
    .byte $a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0    
    .byte $a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0
    .byte $a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0    
    .byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0    

BelowYellowCastle:
    .byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0    
    .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
    .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
    .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
    .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
    .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20        
    .byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0

LeftOfName:
    .byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0
    .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
    .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
    .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
    .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
    .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20        
    .byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0    

CastleDef:
    .byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$a0,$20,$a0,$20,$a0,$20,$20,$20,$20,$a0,$20,$a0,$20,$a0,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0    
    .byte $a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0    
    .byte $a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0    
    .byte $a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0    
    .byte $a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0    
    .byte $a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0    
    .byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0    

BlueMazeTop:
    .byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0
    .byte $20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20
    .byte $a0,$a0,$a0,$a0,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$a0,$a0,$a0,$a0,$20,$20,$20,$20,$a0,$a0,$a0,$a0,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$a0,$a0,$a0,$a0
    .byte $a0,$a0,$a0,$a0,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$a0,$a0,$a0,$a0
    .byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0
    .byte $20,$20,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$20,$20
    .byte $a0,$a0,$a0,$a0,$20,$20,$a0,$a0,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$a0,$a0,$20,$20,$a0,$a0,$a0,$a0

BlueMaze1:
    .byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0
    .byte $20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20
    .byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0
    .byte $a0,$a0,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$a0,$a0,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$20,$a0,$a0,$a0,$a0
    .byte $a0,$a0,$a0,$a0,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$a0,$a0,$a0,$a0,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$a0,$a0,$a0,$a0
    .byte $20,$20,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$20,$20,$a0,$a0,$20,$20,$a0,$a0,$a0,$a0,$20,$20,$a0,$a0,$20,$20,$20,$20,$20,$20,$a0,$a0,$20,$20,$20,$20,$20,$20
    .byte $a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$20,$20,$a0,$a0,$20,$20,$a0,$a0,$20,$20,$a0,$a0,$a0,$a0,$20,$20,$a0,$a0,$20,$20,$a0,$a0,$20,$20,$a0,$a0,$a0,$a0,$a0,$a0,$a0,$a0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Main Program Code
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;                
.segment "MAIN"

; Display the current room on the screen
;   Uses:
;     current_room - current room number
;   Modifies:
;     TMP1, TMP2, PTR1, PTR2, PTR3, PTR4, PTR5  
.proc display_room : near
    
    ; TMP1 = current_room * 8
    lda current_room
    asl a    
    asl a    
    asl a
    sta TMP1
    lda #$00
    sta TMP1+1

    ; PTR1 = &roomDataTable + TMP1
    clc
    lda #<roomDataTable    
    adc TMP1
    sta PTR1
    lda #>roomDataTable
    adc TMP1+1
    sta PTR1+1
    
    ; PTR5 = PTR1->room::room_data_ptr
    ldy #room::room_data_ptr
    lda (PTR1), y
    sta PTR5
    iny
    lda (PTR1), y
    sta PTR5+1

    ; TMP2 = PTR1->room::color
    ldy #room::color
    lda (PTR1), y
    sta TMP2
    
    ; PTR2 = VIC_SCREENPTR
    lda #<VIC_SCREENPTR
    sta PTR2
    lda #>VIC_SCREENPTR
    sta PTR2+1

    ; PTR3 = VIC_SCREENPTR + 40
    lda #<VIC_SCREENPTR + 40
    sta PTR3
    lda #>VIC_SCREENPTR
    sta PTR3+1

    ; PTR4 = VIC_SCREENPTR + 80
    lda #<VIC_SCREENPTR + 80
    sta PTR4
    lda #>VIC_SCREENPTR
    sta PTR4+1
        
    ldx #$00

display_room_loop_outer:

    ldy #$00

display_room_loop_inner:

    ; Grab a byte from the table and store it on the next 3 lines
    lda(PTR5), y
    sta(PTR2), y
    sta(PTR3), y
    sta(PTR4), y

    ; Continue untile we hit 40 bytes
    iny
    cpy #40
    bne display_room_loop_inner

    ; If this is the 8th line end
    inx
    cpx #$07
    beq display_room_loop_done

    ; PTR5 = PTR5 + 40
    clc
    lda PTR5
    adc #40
    sta PTR5
    lda PTR5+1
    adc #0
    sta PTR5+1

    ; PTR2 = PTR2 + 120
    clc
    lda PTR2
    adc #120
    sta PTR2
    lda PTR2+1
    adc #0
    sta PTR2+1
    
    ; PTR3 = PTR3 + 120
    clc
    lda PTR3
    adc #120
    sta PTR3
    lda PTR3+1
    adc #0
    sta PTR3+1
    
    ; PTR4 = PTR4 + 120
    clc
    lda PTR4
    adc #120
    sta PTR4
    lda PTR4+1
    adc #0
    sta PTR4+1

    bra display_room_loop_outer

display_room_loop_done:

    ; Fill all of color RAM with TMP2
    lda TMP2
    ldx #$00
fill_color_ram_loop:
    sta $d800, x
    sta $d900, x
    sta $da00, x
    sta $db00, x
    inx
    bne fill_color_ram_loop

    ; Clear bottom 4 lines to black
    ldx #$00
bottom_4_lines_clear:
    lda #$a0
    sta VIC_SCREENPTR+(21*40), x
    lda #$00
    sta $D800+(21*40), x
    inx
    cpx #160
    bne bottom_4_lines_clear    

    rts

.endproc

; Set "current_room" to the room we are moving into
;   Uses:
;     current_room - current room number
;     y register - the direction we are moving (4=up,5=left,6=right,7=down)
;   Modifies:
;     TMP1, PTR1
.proc next_room : near

    ; TMP1 = current_room * 8
    lda current_room
    asl a    
    asl a    
    asl a
    sta TMP1
    lda #$00
    sta TMP1+1

    ; PTR1 = &roomDataTable + TMP1
    clc
    lda #<roomDataTable    
    adc TMP1
    sta PTR1
    lda #>roomDataTable
    adc TMP1+1
    sta PTR1+1

    ; TMP1 = Next room candidate.  
    lda (PTR1), y    

    ; Is A >= $80?
    bmi next_room_use_replacement   
    
    ; No, just use TMP1
    sta current_room
    rts

next_room_use_replacement:

    ; PTR1 = &RoomDiffs + ((A AND $7f) * 3) + difficulty_level 
    
    ; A = (A AND $7f) * 3
    and #$7f
    sta TMP1
    asl a
    asl a    
    clc
    adc TMP1

    ; PTR1 = A + roomDiffs     
    clc
    adc #<RoomDiffs
    sta PTR1
    lda #0
    adc #>RoomDiffs
    sta PTR1+1

    ; PTR1 += difficulty_level
    lda PTR1
    clc
    adc difficulty_level
    sta PTR1
    lda PTR1+1
    adc #0
    sta PTR1+1

    ; current_room = *PTR1
    ldy #$00
    lda (PTR1), y
    sta current_room
    
    rts
.endproc

.endscope