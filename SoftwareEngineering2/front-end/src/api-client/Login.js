import { API_LOGIN } from '../apiConstants';

const login = async (values, setSnackbarInfo, navigate) => {
  fetch(`${API_LOGIN}`, {
    method: 'post',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(values, 2, 0),
  })
    .then(response => response.json())
    .then((responseJson) => {
      if (responseJson.code === 200) {
        localStorage.setItem('token', responseJson.token);
        setSnackbarInfo({
          open: true,
          message: 'با موفقیت وارد شدید',
          severity: 'success',
        });
        navigate('/');
      } else {
        setSnackbarInfo({
          open: true,
          message: 'رمز عبور یا ایمیل وارد شده اشتباه است',
          severity: 'error',
        });
      }
    })
    .catch(() => {
      setSnackbarInfo({
        open: true,
        message: 'در وارد شدن به سامانه مشکلی به وجود آمده است. لطفاً مجدداً تلاش کنید',
        severity: 'error',
      });
    });
};

export default login;
