import React, {
  useState,
  useEffect,
} from 'react';
import PropTypes from 'prop-types';
import { Container, Grid } from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import FileItem from './FileItem';
import DetailDialog from './DetailDialog';
import ConfirmationDialog from './ConfirmationModal';
import { API_GET_ALL_FILES } from './apiConstants';
import buy from './api-client/Buy';

const useStyles = makeStyles(theme => ({
  cardGrid: {
    paddingTop: theme.spacing(8),
    paddingBottom: theme.spacing(8),
  },
}));

const FormList = (props) => {
  const classes = useStyles();
  const { setSnackbarInfo } = props;
  const [allFileItem, setAllFileItem] = useState([]);
  const [confirmationModal, setConfirmationModal] = useState(false);

  const [detailModal, setDetailModal] = useState({
    open: false,
    isBought: false,
    fileDetail: {},
  });

  useEffect(() => {
    const getAllFileItems = async () => {
      await fetch(`${API_GET_ALL_FILES}`, {
        method: 'get',
        headers: { 'Content-Type': 'application/json' },
      })
        .then((response) => {
          if (response.status !== 500) {
            return response.json();
          }
          return 204;
        })
        .then((responseJson) => {
          if (responseJson.code !== 204) {
            const fileItem = Object.keys(responseJson)
              .flatMap(key => responseJson[key]);
            setAllFileItem(fileItem);
          }
        })
        .catch(() => {
          setSnackbarInfo({
            open: true,
            message: 'در ارتباط با سرور خطایی رخ داده است. لطفاً مجدداً تلاش کنید',
            severity: 'error',
          });
        });
    };
    getAllFileItems();
  }, [setSnackbarInfo]);

  return (
    <Container className={classes.cardGrid} maxWidth="md">
      <Grid container spacing={4}>
        {
          allFileItem.map(value => (
            <Grid item key={value.id} xs={12} sm={6} md={4}>
              <FileItem
                itemKey={value.id}
                fileName={value.name}
                price={value.price}
                setModalOpen={setDetailModal}
                setSnackbarInfo={setSnackbarInfo}
              />
            </Grid>
          ))
        }
      </Grid>
      <DetailDialog
        fileDetail={detailModal.fileDetail}
        open={detailModal.open}
        setOpen={setDetailModal}
        isBought={detailModal.isBought}
        setSnackbarInfo={setSnackbarInfo}
        setConfirmationModal={setConfirmationModal}
      />
      <ConfirmationDialog
        title={`آیا از خرید ${detailModal.fileDetail.name} مطمئن هستید؟`}
        subTitle="بعد از خرید فایل امکان مرجوع کردن و بازگشت مبلغ آن وجود ندارد"
        modalOpen={confirmationModal}
        setModalOpen={setConfirmationModal}
        onYesButtonClick={() => {
          buy({
            file_id: detailModal.fileDetail.id,
            token: localStorage.token,
          }, setSnackbarInfo);
          setDetailModal({
            open: detailModal.open,
            isBought: localStorage.getItem('buyRes') === 'true',
            fileDetail: detailModal.fileDetail,
          });
        }}
      />
    </Container>
  );
};

FormList.propTypes = {
  setSnackbarInfo: PropTypes.func.isRequired,
};

export default FormList;
