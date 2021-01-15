A coding project by Matt Lee

String Find: An x86 Assembly program that searches for the first matching occurrence of a source string
 inside a target string and returns the matching position. 


The input parameters are a pointer to the source string and a pointer to the target string. If a match is found, the procedure sets the Zero flag and
EAX points to the matching position (i.e., the memory address) in the target string. Otherwise, the Zero flag is clear and EAX is undefined.
