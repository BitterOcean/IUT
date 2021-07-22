import React from 'react';
import PropTypes from 'prop-types';
import { useNavigate } from 'react-router-dom';
import {
  Button,
  Container,
  CssBaseline,
  Grid,
  Typography,
} from '@material-ui/core';
import { makeStyles } from '@material-ui/core/styles';
import FileList from './FileList';
import Header from './Header';

const Copyright = () => (
  <Typography variant="body2" color="textSecondary" align="center">
    {'Copyright © '}
    {' '}
    {new Date().getFullYear()}
    {'.'}
  </Typography>
);

const useStyles = makeStyles(theme => ({
  icon: {
    marginRight: theme.spacing(2),
    maxWidth: 45,
  },
  heroContent: {
    backgroundColor: theme.palette.background.paper,
    padding: theme.spacing(8, 0, 6),
  },
  heroButtons: {
    marginTop: theme.spacing(4),
  },
  cardGrid: {
    paddingTop: theme.spacing(8),
    paddingBottom: theme.spacing(8),
  },
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
  footer: {
    backgroundColor: theme.palette.background.paper,
    padding: theme.spacing(6),
  },
}));

const Landing = (props) => {
  const classes = useStyles();
  const { setSnackbarInfo } = props;
  const navigate = useNavigate();

  return (
    <>
      <CssBaseline />
      <Header />
      <main>
        <div className={classes.heroContent}>
          <Container maxWidth="sm">
            <Typography component="h1" variant="h2" align="center" color="textPrimary" gutterBottom>
              فایل مارکت
            </Typography>
            <Typography variant="h5" align="center" color="textSecondary" paragraph>
              بستری امن و کاربردی و در دسترس برای دارندگان محصولات مجازی و
              راحتی در پیداکردن محصول مورد نیاز و امنیت در خرید برای خریدارن
            </Typography>
            {!localStorage.getItem('token') && (
              <div className={classes.heroButtons}>
                <Grid container spacing={2} justify="center">
                  <Grid item>
                    <Button
                      variant="contained"
                      color="primary"
                      onClick={() => navigate('/signup')}
                    >
                      ثبت نام
                    </Button>
                  </Grid>
                  <Grid item>
                    <Button
                      variant="contained"
                      color="primary"
                      onClick={() => navigate('/login')}
                    >
                      ورود
                    </Button>
                  </Grid>
                </Grid>
              </div>
            )}
          </Container>
        </div>
        <FileList setSnackbarInfo={setSnackbarInfo} />
      </main>
      <footer className={classes.footer}>
        <Typography variant="subtitle2" align="center" color="textSecondary" component="p">
          حقوق سایت و تمامی محصولات برای توسعه دهندگان محفوظ می باشد.
          استفاده از خدمات به منزله پذیرش قوانین ما می باشد.
        </Typography>
        <Copyright />
      </footer>
    </>
  );
};

Landing.propTypes = {
  setSnackbarInfo: PropTypes.func.isRequired,
};

export default Landing;
