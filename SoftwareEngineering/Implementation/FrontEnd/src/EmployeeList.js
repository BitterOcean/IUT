import React, { useEffect, useState } from 'react';
import { useNavigate, Redirect, useParams } from 'react-router-dom';
import clsx from 'clsx';
import { makeStyles, useTheme } from '@material-ui/core/styles';
import {Card,List,ListItem,ListItemAvatar,ListItemText,Typography, Grid, Avatar, Divider} from '@material-ui/core' 
import AccountCircle from 'mdi-material-ui/AccountCircle';



const drawerWidth = 300;

const useStyles = makeStyles((theme) => ({
  cardButtons:{
    [theme.breakpoints.down('sm')]: {
        width: 700,
        height:500,
      },
      [theme.breakpoints.up('md')]: {
        width: 700,
        height:500,
      },
      [theme.breakpoints.up('lg')]: {
        width: 700,
        height:500,
      },
      backgroundColor: theme.palette.common.white,
      padding:20,
      borderRadius:20,
  },
  listItem:{
    width: '100%',
  }
}));

const EmployeeList = ({url}) => {
  const props = useParams();
  const classes = useStyles();
  const [employees,setEmployees] = useState([]);
  const navigate = useNavigate();
  const token = localStorage.getItem("token");
  const id = localStorage.getItem("id");

  useEffect(()=>{
    fetch(`http://127.0.0.1:8000/employeelist/${token}/${id}/`)
    .then(response => {
      return response.json();
    }).then(response=>{
      if(response.status === 200){
        const employeeArray = Object.keys(response.employees).map((key) => response.employees[key]);
        setEmployees(employeeArray);
      }    
    })
  },[]);
  return (
    <>
        <Card className={classes.cardButtons} elevation={3} align="center">
        <Typography variant="h4" color="textPrimary" align="center">
            Employee List
        </Typography>
        <Grid container >
          <Grid item className={classes.listItem}>
        <List>
            {
              employees.map(employee => (
                <>
                <ListItem button onClick={()=> navigate(`${url}${props.date}/${employee.PersonnelCode}/`)}>
                  <ListItemAvatar>
                    <Avatar>
                      <AccountCircle />
                    </Avatar>
                  </ListItemAvatar>
                  <ListItemText 
                    primary={<Typography variant="h5">{`${employee.Name} ${employee.LastName}`}</Typography>}  
                    secondary={employee.PersonnelCode} />
                </ListItem>
                <Divider />
                </>
              ))
            }
        </List>
          </Grid>
        </Grid>
        </Card>
    </>
  );
}
export default EmployeeList;
