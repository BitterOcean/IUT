import React,{useState, useEffect} from 'react';
import { useNavigate, Redirect, useParams } from 'react-router-dom';
import {Button, Grid, Card, Typography, Divider,List, TextField} from '@material-ui/core';
import Drawer from './Drawer';
import {makeStyles} from '@material-ui/core/styles';
import PayIcon from './images/PayslipManagement1.png';
import Green from '@material-ui/core/colors/green';
import Background from './images/Picture2.png';
import DeleteFieldimg from './images/DeleteFieldimg.png';
import AddSign from './images/AddSign.png';
import MenuItem from '@material-ui/core/MenuItem';
import CurrentForm from './CurrentForm';
import ConfirmModal from './ConfirmModal';
import StatusModal from './StatusModal';


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

    FillContainer:{
        width: "25%",
        height: "70%",
        backgroundColor:"white",
        borderRadius: 20,
        

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
          width:450,
          height:520,
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
    },
    item:{
        width: "100%",
    },
}))



const DeleteField = () => {
    const props = useParams();
    const classes = useStyles();
    const navigate = useNavigate();
    const [error,setError] = useState("");
    const [data, setData] = useState({});
    const [target,setTarget]=useState('');
    const token=localStorage.getItem("token");
    const id=localStorage.getItem("id");
    const [selectedVal,setSelectedVal]=useState();


    const [showConfirmModal,setshowConfirmModal] = useState(false);
    const [showStatusModal,setShowStatusModal] = useState(false);
    const [status,setStatus] = useState(false);
    

    const [selectedName,setSelectedName] = useState("");

    const handleClose =() => {
      setshowConfirmModal(false);
    }
    const handleOpen = () => {
      setshowConfirmModal(true);
    }

    const handleCloseStatus =() => {
      setShowStatusModal(false);
    }
    const handleOpenStatus = () => {
      setShowStatusModal(true);
    }

    

  const onDeleteClick = () => {


      fetch(`http://127.0.0.1:8000/deletefield/${selectedVal}/${token}/${id}/`)
      .then(response => {
        return response.json();
      }).then(function (response){
        setStatus(response.status);
        });
        handleClose();
        handleOpenStatus();
        setTimeout(()=>{
        handleCloseStatus();
      },3000);
    }


     
    return (
        <>
            <Drawer />
            <ConfirmModal 
          onClose={handleClose} 
          open={showConfirmModal}
          handleSubmit={onDeleteClick} 
          content="Are you sure you want to Delete?" 

        />
        <StatusModal
            onClose={handleCloseStatus} 
            open={showStatusModal} 
            content={status===200 ? "Deletion was successfull" : "Deletion has Failed"} 
            status={status}
        />

            <Grid container alignItems="center" justify="center" className={classes.container}>
            <Grid item container spacing={5} alignItems="center" className={classes.innerContainer}>
                <Grid item>
                <img src={DeleteFieldimg} className={classes.imageStyle} />
                <Typography variant="h4" color="textPrimary" align="center">
                    Field Deletion
                </Typography>
                </Grid>
            <Divider orientation="vertical" flexItem/>
            
            <Grid item>
            <CurrentForm 
              isButton={true} 
              setSelectedVal={setSelectedVal} 
              setSelectedName={setSelectedName}
              setField={()=>{}}
              />
            </Grid>
   
            <Grid item
            container       
            direction="column"
            className={classes.FillContainer}
            justify="center"
            spacing={3} 
            alignItems="center"
            >
            <Grid item>
              <Typography variant="body2" color="primary">
                {`Selected Field : ${selectedName}`}
              </Typography>
            </Grid>
            <Grid item>
                <Button 
                  variant="contained"
                  color="primary"
                  onClick={handleOpen}
                  size="large"
                >
                delete
                </Button>
            </Grid>

            </Grid>

            

            </Grid>
            </Grid>

           
        </>
        
    )
};

export default DeleteField;
