import React from 'react';
import PropTypes from 'prop-types';
import {
  Button,
  Dialog,
  DialogActions,
  DialogContent,
  DialogContentText,
  DialogTitle,
} from '@material-ui/core';

const ConfirmationDialogBody = (props) => {
  const {
    title,
    subTitle,
    setModalOpen,
    onYesButtonClick,
  } = props;

  const handleYesButtonClick = () => {
    onYesButtonClick();
    setModalOpen(false);
  };

  return (
    <div>
      <DialogTitle id="alert-dialog-slide-title">
        {title}
      </DialogTitle>
      <DialogContent>
        <DialogContentText id="alert-dialog-description">
          {subTitle}
        </DialogContentText>
      </DialogContent>

      <DialogActions>
        <Button
          color="primary"
          onClick={() => setModalOpen(false)}
        >
          خیر
        </Button>

        <Button
          onClick={handleYesButtonClick}
          color="primary"
          autoFocus
        >
          بله
        </Button>
      </DialogActions>
    </div>
  );
};

const ConfirmationDialog = (props) => {
  const {
    title,
    subTitle,
    modalOpen,
    setModalOpen,
    onYesButtonClick,
  } = props;

  return (
    <Dialog
      open={modalOpen}
      onClose={() => setModalOpen(false)}
      aria-labelledby="alert-dialog-title"
      aria-describedby="alert-dialog-description"
    >
      <ConfirmationDialogBody
        title={title}
        subTitle={subTitle}
        setModalOpen={setModalOpen}
        onYesButtonClick={onYesButtonClick}
      />
    </Dialog>
  );
};

ConfirmationDialogBody.propTypes = {
  title: PropTypes.string.isRequired,
  subTitle: PropTypes.string.isRequired,
  setModalOpen: PropTypes.func.isRequired,
  onYesButtonClick: PropTypes.func.isRequired,
};

ConfirmationDialog.propTypes = {
  title: PropTypes.string.isRequired,
  subTitle: PropTypes.string.isRequired,
  modalOpen: PropTypes.bool.isRequired,
  setModalOpen: PropTypes.func.isRequired,
  onYesButtonClick: PropTypes.func.isRequired,
};

export default ConfirmationDialog;
