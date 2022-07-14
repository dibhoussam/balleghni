import React from 'react'
import './incident.css';
import PermIdentityIcon from '@mui/icons-material/PermIdentity';
import TextField from '@mui/material/TextField';
import { Link } from 'react-router-dom';
import { useEffect,useState } from 'react';
import { useParams } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { getIncident, removeSelectedIncident, updateIncident } from '../../../redux/actions/incidentsActions';
import V from 'max-validator';
import { useForm } from "react-hook-form";
import Button from '@mui/material/Button';
import { useHistory } from 'react-router-dom';
import CircularProgress from '@mui/material/CircularProgress';
import TitleIcon from '@mui/icons-material/Title';
import EnergySavingsLeafIcon from '@mui/icons-material/EnergySavingsLeaf';
import TextSnippetIcon from '@mui/icons-material/TextSnippet';


export default function Incident() {

  const initialState = {
    valid: false,
    text: ""
  }

  let [globalState, setGlobalState] = useState({})
  const dispatch = useDispatch();
  const history = useHistory()
  let userInfo = useSelector(state => state.user.userInfo);
  let access = useSelector(state => state.user.user.access_token);
  let incident = useSelector(state => state.allIncidents.incident);
  let { register, handleSubmit } = useForm();
  let id = useParams().incidentId

  useEffect(() => {
    dispatch(removeSelectedIncident())
    dispatch(getIncident(access, id))
  }, []) 

  useEffect(() => {
    load()
    console.log("page refreshed !!!!");
  }, [incident])

  const load = () => {
    setGlobalState({
      ...globalState,
      "incident": incident,
      "imageState": incident.icon,
      "imageUpdated": false,
      "imagefile": "",
    })
  }
  console.log(globalState);
  console.log(incident);
  

  let validationScheme = {
    title: 'required|string|max:255',
    authoritie_id : 'required|numeric',
    slug: 'required|alpha_dash',
    description: 'required|string|max:255',
  }
  /* ############################## IMAGE UPLOAD ################################################*/
  const handleChangeImage = (e) => {
    setGlobalState({
      ...globalState,
      ["imageState"]: URL.createObjectURL(e.target.files[0]),
      ["imageUpdated"]: true,
      ["imagefile"]: e.target.files[0]
    })
  }
  /* ############################## IMAGE UPLOAD ###########################################*/
  
  /* errors */
  
  const [titleError, setTitleError] = useState(initialState)
  const [descriptionError, setDescriptionError] = useState(initialState)
  const [slugError, setSlugError] = useState(initialState)
  


 
 

  const onSubmit = (data) => {
    if (userInfo.hasOwnProperty("authoritie")) {
      data.authoritie_id = Number(userInfo.authoritie)
    } else if (userInfo.hasOwnProperty("wilaya")) {
      data.authoritie_id = Number(userInfo.wilaya)
    }
      

    console.log(data);
    let result = V.validate(data, validationScheme)
    console.log(result);
    if (result.hasError) {
      //console.log(result)

      if (result.isError('title'))
        setTitleError({ ...titleError, ["text"]: result.getError('title'), ["valid"]: true })
      else
        setTitleError(initialState)

      if (result.isError('description'))
        setDescriptionError({ ...descriptionError, ["text"]: result.getError('description'), ["valid"]: true })
      else
        setDescriptionError(initialState)

      if (result.isError('slug'))
        setSlugError({ ...slugError, ["text"]: result.getError('slug'), ["valid"]: true })
      else
        setSlugError(initialState)
    } else //no errors
    {
      data.icon = incident.icon
      dispatch(updateIncident(access,id, data, globalState.imagefile, globalState.imageUpdated))
      history.push("/incidents")
    }
  }

  

  //console.log(incident);

  return (
    <div className="user">
      {
         Object.keys(globalState).length === 0  ? (
          <>
            <div style={{ textAlign: "center", height: "800px" }}>
              <CircularProgress style={{ marginTop: "400px" }} />
            </div>
          </>
        ) : (
          Object.keys(globalState.incident).length === 0  ? (
            <>
              <div style={{ textAlign: "center", height: "800px" }}>
                <CircularProgress style={{ marginTop: "400px" }} />
              </div>
            </>
          ) : (
          <>
      <div className="userTitleContainer">
        <h1 className="userTitle">Edit Incident</h1>
        <Link to="/newIncident">
          <button className="userAddButton">Ajouter</button>
        </Link>
      </div>
      <div className="userContainer">
        <div className="userShow">
          <div className="userShowTop">

          <img src={globalState.incident.authoritie.logo} alt="logo" className="incidentShowImg" />
            <div className="userShowTopTitle">
              <span className="incidentShowName">
                {globalState.incident.authoritie.name} 
              </span>
            </div>
          </div>
          <div className="userShowBottom">
            <span className="userShowTitle">Title</span>
            <div className="userShowInfo">
              <TitleIcon className="userShowIcon" />
              <span className="userShowInfoTitle">{globalState.incident.title}</span>
            </div>
            <span className="userShowTitle">Slug</span>
            <div className="userShowInfo">
              <EnergySavingsLeafIcon className="userShowIcon" />
              <span className="userShowInfoTitle">{globalState.incident.slug}</span>
            </div>
            <span className="userShowTitle">Description</span>
            <div className="userShowInfo">
              <TextSnippetIcon className="userShowIcon" />
              <span className="userShowInfoTitle">{globalState.incident.description}</span>
            </div>
          </div>
        </div>
        <div className="userUpdate">
          <span className="userUpdateTitle">Edit</span>
          <form className="updateAuthoritieForm" onSubmit={handleSubmit(onSubmit)}>
            <div className="newIncidentLeft">

              <div className="newIncidentItem">
                {
                  userInfo.hasOwnProperty("wilaya") &&
                  <>
                    <label>authoritie</label>
                    <input type="text" placeholder={userInfo.wilaya} id="" disabled />
                  </>
                }
              </div>
            

              <div className="newIncidentItem">
                <TextField
                  {...register("title")}
                  id="outlined-basic"
                  label="Title"
                  variant="outlined"
                  size='large'
                  name='title'
                  error={titleError.valid}
                  helperText={titleError.text}
                  
                />
              </div>
              <div className="newIncidentItem">
                <TextField
                  {...register("slug")}
                  id="outlined-basic"
                  label="Slug"
                  variant="outlined"
                  size='large'
                  name='slug'
                  error={slugError.valid}
                  helperText={slugError.text}
                  
                />
              </div>
              <div className="newIncidentItem">
                <TextField
                  {...register("description")}
                  id="outlined-multiline-static"
                  label="Description"
                  multiline
                  rows={7}
                  name='description'
                  error={descriptionError.valid}
                  helperText={descriptionError.text}
                  
                />
              </div>


              <button className="newIncidentButton" >Create</button>
            </div>
            <div className="newIncidentRight">
              <label for="file">Image</label>
              <div className="newIncidentUpload">
                
                <img src={globalState.imageState} alt="" className="newIncidentUploadImg" />
                <label for="file" style={{ cursor: "pointer", padding: "20px" }}>
                  <Button variant="contained" component="span">
                    Upload
                  </Button>
                </label>
                <input
                  type="file"
                  id="file"
                  accept='image/*'
                  style={{ display: "none" }}
                  onChange={handleChangeImage}
                  name="icon"
                />
              </div>
            </div>


          </form>
        </div>
      </div>
      </>) )
      }
    </div>
  )
}
