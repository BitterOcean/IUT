import { API_SIGNUP } from '../apiConstants';

const signup = async (values, setSnackbarInfo, navigate) => {
  fetch(`${API_SIGNUP}`, {
    method: 'post',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(values, 2, 0),
  })
    .then(response => response.json())
    .then((responseJson) => {
      if (responseJson.code === 200) {
        setSnackbarInfo({
          open: true,
          message: 'شما با موفقیت در سامانه ثبت نام کردید',
          severity: 'success',
        });
        navigate('/login');
      } else {
        setSnackbarInfo({
          open: true,
          message: 'این ایمیل قبلا ثبت شده است',
          severity: 'error',
        });
      }
    })
    .catch(() => {
      setSnackbarInfo({
        open: true,
        message: 'در ثبت نام شما مشکلی به وجود آمده است. لطفاً مجدداً تلاش کنید',
        severity: 'error',
      });
    });
};

export default signup;
