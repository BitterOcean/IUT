import React, {useState,useEffect} from 'react';
import { useNavigate, Redirect, useParams } from 'react-router-dom';
import axios from 'axios';
import {Box,Button, Grid, Card, Typography, Divider, TextField, Avatar,CardHeader} from '@material-ui/core';
import Drawer from './Drawer';
import {makeStyles} from '@material-ui/core/styles';
import PayIcon from './images/AddPayslipManually.png';
import Green from '@material-ui/core/colors/green';
import Background from './images/Picture2.png';
import AccountCircle from 'mdi-material-ui/AccountCircle';
import ConfirmModal from './ConfirmModal';
import StatusModal from "./StatusModal";

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
            height: 500,
          },
          [theme.breakpoints.up('md')]: {
            width: 700,
            height: 500,
          },
          [theme.breakpoints.up('lg')]: {
            width: 700,
            height: 500,
          },
          backgroundColor: theme.palette.common.white,
          padding:20,
          borderRadius:20,
          overflowY: 'scroll',
          marginBottom: 20,
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
    formContainer:{
        width: '40%',
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

const AddPayslipManualEmployee = () => {
    const props = useParams();
    const classes = useStyles();
    const navigate = useNavigate();
    const token = localStorage.getItem("token");
    const id = localStorage.getItem("id");
    const [fields,setFields] = useState([]);
    const [employeeInfo,setEmployeeInfo] = useState({});
    const [showConfirmModal,setshowConfirmModal] = useState(false);

    const [showStatusModal,setShowStatusModal] = useState(false);
    const [status,setStatus] = useState(false);
    const [state,setState] = useState({});

    const [error, setError] = useState("");
    const [isSubmitValid, setIsSubmitValid] = useState(true);

    const handleClose =() => {
      setshowConfirmModal(false);
    }
    const handleOpen = () => {
      fields.map((field,index)=> {
        if(!state[index]){
         setError("All fields are required");
         setIsSubmitValid(false);
        }
        if((field.type === "1" || field.type === "3") && state[index] && !/^\d*(\.\d+)?$/.test(state[index])){
          setError(`Type of ${field.name} is invalid`);
          setIsSubmitValid(false);
        }
       });
       setshowConfirmModal(true);
    }

    const handleCloseStatus =() => {
      setShowStatusModal(false);
      navigate('/dashboard/payslip/');
    }
    const handleOpenStatus = () => {
      setShowStatusModal(true);
    }


    useEffect(()=>{
        fetch(`http://127.0.0.1:8000/showform/${token}/${id}/`)
        .then(response => {
          return response.json();
        }).then(response=>{
          if(response.status === 200){
            const fieldArray = Object.keys(response.fields).map((key) => response.fields[key]);
            setFields(fieldArray);
          } 
        });

        fetch(`http://127.0.0.1:8000/getemployeeinfo/${props.id}/${token}/${id}/`)
        .then(response => {
          return response.json();
        }).then(response=>{
          if(response.status === 200){
            setEmployeeInfo(response);
          } 
        })
      },[]);
      
     

     const handleSubmit = () => {
      if(isSubmitValid){
       const jsonMessage = {
         id: id,
         token: token,
         EmployeeID: employeeInfo.id,
         Date: props.date,
         JsonData: state,
       };

      const url = 'http://127.0.0.1:8000/addpayslipmanual/?' + Object.keys(jsonMessage).map(function(k) {
        return encodeURIComponent(k) + '=' + (typeof(jsonMessage[k]) === 'object' ? JSON.stringify(jsonMessage[k]) : jsonMessage[k]);
      }).join('&');

      fetch(url)
      .then(function (response) {
        return response.json();
      })
      .then(function (response) {
        setStatus(response.status);
      });
      handleClose();
      handleOpenStatus();
      setTimeout(()=>{
        handleCloseStatus();
        navigate(`/dashboard/payslip/addManual/${props.date}/`);
      },3000);
      }
      else {
          handleClose();
          setIsSubmitValid(true)
      }
    }


    return (
        <>
        <Drawer />
        <ConfirmModal 
          onClose={handleClose} 
          open={showConfirmModal}
          handleSubmit={handleSubmit} 
          content="Are you sure you want to add?" 

        />
        <StatusModal
            onClose={handleCloseStatus} 
            open={showStatusModal} 
            content={status===200 ? "Addition was successfull" : "Addition has Failed"} 
            status={status}
        />
        <Grid container alignItems="center" justify="center" className={classes.container}>
        <Grid item container spacing={8} alignItems="center" className={classes.innerContainer}>
        <Grid item>
            <img src={PayIcon} className={classes.imageStyle} />
            <Typography variant="h4" color="textPrimary" align="center">
                 Manual Payslip Addition
            </Typography>
        </Grid>
        <Divider orientation="vertical" flexItem/>
            <Grid  item >
            <Box clone margin="20px !important">
                <Typography variant="h5" color="primary" marginBottom={4}>
                    {`Selected date : ${props.date.replace(':','.')}`}
                </Typography>
            </Box>
             <Card className={classes.cardButtons} elevation={3}>
             <CardHeader
                  avatar={
                    <Avatar>
                    <AccountCircle />
                    </Avatar> 
                  }
                  title={
                    <Typography variant="h4">
                    {`${employeeInfo.Name} ${employeeInfo.LastName}`}
                    </Typography>
                  }
               />
               
               <Grid container spacing={3} direction="column">
                 {fields.map((field,index)=>(
                   <Grid item>
                      <TextField
                        variant="outlined"
                        label={field.name}
                        autoFocus={field.index===0}
                        fullWidth
                        value={state[index]}
                        onChange={(e)=>setState({...state,[index]:e.target.value})}
                        required
                      />
                    </Grid>
                  ))}
               </Grid>   
               </Card>
               <Grid container spacing={3} justify="center">
               <Grid item container>
                  <Typography variant="body1" color="error">
                      {error}
                  </Typography>
                </Grid>
                 <Grid item>
                 <Button color="primary" variant="contained" onClick={handleOpen}>
                      Confirm
                  </Button>
                 </Grid>
                 </Grid>
            </Grid>
        </Grid>
        </Grid>

        </>
    )
};

export default AddPayslipManualEmployee;