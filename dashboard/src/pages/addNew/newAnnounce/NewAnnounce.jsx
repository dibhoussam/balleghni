import React, { useState } from 'react'
import './NewAnnounce.css'
import PublishIcon from '@mui/icons-material/Publish';
import TextField from '@mui/material/TextField';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';
import { useSelector } from 'react-redux';
import { useEffect } from 'react';
import V from 'max-validator';
import { addAnnounce } from '../../../redux/actions/announcesActions';
import { useDispatch } from 'react-redux';
import { useForm } from "react-hook-form";
import Button from '@mui/material/Button';
import { useHistory } from "react-router-dom";


export default function NewAnnounce() {

  const userInfo = useSelector(state => state.user.userInfo);
  const access = useSelector(state => state.user.user.access_token);
  const [imageState, setImageState] = useState("https://media.istockphoto.com/vectors/thumbnail-image-vector-graphic-vector-id1147544807?k=20&m=1147544807&s=612x612&w=0&h=pBhz1dkwsCMq37Udtp9sfxbjaMl27JUapoyYpQm0anc=")
  const { register, handleSubmit } = useForm();
  let history = useHistory()

  let [imagefile, setImageFile] = useState({})
  const dispatch = useDispatch();

  let validationScheme = {
    title: 'required|string|max:255',
    authoritie_id: 'required|numeric',
    description: 'required|string|max:255',
  }

  const [state, setState] = useState({
    "authoritie_id": 16,

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

      if (userInfo.hasOwnProperty('authoritie')) {
        data.authoritie_id = Number(userInfo.authoritie)
      }else if (userInfo.hasOwnProperty('wilaya')) {
        data.authoritie_id = Number(userInfo.wilaya)
      }else
        data.authoritie_id = 16
      
      console.log(data);
      dispatch(addAnnounce(access, data, imagefile))
      
    }
    history.replace("/announces")
    //window.location.reload()
  }


  useEffect(() => {
    if (userInfo.hasOwnProperty("authoritie")) {
      setState({ ...state, ["authoritie_id"]: Number(userInfo.authoritie) })
    }
    if (userInfo.hasOwnProperty("wilaya")) {
      setState({ ...state, ["authoritie_id"]: userInfo.wilaya })
    }
  }, [userInfo])

  





  return (
    <div className="newAnnounce">
      <div className="newAnnounceTitleContainer">
        <h1 className="newAnnounceTitle">New Announce</h1>
      </div>

      <form className="newAnnounceForm" onSubmit={handleSubmit(onSubmit)}>
        <div className="newAnnounceLeft">
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

          <div className="newAnnounceItem">
            <TextField
              {...register("title")}
              error={titleError.valid}
              helperText={titleError.text}
              id="outlined-basic" label="Title" variant="outlined" name="title" size='small' onChange={handleChange} />
          </div>
          <div className="newAnnounceItem">
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


          <button className="newAnnounceButton" >Create</button>
        </div>
        <div className="newAnnounceRight">
          <label for="file">Image</label>
          <div className="newAnnounceUpload">
            <img src={imageState} alt="" className="newAnnounceUploadImg" />
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
  )
}
