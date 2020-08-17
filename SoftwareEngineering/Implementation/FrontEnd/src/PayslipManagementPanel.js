import React,{useState} from 'react';
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
            width:150,
            height:200,
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

const PayslipManagementPanel = () => {
    const props = useParams();
    const classes = useStyles();
    const navigate = useNavigate();
    const [year,setYear] = useState();
    const [month,setMonth] = useState();

    const [error,setError] = useState(false);

    const handleError = (content) => {
        return (
            <Typography variant="body2" color="error">
                {content}
             </Typography>
        )
    }

    const handleNavigate = (url) => {
        if(year && month && (year >= 1370 && year?.length===4) && (month <= 12 && month>=1)){
            navigate(url);
        }
        else{
            setError("All fields are required");
        }
    }

    return (
        <>
        <Drawer />
        <Grid container alignItems="center" justify="center" className={classes.container}>
        <Grid item container spacing={5} alignItems="center" className={classes.innerContainer}>
        <Grid item>
            <img src={PayIcon} className={classes.imageStyle} />
            <Typography variant="h4" color="textPrimary" align="center">
                Payslip Management
            </Typography>
        </Grid>
        <Divider orientation="vertical" flexItem/>


        <Grid container item direction="column" className={classes.textFieldContainer} spacing={10}>
               <Grid container item justify="center" spacing={5}>
                <Grid item className={classes.griditemTextField}>
                    <TextField
                      type="number"
                      pattern="[0-9]{2,4}"
                      variant="outlined"
                      label="Year"
                      required
                      placeholder="Year"
                      fullWidth
                      value={year}
                      onChange={(e)=>setYear(e.target.value)}
                      helperText={(year<1370 || year?.length>4) ? handleError("invalid range") : ""}
                    />
                </Grid>
                <Grid item className={classes.griditemTextField}>
                    <TextField
                      type="number"
                      pattern="[0-9]{1,2}"
                      variant="outlined"
                      label="Month"
                      required
                      placeholder="Month"
                      fullWidth
                      className={classes.textField}
                      value={month}
                      onChange={(e)=>setMonth(e.target.value)}
                      helperText={(month> 12 || month<1) ? handleError("invalid range") : ""}
                      />
                </Grid>
            </Grid>
            <Grid container item justify="space-around" spacing={5}>
            <Grid item alignItems="center">
        <Card className={classes.cardButtons} elevation={3} align="center" onClick={() =>handleNavigate(`/dashboard/payslip/add/${year}:${month}`)}>
            <Add className={`${classes.imageCardButtons} ${classes.addCard}`} />
            <Typography variant="h4" className={classes.addCard} align="center">
                Add
            </Typography>
        </Card>
        </Grid>
        <Grid item alignItems="center" justify="center" spacing={8}>
        <Card className={classes.cardButtons} elevation={3} align="center" onClick={() => handleNavigate(`/dashboard/payslip/edit/${year}:${month}`)}>
            <Edit color="primary" className={classes.imageCardButtons} />
            <Typography variant="h4" color="primary" align="center">
                Edit
            </Typography>
        </Card>
        </Grid>

        <Grid item alignItems="center" justify="center" spacing={8}>
        <Card className={classes.cardButtons} elevation={3} align="center" onClick={() => handleNavigate(`/dashboard/payslip/delete/${year}:${month}`)}>
            <Delete color="error" className={classes.imageCardButtons} />
            <Typography variant="h4" color="error" align="center">
                Delete
            </Typography>
        </Card>
        </Grid>
            </Grid>
            <Grid item>
                <Typography variant="body2" color="error">
                    {error}
                </Typography>
            </Grid>
        </Grid>
        

        </Grid>
        </Grid>
        </>
    )
};

export default PayslipManagementPanel;