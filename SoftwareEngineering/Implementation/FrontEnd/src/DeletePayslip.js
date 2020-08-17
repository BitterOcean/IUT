import React, {useState,useEffect} from 'react';
import { useNavigate, Redirect, useParams } from 'react-router-dom';
import {Box, Grid, Card, Typography, Divider, TextField} from '@material-ui/core';
import Drawer from './Drawer';
import {makeStyles} from '@material-ui/core/styles';
import Green from '@material-ui/core/colors/green';
import Background from './images/Picture2.png';
import EmployeeList from './EmployeeList';
import Delete from './images/DeletePayslip.png';

const useStyles = makeStyles(theme=>({
    container:{
      width:'100%', 
      height: '100vh', 
      overflowX: 'hidden',
      backgroundImage: `url(${Background})`,
      backgroundPositionX: '100%',
      backgroundPositionY: '100%',

    },
    innerContainer:{
        width:'70%', 
        height: '80%', 
        overflowX: 'hidden',
        backgroundColor: theme.palette.common.white,
        boxShadow:theme.shadows[15],
      },
    cardStyle: {
        [theme.breakpoints.down('sm')]: {
            width:200,
            height:400,
          },
          [theme.breakpoints.up('md')]: {
            width:250,
            height:500,
          },
          [theme.breakpoints.up('lg')]: {
            width:380,
            height:600,
          },
        backgroundColor: theme.palette.common.white,
        padding:20,
    },
    cardButtons:{
        [theme.breakpoints.down('sm')]: {
            width: 700,
            height:250,
          },
          [theme.breakpoints.up('md')]: {
            width: 700,
            height:250,
          },
          [theme.breakpoints.up('lg')]: {
            width: 700,
            height:250,
          },
          backgroundColor: theme.palette.common.white,
          padding:20,
          borderRadius:20,
    },
    imageStyle: {
        width: 300,
        height: 400,
        marginBottom: 60,
    },
    imageCardButtons:{
        width: 150,
        height: 150,
        marginBottom: 60,
    },
    textFieldContainer:{
        width: '70%',
        height: '80%',
    },
    griditemTextField:{
        width:'50%',
        color:theme.palette.text.primary,
    },
    textField:{
        color: theme.palette.common.black,
    },
    addCard:{
        color: Green[500],
    }
}))

const DeletePayslip = () => {
    const props = useParams();
    const classes = useStyles();
    const navigate = useNavigate();

    return (
        <>
        <Drawer />
        <Grid container alignItems="center" justify="center" className={classes.container}>
        <Grid item container spacing={8} alignItems="center" className={classes.innerContainer}>
        <Grid item>
            <img src={Delete} color="error" className={classes.imageStyle}/>
            <Typography variant="h4" color="textPrimary" align="center">
                 Payslip Deletion
            </Typography>
        </Grid>
        <Divider orientation="vertical" flexItem/>
        <Grid item>
        <Box clone margin="20px !important">
                <Typography variant="h5" color="primary" marginBottom={4}>
                    {`Selected date : ${props.date.replace(':','.')}`}
                </Typography>
            </Box>
            <EmployeeList url="/dashboard/payslip/delete/" />
        </Grid>
        </Grid>
        </Grid>

        </>
    )
};

export default DeletePayslip;