import { API_FILE_UPLOAD } from '../apiConstants';

const uploadFile = async (values, navigate, setSnackbarInfo) => {
  fetch(`${API_FILE_UPLOAD}`, {
    method: 'post',
    body: values,
  })
    .then(response => response.json())
    .then((responseJson) => {
      if (responseJson.code === 200) {
        setSnackbarInfo({
          open: true,
          message: 'فایل با موفقیت آپلود شد',
          severity: 'success',
        });
        navigate('/');
      } else {
        setSnackbarInfo({
          open: true,
          message: 'در آپلود فایل خطایی رخ داده است. لطفاً مجدداً تلاش کنید',
          severity: 'error',
        });
      }
    })
    .catch(() => {
      setSnackbarInfo({
        open: true,
        message: 'در آپلود فایل خطایی رخ داده است. لطفاً مجدداً تلاش کنید',
        severity: 'error',
      });
    });
};

export default uploadFile;
