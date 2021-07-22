import React, { useState } from 'react';
import { BrowserRouter, Route, Routes } from 'react-router-dom';
import PropTypes from 'prop-types';
import {
  createMuiTheme,
  ThemeProvider,
  StylesProvider,
  jssPreset,
} from '@material-ui/core/styles';
import { create } from 'jss';
import rtl from 'jss-rtl';
import SnackbarAlert from './Snackbar';
import Login from './Login';
import Signup from './Signup';
import Landing from './Landing';
import Upload from './Upload';

const theme = createMuiTheme({
  direction: 'rtl',
  typography: {
    fontFamily: ['Vazir', 'Arial', 'sans-serif', 'Roboto'].join(','),
    fontSize: 15,
  },
});

const jss = create({ plugins: [...jssPreset().plugins, rtl()] });

const RTL = props => (
  <StylesProvider jss={jss}>
    {props.children}
  </StylesProvider>
);

RTL.propTypes = {
  children: PropTypes.any,
};

const App = () => {
  const [snackbarInfo, setSnackbarInfo] = useState({
    open: false,
    message: '',
    severity: 'success',
  });

  return (
    <ThemeProvider theme={theme}>
      <RTL>
        <BrowserRouter>
          <Routes>
            <Route path="/" element={<Landing setSnackbarInfo={setSnackbarInfo} />} />
            <Route path="/login" element={<Login setSnackbarInfo={setSnackbarInfo} />} />
            <Route path="/signup" element={<Signup setSnackbarInfo={setSnackbarInfo} />} />
            <Route path="/upload" element={<Upload setSnackbarInfo={setSnackbarInfo} />} />
          </Routes>
        </BrowserRouter>
        <SnackbarAlert
          open={snackbarInfo.open}
          setOpen={e => setSnackbarInfo({ message: '', severity: 'success', open: e })}
          message={snackbarInfo.message}
          severity={snackbarInfo.severity}
        />
      </RTL>
    </ThemeProvider>
  );
};

export default App;
