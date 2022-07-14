import React from 'react'
import './announce.css';
import PermIdentityIcon from '@mui/icons-material/PermIdentity';
import PublishIcon from '@mui/icons-material/Publish';
import TextField from '@mui/material/TextField';
import { Link } from 'react-router-dom';
import { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { getAnnounce, updateAnnounce } from '../../../redux/actions/announcesActions';
import V from 'max-validator';
import { addAnnounce } from '../../../redux/actions/announcesActions';
import { useForm } from "react-hook-form";
import Button from '@mui/material/Button';


export default function Announce() {


  const userInfo = useSelector(state => state.user.userInfo);
  let [imagefile, setImageFile] = useState({})
  const [imageState,setImageState] = useState("https://media.istockphoto.com/vectors/thumbnail-image-vector-graphic-vector-id1147544807?k=20&m=1147544807&s=612x612&w=0&h=pBhz1dkwsCMq37Udtp9sfxbjaMl27JUapoyYpQm0anc=")
  const dispatch = useDispatch();
  const announce = useSelector(state => state.allAnnounces.announce);
  const access = useSelector(state => state.user.user.access_token);
  const announceId = useParams().announceId
  const { register, handleSubmit } = useForm();
  const [imageUpdated,setI] = useState(false);


  let validationScheme = {
    title: 'required|string|max:255',
    authoritie_id: 'required|numeric',
    description: 'required|string|max:255',
  }

  const [state, setState] = useState({
    "authoritie_id": 16
  })
  /* errors */
  const initialState = {
    valid: false,
    text: ""
  }
  const [titleError, setTitleError] = useState(initialState)
  const [descriptionError, setDescriptionError] = useState(initialState)

  /* ############################## IMAGE UPLOAD ################################################*/
  const handleChangeImage = (e) => {
    setImageFile(e.target.files[0])
    setImageState(URL.createObjectURL(e.target.files[0]))
    setI(true);
    setState({
      ...state,
      [e.target.name]: URL.createObjectURL(e.target.files[0])
    })
  }
  /* ############################## IMAGE UPLOAD ###########################################*/


  const handleChange = e => {
    const value = e.target.value;
    setState({
      ...state,
      [e.target.name]: value
    });

  }
 
  const onSubmit = (data) => {

    console.log(data);
    const result = V.validate(state, validationScheme)
    if (result.hasError) {
      console.log(result);
      if (result.isError('title'))
        setTitleError({ ...titleError, ["text"]: result.getError('title'), ["valid"]: true })
      else
        setTitleError(initialState)

      if (result.isError('description'))
        setDescriptionError({ ...descriptionError, ["text"]: result.getError('description'), ["valid"]: true })
      else
        setDescriptionError(initialState)
    } else {
      dispatch(updateAnnounce(access,announceId, data, imagefile,imageUpdated))
    }
  }

  useEffect(() => {
    if (userInfo.hasOwnProperty("authoritie")) {
      setState({ ...state, ["authoritie_id"]: Number(userInfo.authoritie) })
    }
    if (userInfo.hasOwnProperty("wilaya")) {
      setState({ ...state, ["authoritie_id"]: userInfo.wilaya })
    }
  }, [userInfo])





  

  useEffect(() => {
    dispatch(getAnnounce(access, announceId))
  }, [announceId])

  console.log(announce);

  return (
    <div className="announce">
      <div className="announceTitleContainer">
        <h1 className="announceTitle">Edit Announce</h1>
        <Link to="/announce">
          <button className="announceAddButton">Ajouter</button>
        </Link>
      </div>
      <div className="announceContainer">
        <div className="announceShow">
          <div className="announceShowTop">
            <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/1/12/User_icon_2.svg/2048px-User_icon_2.svg.png" alt="" className="announceShowImg" />
            <div className="announceShowTopTitle">
              <span className="announceShowName">
                Ishak Kerboua
              </span>
            </div>
          </div>
          <div className="announceShowBottom">
            <span className="announceShowTitle">Informations Personnelles</span>
            <div className="announceShowInfo">
              <PermIdentityIcon className="announceShowIcon" />
              <span className="announceShowInfoTitle">Genre</span>
            </div>
            <div className="announceShowInfo">
              <PermIdentityIcon className="announceShowIcon" />
              <span className="announceShowInfoTitle">Adresse</span>
            </div>
            <div className="announceShowInfo">
              <PermIdentityIcon className="announceShowIcon" />
              <span className="announceShowInfoTitle">Date de naissance + wilaya</span>
            </div>
            <div className="announceShowInfo">
              <PermIdentityIcon className="announceShowIcon" />
              <span className="announceShowInfoTitle">residence</span>
            </div>
            <div className="announceShowInfo">
              <PermIdentityIcon className="announceShowIcon" />
              <span className="announceShowInfoTitle">commune</span>
            </div>
            <div className="announceShowInfo">
              <PermIdentityIcon className="announceShowIcon" />
              <span className="announceShowInfoTitle">email</span>
            </div>
            <div className="announceShowInfo">
              <PermIdentityIcon className="announceShowIcon" />
              <span className="announceShowInfoTitle">telephone</span>
            </div>
            <div className="announceShowInfo">
              <PermIdentityIcon className="announceShowIcon" />
              <span className="announceShowInfoTitle">telephone parent</span>
            </div>
            <span className="announceShowTitle">Contact Details</span>
            <div className="announceShowInfo">
              <PermIdentityIcon className="announceShowIcon" />
              <span className="announceShowInfoTitle">Etablissement</span>
            </div>
            <div className="announceShowInfo">
              <PermIdentityIcon className="announceShowIcon" />
              <span className="announceShowInfoTitle">Specilite</span>
            </div>
            <div className="announceShowInfo">
              <PermIdentityIcon className="announceShowIcon" />
              <span className="announceShowInfoTitle">Annee d'inscription</span>
            </div>
          </div>
        </div>
        <div className="announceUpdate">
          <span className="announceUpdateTitle">Edit</span>
          <form className="announceForm" onSubmit={handleSubmit(onSubmit)}>
            <div className="announceLeft">
              <div className="newIncidentItem">
                {
                  userInfo.hasOwnProperty("wilaya") &&
                  <>
                    <label>authoritie</label>
                    <input type="text" placeholder={userInfo.wilaya} id="" disabled />
                  </>
                }
                {
                  userInfo.hasOwnProperty("authoritie") &&
                  <>
                    <label>authoritie</label>
                    <input type="text" placeholder={userInfo.authoritie} id="" disabled />
                  </>
                }
              </div>

              <div className="announceItem">
                <TextField
                  {...register("title")}
                  error={titleError.valid}
                  helperText={titleError.text}
                  id="outlined-basic" label="Title" variant="outlined" name="title" size='small' onChange={handleChange} />
              </div>
              <div className="announceItem">
                <TextField
                  {...register("description")}
                  error={descriptionError.valid}
                  helperText={descriptionError.text}
                  id="outlined-multiline-static"
                  label="Description"
                  multiline
                  name="description"
                  rows={4}
                  onChange={handleChange}

                />
              </div>


              <button className="announceButton">Update</button>
            </div>
            <div className="announceRight">
              <label for="file">Image</label>
              <div className="announceUpload">
                <img src={imageState} alt="" className="announceUploadImg" />
                <label for="file" style={{ cursor: "pointer", padding: "20px" }}>
                <Button variant="contained" component="span">
                    Upload
                  </Button>
                </label>
                <input
                  type="file"
                  id="file"
                  name="file"
                  accept='image/*'
                  onChange={handleChangeImage}
                  style={{ display: "none" }} />
              </div>
            </div>
          </form>
        </div>
      </div>
    </div>
  )
}
