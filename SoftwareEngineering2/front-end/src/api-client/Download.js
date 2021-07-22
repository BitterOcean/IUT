import { API_DOWNLOAD_FILE } from '../apiConstants';

const download = async (file_id, setSnackbarInfo) => {
  window.location.href = `${API_DOWNLOAD_FILE}?token=${localStorage.token}&file_id=${file_id}`;
  setSnackbarInfo({
    open: true,
    message: 'فایل با موفقیت دانلود شد',
    severity: 'success',
  });
};

export default download;
