import React, { useState } from 'react';
import PropTypes from 'prop-types';
import { useNavigate } from 'react-router-dom';
import { useFormik } from 'formik';
import * as yup from 'yup';
import {
  Button,
  Checkbox,
  FormControlLabel,
  Grid,
  Link,
  Paper,
  TextField,
} from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import login from './api-client/Login';
import file_transfer from './image/file_transfer.jpg';

const useStyles = makeStyles(theme => ({
  root: {
    height: '98vh',
    width: '100%',
  },
  image: {
    backgroundImage: `url(${file_transfer})`,
    backgroundRepeat: 'no-repeat',
    backgroundColor:
      theme.palette.type === 'light' ? theme.palette.grey[50] : theme.palette.grey[900],
    backgroundSize: 'cover',
    backgroundPosition: 'center',
  },
  paper: {
    margin: theme.spacing(8, 4),
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    padding: theme.spacing(2),
  },
  form: {
    width: '100%',
    marginTop: theme.spacing(3),
  },
  submit: {
    margin: theme.spacing(5, 0, 1),
  },
}));

const validationSchema = yup.object({
  email: yup
    .string('آدرس ایمیل خود را وارد کنید')
    .email('آدرس ایمیل وارد شده نامعتبر است')
    .required('وارد کردن آدرس ایمیل الزامی است'),
  password: yup
    .string('رمز عبور خود را وارد کنید')
    .required('وارد کردن رمز عبور الزامی است'),
});

const Login = (props) => {
  const classes = useStyles();
  const [check, setCheck] = useState(Boolean(localStorage.checkbox));
  const navigate = useNavigate();
  const { setSnackbarInfo } = props;

  const formik = useFormik({
    initialValues: {
      email: check ? localStorage.getItem('email') : '',
      password: check ? localStorage.getItem('password') : '',
    },
    validationSchema,
    onSubmit: (values) => {
      localStorage.email = formik.values.email;
      localStorage.password = formik.values.password;
      login(values, setSnackbarInfo, navigate);
    },
  });

  const onCheckBoxClickHandler = () => {
    if (!check) {
      localStorage.email = formik.values.email;
      localStorage.password = formik.values.password;
      localStorage.checkbox = !check;
    } else {
      localStorage.clear();
      formik.setFieldValue('email', '');
      formik.setFieldValue('password', '');
    }
    setCheck(!check);
  };

  return (
    <>
      <Grid container component="main" className={classes.root}>
        <Grid item xs={false} sm={4} md={7} className={classes.image} />
        <Grid item xs={12} sm={8} md={5} component={Paper} elevation={6} square>
          <div className={classes.paper}>
            <form className={classes.form} onSubmit={formik.handleSubmit}>
              <Grid container spacing={4}>
                <Grid item xs={12}>
                  <TextField
                    autoComplete="true"
                    error={
                      !!formik.errors.email
                      && formik.touched.email
                      && Boolean(formik.errors.email)
                    }
                    fullWidth
                    helperText={
                      !!formik.errors.email
                      && formik.touched.email
                      && formik.errors.email
                    }
                    id="email-input-login"
                    label="آدرس ایمیل"
                    name="email"
                    value={formik.values.email}
                    onChange={formik.handleChange}
                    variant="outlined"
                  />
                </Grid>
                <Grid item xs={12}>
                  <TextField
                    autoComplete="off"
                    error={
                      !!formik.errors.password
                      && formik.touched.password
                      && Boolean(formik.errors.password)
                    }
                    fullWidth
                    helperText={
                      !!formik.errors.password
                      && formik.touched.password
                      && formik.errors.password
                    }
                    id="password-input-login"
                    label="رمز عبور"
                    name="password"
                    type="password"
                    value={formik.values.password}
                    onChange={formik.handleChange}
                    variant="outlined"
                  />
                </Grid>
              </Grid>
              <Grid item xs={12}>
                <FormControlLabel
                  control={(
                    <Checkbox
                      checked={check}
                      value="termsAndConditions"
                      onChange={onCheckBoxClickHandler}
                      color="primary"
                    />
                  )}
                  label="این نشست را به خاطر بسپار"
                />
              </Grid>
              <Grid item xs={12}>
                <Button
                  type="submit"
                  fullWidth
                  variant="contained"
                  color="primary"
                  className={classes.submit}
                >
                  ورود
                </Button>
              </Grid>
              <Grid container>
                <Grid item xs>
                  <Link href="/" variant="body2">
                    فراموشی رمز عبور
                  </Link>
                </Grid>
                <Grid item>
                  <Link href="/signup" variant="body2">
                    حساب کاربری ندارید؟ ثبت نام
                  </Link>
                </Grid>
              </Grid>
            </form>
          </div>
        </Grid>
      </Grid>
    </>
  );
};

Login.propTypes = {
  setSnackbarInfo: PropTypes.func.isRequired,
};
export default Login;
