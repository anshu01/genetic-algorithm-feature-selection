How GA options are set, and how to add additional options

# Introduction #

In the GAFS toolbox, options are specified using the `ga_opt_set.m` function. This function returns a structure with field names recognizable by the core algorithm. The help file details the available option fields with brief descriptions. This page specifies the use of this function, and how to add additional options fields to the GA.

# Using `ga_opt_set.m` #

ga\_opt\_set can be called as follows:
  * With no input or output
This will output the available options for the toolbox, with brief descriptions and default values.
  * With one output
This will create an options structure with default values.
  * With one output and one input
This assumes the input is a structure with fields which the user would like to use in the algorithm. If the input is not a structure, it is ignored. If the input structure contains un-recognized field names, they will be ignored and will not be present in the output. The values of all recognized field names will be propagated to the output.
  * With one output and an even number of inputs
This assumes that the input is in Parameter/Value form. That is, it assumes that every k<sup>th</sup> input is a string to be used as an option field name, and every k+1<sup>th</sup> input is the value for that option field, for k=1,3,...,N where N is the number of inputs.
  * With one output and an odd number of inputs
This assumes that the first input is a structure, and the following inputs are in Parameter/Value format. The output structure contains values as described in the two points above.

Note that when the function is called with inputs, any unspecified fields are defaulted.

# Updating `ga_opt_set.m` #

If one would like to update the `ga_opt_set.m` function, that is, add new option fields for the GAFS toolbox, the following steps must be adhered to:

  1. Add the field name with description, value type and defaults to the header comments
  1. Add the field name with it's default value to the variable initialization of _option_
  1. In the sub-function validateParamType, add the field name to its corresponding case (e.g., for booleans, in the "Boolean" section). If needed, add a new case which checks if the variable of a valid type
  1. (Optional) In the sub-function validateParamIsSubset, enforce any restrictions on the variable's values (e.g. strings must contain pre-fix "stat