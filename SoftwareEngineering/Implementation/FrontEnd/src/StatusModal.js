import React,{useState} from 'react';
import { Snackbar,Button} from '@material-ui/core';
import { Alert } from '@material-ui/lab';
import {makeStyles} from '@material-ui/core/styles';
import red from '@material-ui/core/colors/red';
import green from '@material-ui/core/colors/green';

const useStyles = makeStyles(()=>({
    fail:{
      backgroundColor: red[500],
    },
    pass:{
        backgroundColor: green[500],
        color: green[500],
    },
}));

const StatusModal = (props) => {
    const { onClose, open,content,status } = props;
    const classes = useStyles();

    const handleClose = () => {
      onClose();
    };
  
    return (
      <Snackbar 
        anchorOrigin={{
            vertical: 'bottom',
           horizontal: 'center' 
        }}
        open={open}
        onClose={handleClose}
        action={
              <Button color="secondary" size="small" onClick={handleClose}>
                OK
              </Button>
          }
      >
        <Alert onClose={handleClose} severity={status === 200 ? "success" : "error"}>
          {content}
        </Alert>
      </Snackbar>
        
    );
}

export default StatusModal;