type function_t = 
| Var of float
| E 
| PI
| X
| Log  of function_t * function_t
| Pow  of function_t * function_t
| Mult of function_t * function_t
| Sum  of function_t * function_t
| Div  of function_t * function_t;;
