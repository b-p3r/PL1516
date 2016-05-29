#ifndef PROGRAM_STATUS_H_INCLUDED
#define PROGRAM_STATUS_H_INCLUDED
/* program_status.c */
typedef struct status ProgramStatus;

ProgramStatus *init(void);
int pushLabelStack(ProgramStatus *status, int value);
int popLabelStack(ProgramStatus *status);
int topLabelStack(ProgramStatus *status);
int resetLabelStack(ProgramStatus *status);
char *pushLabel(ProgramStatus *status);
int popLabel(ProgramStatus *status);



#endif // PROGRAM_STATUS_H_INCLUDED
