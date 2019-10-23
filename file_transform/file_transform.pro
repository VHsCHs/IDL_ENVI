;+
; :Description:
;    ESE Task
;
; :Information:
;    This .pro file, along with its *.task file, defines an ESE task.
;    The *.task file contains metadata about the task and its parameters, while
;    this .pro file contains the actual implementation of the task algorithm.
;
; :Keywords:
;    INPUT  - This variable should expect input from the calling http client.
;             See the INPUT parameter in the parameters array in the *.task
;             file for more information.
;    OUTPUT - Data stored in this variable will be returned to the calling http
;             client in the http response for synchronous tasks, or in the job
;             resource for asynchronous tasks. See the OUTPUT parameter in the
;             parameters array in the *.task file for more information.
;
; :Notes:
;    For more information about ESE tasks, please consult the documentation.
;-

pro file_transform, INPUT=input, OUTPUT=output

  compile_opt idl2
  ;TODO auto-generated stub

end