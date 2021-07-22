/* eslint-disable react/no-array-index-key */
import React from 'react';
import { useNavigate } from 'react-router-dom';
import PropTypes from 'prop-types';
import {
  Button,
  Container,
  Dialog,
  DialogActions,
  DialogContent,
  Divider,
  Grid,
  Typography,
} from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import { green } from '@material-ui/core/colors';
import download from './api-client/Download';
import GetAppIcon from '@material-ui/icons/GetApp';
import ShopIcon from '@material-ui/icons/Shop';
import image from './image/file_transfer.jpg';

const persianFeatures = {
  size: 'حجم(بایت)',
  format: 'فرمت',
  category: 'دسته بندی',
  subcategory: 'زیر دسته بندی',
  author_name: 'نویسنده',
  author_email: 'ایمیل',
};

const useStyles = makeStyles(theme => ({
  root: {
    width: '100%',
    maxWidth: 700,
    backgroundColor: theme.palette.background.paper,
  },
  chip: {
    margin: theme.spacing(0.5),
  },
  section1: {
    margin: theme.spacing(3, 2),
  },
  section2: {
    margin: theme.spacing(2),
  },
  section3: {
    margin: theme.spacing(3, 1, 1),
  },
}));

const DetailDialogBody = (props) => {
  const classes = useStyles();
  const { detail } = props;

  return (
    <div className={classes.root}>
      <div className={classes.section1}>
        <Grid container alignItems="center">
          <Grid item xs>
            <Typography gutterBottom variant="h4">
              {detail.name}
            </Typography>
          </Grid>
          <Grid item>
            <Typography gutterBottom variant="h6">
              {`${detail.price} تومان`}
            </Typography>
          </Grid>
        </Grid>
        <Typography component="span" color="textSecondary" variant="body2">
          {detail.description.split('\n').map((i, key) => <p key={key}>{i}</p>)}
        </Typography>
      </div>
      <Divider variant="middle" />
      <div className={classes.section2}>
        <Container className={classes.cardGrid} maxWidth="md">
          <Grid container spacing={2}>
            {
              Object.keys(detail)
                .filter(e => e !== 'id' && e !== 'name' && e !== 'description' && e !== 'price')
                .map(key => (
                  <Grid item key={key} xs={6}>
                    <Typography display="inline" color="textSecondary" variant="body2">
                      {`${persianFeatures[key]} : `}
                    </Typography>
                    <Typography display="inline" variant="body2">
                      {detail[key]}
                    </Typography>
                  </Grid>
                ))
            }
          </Grid>
        </Container>
      </div>
    </div>
  );
};

DetailDialogBody.propTypes = {
  detail: PropTypes.object.isRequired,
};

const DetailDialog = (props) => {
  const {
    fileDetail,
    open,
    setOpen,
    isBought,
    setSnackbarInfo,
    setConfirmationModal,
  } = props;
  const navigate = useNavigate();

  const handleClose = () => {
    setOpen({
      open: false,
      isBought,
      fileDetail,
    });
  };

  const handleBuyOrDownloadClicked = () => {
    if (localStorage.buyRes === 'true') {
      download(fileDetail.id, setSnackbarInfo);
    } else if (localStorage.token) {
      setConfirmationModal(true);
    } else {
      setSnackbarInfo({
        open: true,
        message: 'باید ابتدا به حساب کاربری خود وارد شوید',
        severity: 'info',
      });
      navigate('/login');
    }
  };

  return (
    <>
      <Dialog
        fullWidth
        maxWidth="sm"
        open={open}
        onClose={handleClose}
        aria-labelledby="max-width-dialog-title"
      >
        <img src={image} alt="pic" style={{ height: '350px', width: '600px' }} />
        <DialogContent>
          <DetailDialogBody detail={fileDetail} />
        </DialogContent>
        <DialogActions>
          {
          localStorage.buyRes === 'true'
            ? (
              <Button
                variant="contained"
                color="primary"
                style={{ backgroundColor: green[500], color: '#FFFFFF' }}
                endIcon={<GetAppIcon />}
                onClick={handleBuyOrDownloadClicked}
              >
                بارگیری
              </Button>
            )
            : (
              <Button
                variant="contained"
                color="primary"
                endIcon={<ShopIcon />}
                onClick={handleBuyOrDownloadClicked}
              >
                خرید
              </Button>
            )
          }
          <Button variant="outlined" onClick={handleClose} color="primary">
            بستن
          </Button>
        </DialogActions>
      </Dialog>
    </>
  );
};

DetailDialog.propTypes = {
  fileDetail: PropTypes.object.isRequired,
  open: PropTypes.bool.isRequired,
  setOpen: PropTypes.func.isRequired,
  isBought: PropTypes.bool.isRequired,
  setSnackbarInfo: PropTypes.func.isRequired,
  setConfirmationModal: PropTypes.func.isRequired,
};

export default DetailDialog;
