import React,{useState} from 'react';
import { Dialog,DialogActions, Button, DialogContent } from '@material-ui/core';
import {makeStyles} from '@material-ui/core/styles';
import red from '@material-ui/core/colors/red';

const useStyles = makeStyles(()=>({
  noButton:{
    color:red[500],
  },
}));
const ConfirmModal = (props) => {
    const { onClose, open, handleSubmit,content } = props;
    const classes = useStyles();

    const handleClose = () => {
      onClose();
    };
  
    return (
      <Dialog onClose={handleClose} aria-labelledby="simple-dialog-title" open={open}>
        <DialogContent>
              {content}
          </DialogContent>
        <DialogActions>
              <Button onClick={handleClose} className={classes.noButton}>
                No
              </Button>
              <Button onClick={handleSubmit} color="primary">
                  Yes
              </Button>
        </DialogActions>
      </Dialog>
    );
}

export default ConfirmModal;