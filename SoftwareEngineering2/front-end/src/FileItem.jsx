import React from 'react';
import PropTypes from 'prop-types';
import {
  Button,
  Card,
  CardActions,
  CardContent,
  CardMedia,
  Typography,
} from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import DetailsIcon from '@material-ui/icons/Details';
import {
  API_GET_FILE_DETAIL,
  API_CHECK_FILE_REGISTERED,
} from './apiConstants';
import image from './image/file_transfer.jpg';

const useStyles = makeStyles(() => ({
  card: {
    height: '100%',
    display: 'flex',
    flexDirection: 'column',
  },
  cardMedia: {
    paddingTop: '56.25%',
  },
  cardContent: {
    flexGrow: 1,
  },
}));

const FileItem = (props) => {
  const {
    itemKey,
    fileName,
    price,
    setModalOpen,
    setSnackbarInfo,
  } = props;
  const classes = useStyles();

  const detailModalOpenHandler = async () => {
    let checkFileIsRegistered = false;
    if (localStorage.token) {
      await fetch(`${API_CHECK_FILE_REGISTERED}?file_id=${itemKey}&token=${localStorage.getItem('token')}`, {
        method: 'get',
        headers: { 'Content-Type': 'application/json' },
      })
        .then(response => response.json())
        .then((responseJson) => {
          checkFileIsRegistered = responseJson.result === 'true';
          localStorage.setItem('buyRes', responseJson.result === 'true');
        })
        .catch(() => setSnackbarInfo({
          open: true,
          message: 'در ارتباط با سرور خطایی رخ داده است. لطفاً مجدداً تلاش کنید',
          severity: 'error',
        }));
    }
    await fetch(`${API_GET_FILE_DETAIL}?id=${itemKey}`, {
      method: 'get',
      headers: { 'Content-Type': 'application/json' },
    })
      .then(response => response.json())
      .then((responseJson) => {
        setModalOpen({
          open: true,
          isBought: checkFileIsRegistered,
          fileDetail: responseJson,
        });
      })
      .catch(() => setSnackbarInfo({
        open: true,
        message: 'در ارتباط با سرور خطایی رخ داده است. لطفاً مجدداً تلاش کنید',
        severity: 'error',
      }));
  };

  return (
    <Card className={classes.card}>
      <CardMedia
        className={classes.cardMedia}
        image={image}
        title="Image title"
      />
      <CardContent className={classes.cardContent}>
        <Typography gutterBottom variant="h5" component="h2">
          {fileName}
        </Typography>
        <Typography>
          {`قیمت : ${price}`}
        </Typography>
      </CardContent>
      <CardActions>
        <Button
          color="primary"
          size="small"
          endIcon={<DetailsIcon />}
          onClick={detailModalOpenHandler}
        >
          مشاهده جزییات و خرید
        </Button>
      </CardActions>
    </Card>
  );
};

FileItem.propTypes = {
  itemKey: PropTypes.number.isRequired,
  fileName: PropTypes.string.isRequired,
  price: PropTypes.number.isRequired,
  setModalOpen: PropTypes.func.isRequired,
  setSnackbarInfo: PropTypes.func.isRequired,
};

export default FileItem;
