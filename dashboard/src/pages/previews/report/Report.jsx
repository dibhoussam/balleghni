import React from 'react'
import './report.css';
import PermIdentityIcon from '@mui/icons-material/PermIdentity';
import { Link } from 'react-router-dom';
import { useEffect } from 'react';
import { useParams } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { getReport, updatedReport, updateReport } from '../../../redux/actions/reportsActions';
import FlagCircleIcon from '@mui/icons-material/FlagCircle';
import CircularProgress from '@mui/material/CircularProgress';
import HomeIcon from '@mui/icons-material/Home';
import FmdGoodIcon from '@mui/icons-material/FmdGood';
import Chip from '@mui/material/Chip';
import Avatar from '@mui/material/Avatar';
import Button from '@mui/material/Button';
import TaskAltIcon from '@mui/icons-material/TaskAlt';
import DisabledByDefaultIcon from '@mui/icons-material/DisabledByDefault';
import HourglassBottomIcon from '@mui/icons-material/HourglassBottom';
import RotateLeftIcon from '@mui/icons-material/RotateLeft';

import ImageList from '@mui/material/ImageList';
import ImageListItem from '@mui/material/ImageListItem';
import Backdrop from '@mui/material/Backdrop';

import TextField from '@mui/material/TextField';
import Dialog from '@mui/material/Dialog';
import DialogActions from '@mui/material/DialogActions';
import DialogContent from '@mui/material/DialogContent';
import DialogContentText from '@mui/material/DialogContentText';
import DialogTitle from '@mui/material/DialogTitle';



export default function Report() {
  const [open, setOpen] = React.useState(false);
 // const status = ["En attente", "Rejete", "En cours", "resolu"]
  const status = [
                  {
                    status :"En attente",
                    src : "https://cdn-icons-png.flaticon.com/128/483/483610.png"
                  },
                  {
                    status :"En cours",
                    src : "https://cdn-icons-png.flaticon.com/128/7187/7187920.png"
                  },
                  {
                    status :"Rejete",
                    src : "https://cdn-icons-png.flaticon.com/128/753/753345.png"
                  },
                  {
                    status :"resolu",
                    src : "https://cdn-icons.flaticon.com/png/128/1709/premium/1709977.png?token=exp=1649793349~hmac=37b06862f9d5d779d0cceeea69e886d7"
                  }
                  ]
  const dispatch = useDispatch();
  let report = useSelector(state => state.allreports.report);
  const access = useSelector(state => state.user.user.access_token);
  const id = useParams().reportId
  let [image, setImage] = React.useState("");
  let [reportState, setReportState] = React.useState(0);

  //////////// DIALOG /////////////////////////
  
  const [openDialog, setOpenDialog] = React.useState(false);
  let commentaire = "";


  const handleClickOpen = () => {
    setOpenDialog(true);
  };

  const handleCloseDialog = () => {
    setOpenDialog(false);
  };

  //////////// DIALOG /////////////////////////




  const handleClose = () => {
    setOpen(false);
  };
  const handleToggle = (image) => {
    setImage(image); setOpen(!open);
  };

  useEffect(() => {
    dispatch(getReport(access, id))
    setReportState(report.global_status)
  }, [])

  console.log(report);
  console.log(reportState);

  const handleChange = (e) => {
    const value = e.target.value
    if (e.target.name === "commentaire") {
      commentaire = value
      console.log(commentaire);
    }else{
      setReportState(value)
    }
    
    
  }

  const handleSubmit = () => {
    console.log(reportState);
    const data = {
      global_status: reportState,
      comment : commentaire
    }
    dispatch(updateReport(access, id, data))
    //window.location.reload()
  }

  const a  = "https://maps.google.com/maps?q="+report.latitude+","+report.longitude+"&output=embed";
  console.log(a);


  return (
    <div className="user">
      {
        (report === {}) ? (
          <>
            <div style={{ textAlign: "center", height: "800px" }}>
              <CircularProgress style={{ marginTop: "400px" }} />
            </div>
          </>
        ) : (
          report.incident_types === undefined ? (
            <>
              <div style={{ textAlign: "center", height: "800px" }}>
                <CircularProgress style={{ marginTop: "400px" }} />
              </div>
            </>
          ) : (
            <>
              <div className="userTitleContainer">
                <h1 className="userTitle">Edit Report</h1>
                
              </div>
              <div className="userContainer">
                <div className="userShow">
                  <div className="userShowTop">
                    <img src={report.incident_types[0].authoritie.logo} alt="" className="userShowImg" />
                    <div className="userShowTopTitle">
                      <span className="userShowName">
                        {report.incident_types[0].authoritie.name}
                      </span>
                    </div>
                  </div>
                  <div className="userShowBottom">
                    <span className="userShowTitle">Status</span>
                    <div className="userShowInfo">
                      <Chip
                        avatar={<Avatar alt="Natacha" src={status[report.global_status].src} />}
                        label={status[report.global_status].status}
                        variant="outlined"
                      />
                    </div>
                    <span className="userShowTitle">Description</span>
                    <div className="userShowInfo">
                      <PermIdentityIcon className="userShowIcon" />
                      <span className="userShowInfoTitle">{report.description}</span>
                    </div>
                    <span className="userShowTitle">Adresse</span>
                    <div className="userShowInfo">
                      <HomeIcon className="userShowIcon" />
                      <span className="userShowInfoTitle">{report.location.address} </span>
                    </div>
                    <div className="userShowInfo">
                      <FmdGoodIcon className="userShowIcon" />
                      <span className="userShowInfoTitle"> {report.location.commune.ar_name} </span>
                    </div>
                    <div className="userShowInfo">
                      <FmdGoodIcon className="userShowIcon" />
                      <span className="userShowInfoTitle"> {report.location.daira.ar_name} </span>
                    </div>
                    <div className="userShowInfo">
                      <FmdGoodIcon className="userShowIcon" />
                      <span className="userShowInfoTitle">{report.location.wilaya.ar_name}</span>
                    </div>

                    <span className="userShowTitle">Incidents</span>
                    <div className="userShowInfo">
                      <Chip
                        avatar={<Avatar alt="Natacha" src={report.incident_types[0].icon} />}
                        label={report.incident_types[0].title}
                        variant="outlined"
                      />
                    </div>

                    <span className="userShowTitle">Images</span>
                    <div className="userShowInfo">
                      <ImageList sx={{ width: 500, height: 200 }} cols={3} rowHeight={164}>
                        {report.images.map((item) => (
                          <>
                            <ImageListItem key={Math.random()}>
                              <img
                                src={`${item.image}?w=164&h=164&fit=crop&auto=format`}
                                srcSet={`${item.image}?w=164&h=164&fit=crop&auto=format&dpr=2 2x`}
                                alt={item.thumbnail}
                                loading="lazy"
                                style={{ cursor: "pointer" }}
                                onClick={() => { setImage(item.image); setOpen(!open); }}
                              />
                            </ImageListItem>
                            <Backdrop
                              sx={{ color: '#fff', zIndex: (theme) => theme.zIndex.drawer + 1 }}
                              open={open}
                              onClick={handleClose}
                            >
                              <img
                                src={image}
                                alt={item.thumbnail}
                                style={{ padding: "50px" }}
                              />
                            </Backdrop>
                          </>

                        ))}
                      </ImageList>
                    </div>




                  </div>
                </div>
                <div className="reportUpdate">
                  <span className="userUpdateTitle">Edit</span>
                  <form className="reportUpdateForm">
                    <div style={{ textAlign: "center", display: "block", marginLeft: "auto", marginRight: "auto" }}>
                      <div className="wrapper">
                        {
                          report.global_status === 0 &&
                          <input
                            type="radio"
                            name="select"
                            id="option-1"
                            value={0}
                            defaultChecked
                            onChange={handleChange}
                          />
                        }
                        {
                          report.global_status !== 0 &&
                          <input
                            type="radio"
                            name="select"
                            id="option-1"
                            value={0}
                            onChange={handleChange}
                          />
                        }
                        {
                          report.global_status === 1 &&
                          <input
                            type="radio"
                            name="select"
                            id="option-2"
                            value={1}
                            defaultChecked
                            onChange={handleChange}
                          />
                        }
                        {
                          report.global_status !== 1 &&
                          <input
                            type="radio"
                            name="select"
                            id="option-2"
                            value={1}

                            onChange={handleChange}
                          />
                        }
                        {
                          report.global_status === 2 &&
                          <input
                            type="radio"
                            name="select"
                            id="option-3"
                            value={2}
                            defaultChecked
                            onChange={handleChange}
                          />
                        }
                        {
                          report.global_status !== 2 &&
                          <input
                            type="radio"
                            name="select"
                            id="option-3"
                            value={2}
                            onChange={handleChange}
                          />
                        }
                        {
                          report.global_status === 3 &&
                          <input
                            type="radio"
                            name="select"
                            id="option-4"
                            value={3}
                            defaultChecked
                            onChange={handleChange}
                          />
                        }
                        {
                          report.global_status !== 3 &&
                          <input
                            type="radio"
                            name="select"
                            id="option-4"
                            value={3}
                            onChange={handleChange}
                          />
                        }
                        <label htmlFor="option-1" className="option option-1">
                          <HourglassBottomIcon />
                          <span>En attente</span>

                        </label>

                        <label htmlFor="option-2" className="option option-2">
                          <RotateLeftIcon />
                          <span>En cours</span>
                        </label>
                        <label htmlFor="option-4" className="option option-4">
                          <TaskAltIcon />
                          <span>Resolu</span>
                        </label>
                        <label htmlFor="option-3" className="option option-3" style={{ display: 1 }}>
                          <DisabledByDefaultIcon />
                          <span>Rejete</span>
                        </label>
                      </div>

                    </div>

                        <Dialog open={openDialog} onClose={handleClose}>
                          <DialogTitle>Commentaire</DialogTitle>
                          <DialogContent>
                            <DialogContentText>
                             Décrire un commentaire associé a l'etat de rapport
                            </DialogContentText>
                            <TextField
                              autoFocus
                              margin="dense"
                              id="name"
                              label="Commentaire"
                              type="text"
                              name="commentaire"
                              fullWidth
                              variant="standard"
                              onChange={handleChange}
                            />
                          </DialogContent>
                          <DialogActions>
                            <Button onClick={handleCloseDialog}>Annuler</Button>
                            <Button onClick={handleSubmit}>Envoyer</Button>
                          </DialogActions>
                        </Dialog>

                  </form>
                  <div style={{ paddingBottom: "20px", textAlign: "center", display: "block", marginLeft: "auto", marginRight: "auto", marginTop: "20px" }}>
                    <Button variant="contained" onClick={handleClickOpen}>Save</Button>
                  </div>

                  <span className="userShowTitle">Localisation</span>
                  
                  <div className="userShowInfo" style={{ border: "solid 1px black", width: "100% ", height: "400px " }}>
                    <iframe src={a} width="100%" height="100%" style={{ border: 0 }} allowFullScreen loading="lazy" referrerPolicy="no-referrer-when-downgrade" />
                  </div>
                </div>
              </div>
            </>))}
    </div>
  )
}
