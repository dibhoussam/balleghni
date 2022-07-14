import React, { useState } from 'react'
import './NewAuthoritie.css'
import PublishIcon from '@mui/icons-material/Publish';
import TextField from '@mui/material/TextField';
import MultipleSelectChip from '../../../components/selectChip/MultipleSelectChip';
import { useTheme } from '@mui/material/styles';
import Box from '@mui/material/Box';
import OutlinedInput from '@mui/material/OutlinedInput';
import InputLabel from '@mui/material/InputLabel';
import MenuItem from '@mui/material/MenuItem';
import FormControl from '@mui/material/FormControl';
import Select from '@mui/material/Select';
import Chip from '@mui/material/Chip';
import { useEffect } from 'react';
import { useSelector } from 'react-redux';
import V from 'max-validator';
import { useDispatch } from 'react-redux';
import { addAuthoritie } from '../../../redux/actions/authoritiesActions';
import { useForm } from "react-hook-form";
import Button from '@mui/material/Button';
import { useHistory } from 'react-router-dom';



export default function NewAuthoritie() {
  const initialState = {
    valid: false,
    text: ""
  }

  let [globalState, setGlobalState] = useState({
    imageState : "https://media.istockphoto.com/vectors/thumbnail-image-vector-graphic-vector-id1147544807?k=20&m=1147544807&s=612x612&w=0&h=pBhz1dkwsCMq37Udtp9sfxbjaMl27JUapoyYpQm0anc=",
    imageUploaded : false
  }) 
  const dispatch = useDispatch();
  const history = useHistory()
  const access = useSelector(state => state.user.user.access_token);
  let authoritieAdded = useSelector(state => state.allAuthorities.addedAuthoritie)
  const { register, handleSubmit } = useForm();
  const [imageState, setImageState] = useState("https://media.istockphoto.com/vectors/thumbnail-image-vector-graphic-vector-id1147544807?k=20&m=1147544807&s=612x612&w=0&h=pBhz1dkwsCMq37Udtp9sfxbjaMl27JUapoyYpQm0anc=")

 
  let validationScheme = {
    name: 'required|string|max:255',
    slug: 'required|alpha_dash',
    description: 'required|string|max:255',
    logo: 'url|required'
  }



  /* ############################## IMAGE UPLOAD ################################################*/
  let [imagefile, setImageFile] = useState({});
  const handleChangeImage = (e) => {
    setGlobalState({
      ...globalState,
      ["imageState"]: URL.createObjectURL(e.target.files[0]),
      ["imageUploaded"]: true,
      ["imagefile"]: e.target.files[0]
    })

  }
  /* ############################## IMAGE UPLOAD ###########################################*/

  /* errors */
  
  const [nameError, setNameError] = useState(initialState)
  const [descriptionError, setDescriptionError] = useState(initialState)
  const [slugError, setSlugError] = useState(initialState)
  const [logoError, setLogoError] = useState(initialState)
  
  console.log(globalState);
  

  const onSubmit = (data) => {
    if (globalState.imageUploaded) {
      data.logo = globalState.imageState
    }
    const result = V.validate(data, validationScheme)
    if (result.hasError) {
      console.log(result);
      if (result.isError('name'))
        setNameError({ ...nameError, ["text"]: result.getError('name'), ["valid"]: true })
      else
        setNameError(initialState)

      if (result.isError('description'))
        setDescriptionError({ ...descriptionError, ["text"]: result.getError('description'), ["valid"]: true })
      else
        setDescriptionError(initialState)

      if (result.isError('slug'))
        setSlugError({ ...slugError, ["text"]: result.getError('slug'), ["valid"]: true })
      else
        setSlugError(initialState)

      if (result.isError('logo'))
        setLogoError({ ...logoError, ["text"]: result.getError('logo') })
      else
        setLogoError(initialState)
    } else {
      //console.log(data.logo);
      dispatch(addAuthoritie(access, data, globalState.imagefile))
      history.push("/authorities")
    }
  }


  return (
    <div className="newAuthoritie">
      <div className="newAuthoritieTitleContainer">
        <h1 className="newAuthoritieTitle">New Authoritie</h1>
      </div>

      <form className="newAuthoritieForm" onSubmit={handleSubmit(onSubmit)}>
        <div className="newAuthoritieLeft">
          <div className="newAuthoritieItem">
            <TextField
              {...register("name")}
              id="outlined-basic"
              label="Name"
              name='name'
              variant="outlined"
              size='large'
              error={nameError.valid}
              helperText={nameError.text}
              
            />
          </div>
          <div className="newAuthoritieItem">
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
          <div className="newAuthoritieItem">
            <TextField
              {...register("description")}
              id="outlined-multiline-static"
              label="Description"
              multiline
              rows={4}
              defaultValue="Default Value"
              name='description'
              error={descriptionError.valid}
              helperText={descriptionError.text}
              
            />
          </div>


          <button className="newAuthoritieButton">Create</button>
        </div>
        <div className="newAuthoritieRight">
          <div className="authoritieUpload">
            <img src={globalState.imageState} alt="" className="authoritieUploadImg" />
            <label for="file" style={{ cursor: "pointer", padding: "20px" }}>
              <Button variant="contained" component="span">
                Upload
              </Button>
            </label>
            <input

              type="file"
              id="file"
              style={{ display: "none" }}
              name="logo"
              onChange={handleChangeImage}
              accept='image/*'
            />
            <label for="" style={{ padding: "0px", margin: "0px", color: "red" }}>
              {logoError.text}
            </label>
          </div>
        </div>


      </form>
    </div>
  )
}
