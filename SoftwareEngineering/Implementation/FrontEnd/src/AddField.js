import React,{useState, useEffect, useCallback} from 'react';
import { useNavigate, Redirect, useParams } from 'react-router-dom';
import {Button, Grid, Card, Typography, Divider,ListItemAvatar, TextField,Avatar,List,ListItem} from '@material-ui/core';
import Drawer from './Drawer';
import {makeStyles} from '@material-ui/core/styles';
import Green from '@material-ui/core/colors/green';
import Background from './images/Picture2.png';
import AddFieldimg from './images/AddFieldimg.png';
import MenuItem from '@material-ui/core/MenuItem';
import CurrentForm from './CurrentForm';
import ConfirmModal from './ConfirmModal';
import StatusModal from './StatusModal';

const Types = [
    {
      value: '1',
      label: 'Integer',
    },
    {
      value: '3',
      label: 'Money',
    },
    {
      value: '2',
      label: 'String',
    },
  ];


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
    imageStyle: {
        width: 300,
        height: 400,
        marginBottom: 60,
    },
    item:{
        width: "100%",
    },
}))

const AddField = () => {
    const props = useParams();
    const classes = useStyles();
    const navigate = useNavigate();
    const [fieldName, setFieldName] = useState('');
    const [type, setType] = useState('');
    const [error,setError] = useState("");
    const token=localStorage.getItem("token");
    const id=localStorage.getItem("id");

    const [showConfirmModal,setshowConfirmModal] = useState(false);

    const [showStatusModal,setShowStatusModal] = useState(false);
    const [status,setStatus] = useState(false);
    const [isSubmitValid, setIsSubmitValid] = useState(true);

    const [fields,setFields] = useState([]);

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
    },[])

    const handleClose =() => {
      setshowConfirmModal(false);
    }
    const handleOpen = () => {
      fields.map((field,index)=> {
        if(fieldName === field.name){
         setError("This name already exists");
         setIsSubmitValid(false);
        }
       });
      setshowConfirmModal(true);
    }

    const handleCloseStatus =() => {
      setShowStatusModal(false);
    }
    const handleOpenStatus = () => {
      setShowStatusModal(true);
    }

    const onAddClick = () => {
        if(isSubmitValid){
        fetch(`http://127.0.0.1:8000/addfield/${fieldName}/${type}/${token}/${id}/`)
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
      else{
        handleClose();
        setIsSubmitValid(true);
      }
      }



    return (
        <>
            <Drawer />

          <ConfirmModal 
          onClose={handleClose} 
          open={showConfirmModal}
          handleSubmit={onAddClick} 
          content="Are you sure you want to Add?" 

        />
        <StatusModal
            onClose={handleCloseStatus} 
            open={showStatusModal} 
            content={status===200 ? "Addition was successfull" : "Addition has Failed"} 
            status={status}
        />

            <Grid container alignItems="center" justify="center" className={classes.container}>
            <Grid item container spacing={5} alignItems="center" className={classes.innerContainer}>
                <Grid item>
                <img src={AddFieldimg} className={classes.imageStyle} />
                <Typography variant="h4" color="textPrimary" align="center">
                    Field Addition
                </Typography>
                </Grid>
            <Divider orientation="vertical" flexItem/>
            
            <Grid item>
            <CurrentForm isButton={false}/>
            
            </Grid>



            <Grid item
            container       
            direction="column"
            className={classes.FillContainer}
            justify="center"
            spacing={3} 
            alignItems="center"
            >
                <Grid item className={classes.item}>
                <TextField
                    variant="outlined"
                    label="Field Name"
                    autoFocus
                    fullWidth
                    value={fieldName}
                    onChange={(e)=>setFieldName(e.target.value)}
                    required
                />
            </Grid>

            <Grid item  className={classes.item}>
                <TextField
                    variant="outlined"
                    select
                    label="Type"
                    fullWidth
                    value={type}
                    onChange={(e)=>setType(e.target.value)}
                    required
                >
                    {Types.map((option) => (
                        <MenuItem key={option.value} value={option.value}>
                        {option.label}
                        </MenuItem>
                    ))}
                </TextField>
            </Grid>

            <Grid item>
              <Typography variant="body2" color="error">
                  {error}
              </Typography>
            </Grid>


            <Grid item>
                <Button 
                variant="contained"
                color="primary"
                onClick={handleOpen}
                size="large"
                >
                add
                </Button>
            </Grid>



            </Grid>

            

            </Grid>
            </Grid>

           
        </>
        
    )
};

export default AddField;
