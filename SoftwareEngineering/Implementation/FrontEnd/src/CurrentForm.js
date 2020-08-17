import React,{useEffect, useState} from 'react';
import { BrowserRouter, Route, Routes } from 'react-router-dom';

import Login from './Login';
import NavigationMenu from './NavigationMenu';
import { ListItemAvatar,Avatar,List,ListItem,ListItemText,Divider,Card,Grid,Typography} from '@material-ui/core';
import { createMuiTheme,makeStyles } from '@material-ui/core/styles';


const useStyles = makeStyles(theme=>({
  
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
        width:500,
        height:540,
      },
    overflowY: 'scroll',
    backgroundColor: theme.palette.common.white,
    padding:20,
},
  listItem:{
    width: '100%',
  },

}))

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

const CurrentForm = ({isButton,setSelectedVal,setSelectedName, setField}) => {
    const classes = useStyles();
    const token=localStorage.getItem("token");
    const id=localStorage.getItem("id");
    const [fields,setFields]=useState([]);

    useEffect(()=>{
        fetch(`http://127.0.0.1:8000/showform/${token}/${id}/`)
        .then(response => {
          return response.json();
        }).then(response=>{
          if(response.status === 200){
            const fieldArray = Object.keys(response.fields).map((key) => response.fields[key]);
            setFields(fieldArray)
          }
          
        })
      },[fields]);

     const handleSelect = (field,index) => {
          setSelectedVal(index);
          setSelectedName(field.name);
          setField(field);
      }

  return (
    <Card className={classes.cardStyle} elevation={3} align="center">
      <Typography variant="h4" color="textPrimary" align="center">
          Current Form
      </Typography>
      
      <Grid container >
        <Grid item className={classes.listItem}>
        <List>
            {fields.map((field,index) => (                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
                <>
                <ListItem button={isButton} onClick={()=>isButton ? handleSelect(field,index): null}>
                  <ListItemText 
                    primary={field.name}
                    secondary={Types?.index?.label} />
                </ListItem>
                <Divider />
                </>
              ))
            }
        </List>
        </Grid>
    </Grid>
    </Card>                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
  )
}

export default CurrentForm;
