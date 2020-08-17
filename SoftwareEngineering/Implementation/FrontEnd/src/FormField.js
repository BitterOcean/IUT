import React from 'react';
import {TextField} from '@material-ui/core';
const FormField = ({field,index,state,setState,disabled}) => {
    return(
        <TextField
                variant="outlined"
                label={field ? field.name : "Selected Field's Name"}
                autoFocus={index===0}
                fullWidth
                value={state || ''}
                onChange={(e)=>setState(e.target.value)}
                disabled={disabled}
                required
            />
    )

}

export default FormField;