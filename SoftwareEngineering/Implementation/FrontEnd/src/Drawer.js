import React from 'react';
import clsx from 'clsx';
import { makeStyles, useTheme } from '@material-ui/core/styles';
import Drawer from '@material-ui/core/Drawer';
import AppBar from '@material-ui/core/AppBar';
import Toolbar from '@material-ui/core/Toolbar';
import List from '@material-ui/core/List';
import CssBaseline from '@material-ui/core/CssBaseline';
import Typography from '@material-ui/core/Typography';
import Divider from '@material-ui/core/Divider';
import IconButton from '@material-ui/core/IconButton';
import MenuIcon from 'mdi-material-ui/Menu';
import ChevronLeftIcon from 'mdi-material-ui/ChevronLeft';
import ChevronRightIcon from 'mdi-material-ui/ChevronRight';
import ListItem from '@material-ui/core/ListItem';
import ListItemIcon from '@material-ui/core/ListItemIcon';
import ListItemText from '@material-ui/core/ListItemText';
import AccountCircle from 'mdi-material-ui/AccountCircle';
import AccountMultiple from 'mdi-material-ui/AccountMultiple';
import AccountMultiplePlus from 'mdi-material-ui/AccountMultiplePlus';
import FilePlus from 'mdi-material-ui/FilePlus';                                                                                  
import PlusBoxMultiple from 'mdi-material-ui/PlusBoxMultiple';
import FormSelect from 'mdi-material-ui/FormSelect';
import ChartBar from 'mdi-material-ui/ChartBar';
import ShowPayslipIcon from 'mdi-material-ui/CreditCardOutline'

// import { Navigate } from 'react-router';
//import { useNavigation } from '@react-navigation/native';
import { useNavigate, Redirect, useParams } from 'react-router-dom';                                                                                                                                                                                                                                                
 

const drawerWidth = 300;

const useStyles = makeStyles((theme) => ({
  root: {
    display: 'flex',
  },
  appBar: {
    zIndex: theme.zIndex.drawer + 1,
    transition: theme.transitions.create(['width', 'margin'], {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen,
    }),
  },
  appBarShift: {
    marginLeft: drawerWidth,
    width: `calc(100% - ${drawerWidth}px)`,
    transition: theme.transitions.create(['width', 'margin'], {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.enteringScreen,
    }),
  },
  menuButton: {
    marginRight: 36,
  },
  hide: {
    display: 'none',
  },
  drawer: {
    width: drawerWidth,
    flexShrink: 0,
    whiteSpace: 'nowrap',
  },
  drawerOpen: {
    width: drawerWidth,
    transition: theme.transitions.create('width', {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.enteringScreen,
    }),
  },
  drawerClose: {
    transition: theme.transitions.create('width', {
      easing: theme.transitions.easing.sharp,
      duration: theme.transitions.duration.leavingScreen,
    }),
    overflowX: 'hidden',
    width: theme.spacing(7) + 1,
    [theme.breakpoints.up('sm')]: {
      width: theme.spacing(9) + 1,
    },
  },
  background:{
    backgroundColor:theme.palette.primary.main,
  },
  icons:{
    color:theme.palette.common.white,
    fontSize: 50,
    marginTop: 20,
  },
  listItemText:{
    color: theme.palette.common.white,
  }

}));


export default function MiniDrawer() {
  const classes = useStyles();
  const theme = useTheme();
  const [open, setOpen] = React.useState(false);
  const navigate =useNavigate();

  const handleDrawerOpen = () => {
    setOpen(true);
  };

  const handleDrawerClose = () => {
    setOpen(false);
  };

  return (
    <div className={classes.root}>
      <Drawer
        variant="permanent"
        className={clsx(classes.drawer, {
          [classes.drawerOpen]: open,
          [classes.drawerClose]: !open,
        })}
        classes={{
          paper: clsx(classes.background,{
            [classes.drawerOpen]: open,
            [classes.drawerClose]: !open,
          }),
        }}
        onMouseEnter={handleDrawerOpen}
        onMouseLeave={handleDrawerClose}
      >
        <List>

            <ListItem button onClick={()=> navigate('/dashboard/')}>
              <ListItemIcon>
                <AccountCircle className={classes.icons}/>
              </ListItemIcon>
              <ListItemText className={classes.listItemText} primary="Your Panel" /> 
            </ListItem>

            <ListItem button>
            <ListItemIcon>
                <ShowPayslipIcon className={classes.icons}/>
              </ListItemIcon>
              <ListItemText className={classes.listItemText} primary="Visit Payslip" />
            </ListItem>
            <ListItem button>
            <ListItemIcon>
                <ChartBar className={classes.icons}/>
              </ListItemIcon>
              <ListItemText className={classes.listItemText} primary="Payslip Report" />
            </ListItem>

            <ListItem button>
              <ListItemIcon>
                <AccountMultiple className={classes.icons}/>
              </ListItemIcon>
              <ListItemText className={classes.listItemText} primary="Employee Management" />
            </ListItem>

            <ListItem button onClick={()=> navigate('/dashboard/payslip/')}>
              <ListItemIcon>
                <FilePlus className={classes.icons}/>
              </ListItemIcon>
              <ListItemText className={classes.listItemText} primary="Payslip Management" />
            </ListItem>

            <ListItem button onClick={()=> navigate('/dashboard/form/')}>
              <ListItemIcon>
                <FormSelect className={classes.icons}/>
              </ListItemIcon>
              <ListItemText className={classes.listItemText} primary="Form Management"/>
            </ListItem>

        </List>
      </Drawer>
    </div>
  );
}
