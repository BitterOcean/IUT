import React from 'react';
import {Box, Typography, Grid} from '@material-ui/core';
import {makeStyles} from '@material-ui/core/styles';

import Drawer from './Drawer';


const useStyles = makeStyles(theme => ({
    navigatorStyle:{
        height: 50,
        width:'100%',
        backgroundColor: theme.palette.primary.main,
    },
    itemStyle: {
        width:"50%",
        height: '100%'
    },
    typographyStyle: {
        color: theme.palette.text.secondary,
        fontSize: '20px',
    }
}));
const NavigationMenu = () => {
    const classes = useStyles();
    return (
    <Grid
    container
    className={classes.navigatorStyle}
    justify="flex-start"
    spacing={3}
    alignItems="center"
    >
        <Grid item>
        <Drawer />
        </Grid>
        <Grid item>
        <Typography color="primary" className={classes.typographyStyle} align="center">
            Payslip Managment System
        </Typography>
        </Grid>
    </Grid>
    );
}

export default NavigationMenu;