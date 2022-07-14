import React, { useState } from 'react'
import './NewIncident.css'
import PublishIcon from '@mui/icons-material/Publish';
import TextField from '@mui/material/TextField';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';
import { useSelector } from 'react-redux';
import { useEffect } from 'react';
import V from 'max-validator';
import axios from 'axios';
import { useDispatch } from 'react-redux';
import { addIncident } from '../../../redux/actions/incidentsActions';
import { useForm } from "react-hook-form";
import Button from '@mui/material/Button';
import { useHistory } from "react-router-dom";


export default function NewIncident() {

  const history = useHistory() 
  const { register, handleSubmit } = useForm();
  const userInfo = useSelector(state => state.user.userInfo);
  const access = useSelector(state => state.user.user.access_token);
  const [imageState, setImageState] = useState("https://media.istockphoto.com/vectors/thumbnail-image-vector-graphic-vector-id1147544807?k=20&m=1147544807&s=612x612&w=0&h=pBhz1dkwsCMq37Udtp9sfxbjaMl27JUapoyYpQm0anc=")
  const dispatch = useDispatch();

  let validationScheme = {
    title: 'required|string|max:255',
    "authoritie.id": 'required|numeric',
    slug: 'required|alpha_dash',
    description: 'required|string|max:255',
    icon: 'required|url'
  }
  /* ############################## IMAGE UPLOAD ################################################*/
  let [imagefile, setImageFile] = useState({});
  const handleChangeImage = (e) => {
    setImageFile(e.target.files[0])
    setImageState(URL.createObjectURL(e.target.files[0]))
    setState({
      ...state,
      [e.target.name]: URL.createObjectURL(e.target.files[0])
    })
  }
  /* ############################## IMAGE UPLOAD ###########################################*/
  const [state, setState] = useState({
    "title": '',
    "authoritie.id": 16,
    "slug": '',
    "description": '',
    "icon": ''
  })

  /* errors */
  const initialState = {
    valid: false,
    text: ""
  }
  const [titleError, setTitleError] = useState(initialState)
  const [descriptionError, setDescriptionError] = useState(initialState)
  const [slugError, setSlugError] = useState(initialState)
  const [fileError, setFileError] = useState(initialState)


  const handleChange = e => {
    const value = e.target.value;
    setState({
      ...state,
      [e.target.name]: value
    });

  }

  useEffect(() => {
    if (userInfo.hasOwnProperty("authoritie")) {
      setState({ ...state, ["authoritie.id"]: Number(userInfo.authoritie) })
    }
    if (userInfo.hasOwnProperty("wilaya")) {
      setState({ ...state, ["authoritie.id"]: userInfo.wilaya })
    }
    console.log(userInfo);
  }, [userInfo])

  const onSubmit = (data) => {
    if (userInfo.hasOwnProperty("authoritie")) {
      data.authoritie_id = Number(userInfo.authoritie)
    }else if (userInfo.hasOwnProperty("wilaya")) {
      data.authoritie_id = Number(userInfo.wilaya) 
    }else
      data.authoritie_id = 16

    console.log(data);
    const result = V.validate(state, validationScheme)
    if (result.hasError) {
      console.log(result)

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

      if (result.isError('icon'))
        setFileError({ ...fileError, ["text"]: result.getError('icon') })
      else
        setFileError(initialState)
    } else //no errors
    {
      dispatch(addIncident(access, data, imagefile));
      history.replace("/incidents")
    }
  }


  return (
    <div className="newIncident">
      <div className="newIncidentTitleContainer">
        <h1 className="newIncidentTitle">New Incident</h1>
      </div>

      <form className="newIncidentForm" onSubmit={handleSubmit(onSubmit)} >
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
          {/*
          <div className="newIncidentItem">
            <FormControl required sx={{ m: 0, minWidth: 120 }}>
              <InputLabel id="demo-simple-select-required-label">Authoritie</InputLabel>
              <Select
                labelId="demo-simple-select-required-label"
                id="demo-simple-select-required"
                label="Age *"
                //onChange={handleChange}
              >
                <MenuItem value="">
                </MenuItem>
                <MenuItem value={10}>Ten</MenuItem>
                <MenuItem value={20}>Twenty</MenuItem>
                <MenuItem value={30}>Thirty</MenuItem>
              </Select>
            </FormControl>
          </div>
          */}

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
              onChange={handleChange}
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
              onChange={handleChange}
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
              onChange={handleChange}
            />
          </div>


          <button className="newIncidentButton" >Create</button>
        </div>
        <div className="newIncidentRight">
          <label for="file">Image</label>
          <div className="newIncidentUpload">
            <img src={imageState} alt="" className="newIncidentUploadImg" />
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
            <label for="" style={{ padding: "0px", margin: "0px", color: "red" }}>
              {fileError.text}
            </label>
          </div>
        </div>


      </form>
    </div>
  )
}
