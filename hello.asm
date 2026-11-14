; Program:          hello.asm
; Description:      Hello World program in 8080 assembly language
; Requirements:     MITS Altair Programming System II
;
; This program outputs the string "Hello, world!" one character
; at a time. It polls an input port to determine when the output
; device is ready to accept another character.
;
; ------------------------------------------------------------
; Program initialization
; ------------------------------------------------------------

          ORG       20000Q     ; Set the program's starting address to octal 20000.

START:    LXI       H,MSG      ; Load the HL register pair with the address of MSG.
                               ; HL will point to the next character to output.

; ------------------------------------------------------------
; Main output loop
; ------------------------------------------------------------

LOOP:     IN        20Q        ; Read a byte from input port 20 (octal).
                               ; The input port device status.

          ANI       2          ; AND the input value with 02H.
                               ; This isolates bit 1, the device-ready flag.
                               ; The result also updates the processor flags.

          JZ        LOOP       ; If bit 1 is zero, the device is not ready.
                               ; Jump back to LOOP and check the port again.

          MOV       A,M        ; Load accumulator A with the
                               ; byte addressed by the HL register pair.
         
          ORA       A          ; OR accumulator A with itself.
                               ; This does not change A but updates the flags.
                               ; The zero flag is set if A contains zero.

          JZ        MON        ; If the character is zero, jump to MON, which
          		       ; is the monitor program.
                               ; This indicates the end of the message.
                               ; The string must be terminated with a zero byte.

          OUT       21Q        ; Write the character in accumulator A to
                               ; output port 21 (octal).
                               ; This prints the character.

          INX       H          ; Increment HL to point to the next character
                               ; in the message string.

          JMP       LOOP       ; Return to the beginning of the output loop
                               ; to check device readiness and output the 
                               ; next character.

; ------------------------------------------------------------
; Message data
; ------------------------------------------------------------

MSG:      DB        13,10      ; Output carriage return (13 decimal)
                               ; followed by line feed (10 decimal).

          DB        "Hello, world!"
                               ; ASCII characters forming the message.

          DB        13,10,13,10,0
                               ; Output two carriage-return/line-feed pairs
                               ; followed by a zero byte marking the end
                               ; of the message.

; ------------------------------------------------------------
; Program and assembler directives
; ------------------------------------------------------------

          BEG       START      ; Specify START as the program entry point.
                               ; This is an assembler-specific directive
                               ; for the MITS toolset.

          END       HELLO      ; End of the assembly source program.
                               
          EOA                  ; End-of-assembly directive.
                               ; This is MITS assembler specific.
