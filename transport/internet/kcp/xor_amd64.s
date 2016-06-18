#include "textflag.h"

// func xorfwd(x []byte)
TEXT ·xorfwd(SB),NOSPLIT,$0
  MOVQ x+0(FP), SI  // x[i]
  MOVL x+8(FP), CX  // x.len
  MOVQ x+0(FP), DI
  ADDQ $4, DI       // x[i+4]
  SUBQ $4, CX
loop:
  MOVL (SI), AX
  XORL AX, (DI)
  ADDQ $4, SI
  ADDQ $4, DI
  SUBQ $4, CX

  CMPL CX, $0
  JE done

  JMP loop
done:        
  RET

// func xorbkd(x []byte)
TEXT ·xorbkd(SB),NOSPLIT,$0
  MOVQ x+0(FP), SI
  MOVL x+8(FP), CX  // x.len
  MOVQ x+0(FP), DI
  ADDQ CX, SI       // x[-8]
  SUBQ $8, SI
  ADDQ CX, DI       // x[-4]
  SUBQ $4, DI
  SUBQ $4, CX
loop:
  MOVL (SI), AX
  XORL AX, (DI)
  SUBQ $4, SI
  SUBQ $4, DI
  SUBQ $4, CX

  CMPL CX, $0
  JE done
  
  JMP loop

done:        
  RET
