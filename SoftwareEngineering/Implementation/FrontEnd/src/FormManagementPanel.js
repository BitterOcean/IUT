import React from 'react';
import { useNavigate, Redirect, useParams } from 'react-router-dom';
import {Button, Grid, Card, Typography, Divider, TextField} from '@material-ui/core';
import Drawer from './Drawer';
import {makeStyles} from '@material-ui/core/styles';
import PayIcon from './images/PayslipManagement1.png';
import Add from 'mdi-material-ui/PlusCircle';
import Edit from 'mdi-material-ui/PencilCircle';
import Delete from 'mdi-material-ui/TrashCan';
import Green from '@material-ui/core/colors/green';
import Background from './images/Picture2.png';
import Form from './images/Form.png';

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
        width:'90%', 
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
            width:150,
            height:200,
          },
          [theme.breakpoints.up('md')]: {
            width:150,
            height:200,
          },
          [theme.breakpoints.up('lg')]: {
            width:200,
            height:250,
          },
          backgroundColor: theme.palette.common.white,
          padding:20,
          borderRadius:20,
    },
    imageStyle: {
        width: 339,
        height: 400,
        marginBottom: 60,
    },
    imageCardButtons:{
        width: 100,
        height: 100,
        marginBottom: 60,
    },
    textFieldContainer:{
        width: '80%',
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

const FormManagementPanel = () => {
    const props = useParams();
    const classes = useStyles();
    const navigate = useNavigate();
    return (
        <>
            <Drawer />
            <Grid container alignItems="center" justify="center" className={classes.container}>
            <Grid item container spacing={5} alignItems="center" className={classes.innerContainer}>
            <Grid item>
            <img src={Form} className={classes.imageStyle} />
            <Typography variant="h4" color="textPrimary" align="center">
                Form Management
            </Typography>
        </Grid>
        <Divider orientation="vertical" flexItem/>



        <Grid container item direction="column" className={classes.textFieldContainer} spacing={10}>
            <Grid container item justify="center" spacing={5}>
            </Grid> 


            <Grid container item justify="space-around" spacing={5}>
            

            <Grid item alignItems="center">
            <Card className={classes.cardButtons} elevation={3} align="center" onClick={() => navigate(`/dashboard/form/add/`)}>
                    <Add className={`${classes.imageCardButtons} ${classes.addCard}`} />
                    <Typography variant="h4" className={classes.addCard} align="center">
                        Add Field
                    </Typography>
            </Card>
            </Grid>
        

            <Grid item alignItems="center" justify="center" spacing={8}>
            <Card className={classes.cardButtons} elevation={3} align="center" onClick={() => navigate(`/dashboard/form/edit/`)}>
            <Edit color="primary" className={classes.imageCardButtons} />
            <Typography variant="h4" color="primary" align="center">
                Edit Field
            </Typography>
            </Card>
            </Grid>
        

            <Grid item alignItems="center" justify="center" spacing={8}>
            <Card className={classes.cardButtons} elevation={3} align="center" onClick={() => navigate(`/dashboard/form/delete/`)}>
            <Delete color="error" className={classes.imageCardButtons} />
            <Typography variant="h4" color="error" align="center">
                Delete Field
            </Typography>
            </Card>
            </Grid>


        </Grid> 
        </Grid>
        
        </Grid>
        </Grid>
           
        </>
        
    )
};

export default FormManagementPanel;