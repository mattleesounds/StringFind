; Matt Lee
; Sting Find main procedure
; source BYTE defines the string to look for
; target BYTE defines where to look

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD

Str_find PROTO, source:PTR BYTE, target:PTR BYTE

.data
target BYTE "whywhenwwwwhowrrr", 0    ; define target byte
source BYTE "how", 0                ; define source byte
pos DWORD 0                         ; define pos byte

.code
main PROC
    INVOKE Str_find, OFFSET source, OFFSET target     ; addresses of source and target into Str_find
    jnz EXIT                ; Not found.
    mov pos, eax            ; Found. Store the position value
EXIT:
    INVOKE ExitProcess, 0
main ENDP
END main
