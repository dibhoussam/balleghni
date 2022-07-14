import React from 'react'
import './authoritie.css';
import PermIdentityIcon from '@mui/icons-material/PermIdentity';
import { Link } from 'react-router-dom';
import { useEffect, useState } from 'react';
import { useParams } from 'react-router-dom';
import { useDispatch, useSelector } from 'react-redux';
import { getAuthoritie, removeSelectedAuthoritie, updateAuthoritie, removeAuthoritie } from '../../../redux/actions/authoritiesActions';
import DescriptionIcon from '@mui/icons-material/Description';
import TextField from '@mui/material/TextField';
import V from 'max-validator';
import { useForm } from "react-hook-form";
import Button from '@mui/material/Button';
import CircularProgress from '@mui/material/CircularProgress';
import { useHistory } from 'react-router-dom'; 
import EnergySavingsLeafIcon from '@mui/icons-material/EnergySavingsLeaf';

 
export default function Authoritie() {
  const initialState = {
    valid: false,
    text: ""
  } 

  let [globalState, setGlobalState] = useState({}) 

  const dispatch = useDispatch();
  const history = useHistory()
  let authoritie = useSelector(state => state.allAuthorities.authoritie);
  console.log(authoritie);
  const access = useSelector(state => state.user.user.access_token);
  let id = useParams().authoritieId
  const { register, handleSubmit } = useForm();
  useEffect(() => {
    dispatch(removeSelectedAuthoritie())
    dispatch(getAuthoritie(access, id))
  }, [])

  useEffect(() => {
    load()
    console.log("authoritiiii");
  }, [authoritie])

  const load = () => {
    setGlobalState({
      ...globalState,
      "authoritie": authoritie,
      "imageState": authoritie.logo,
      "imageUpdated": false,
      "imagefile": ""
    })


  }
  console.log(globalState);

  


  let validationScheme = {
    name: 'required|string|max:255',
    slug: 'required|alpha_dash',
    description: 'required|string|max:255',
  }




  //console.log(authoritie);

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

  const [nameError, setNameError] = useState(initialState)
  const [descriptionError, setDescriptionError] = useState(initialState)
  const [slugError, setSlugError] = useState(initialState)
  


  const onSubmit = (data) => {

    console.log(data);

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
    } else {
      data.logo = authoritie.logo;
      dispatch(updateAuthoritie(access, id, data, globalState.imagefile, globalState.imageUpdated))
      history.replace("/authorities")
    }


  }

  return (

    <div className="authoritie">
      {
        (globalState.authoritie === undefined || globalState.authoritie === {}) ? (
          <>
            <div style={{ textAlign: "center", height: "800px" }}>
              <CircularProgress style={{ marginTop: "400px" }} />
            </div>
          </>
        ) : (
          <>
            <div className="authoritieTitleContainer">
              <h1 className="authoritieTitle">Edit Authoritie</h1>
              <Link to="/updateAuthoritie">
                <button className="authoritieAddButton">Ajouter</button>
              </Link>
            </div>
            <div className="authoritieContainer">
              <div className="authoritieShow">
                <div className="authoritieShowTop">
                  <img src={globalState.authoritie.logo} alt="logo" className="authoritieShowImg" />
                  <div className="authoritieShowTopTitle">
                    <span className="authoritieShowName">
                      {globalState.authoritie.name}
                    </span>
                  </div>
                </div>
                <div className="authoritieShowBottom">
                  <span className="authoritieShowTitle">Slug</span>
                  <div className="authoritieShowInfo">
                    <EnergySavingsLeafIcon className="authoritieShowIcon" />
                    <span className="authoritieShowInfoTitle">{authoritie.slug}</span>
                  </div>
                  <span className="authoritieShowTitle">Description</span>
                  <div className="authoritieShowInfo">
                    <DescriptionIcon className="authoritieShowIcon" />
                    <span className="authoritieShowInfoTitle">{authoritie.description}</span>
                  </div>
                  <span className="authoritieShowTitle">Branchs</span>
                  <div className="authoritieShowInfo">
                    <DescriptionIcon className="authoritieShowIcon" />
                    <span className="authoritieShowInfoTitle">kda mena melhik</span>
                  </div>
                  <span className="authoritieShowTitle">Announces</span>
                  <div className="authoritieShowInfo">
                    
                    <DescriptionIcon className="authoritieShowIcon" />
                    <span className="authoritieShowInfoTitle">kda mena melhik</span>
                  </div>

                </div>
              </div>
              <div className="authoritieUpdate">
                <span className="authoritieUpdateTitle">Edit</span>
                <form className="updateAuthoritieForm" onSubmit={handleSubmit(onSubmit)}>

                  <div className="updateAuthoritieLeft">
                    <div className="updateAuthoritieItem">
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
                    <div className="updateAuthoritieItem">
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
                    <div className="updateAuthoritieItem">
                      <TextField
                        {...register("description")}
                        id="outlined-multiline-static"
                        label="Description"
                        multiline
                        rows={4}

                        name='description'

                        error={descriptionError.valid}
                        helperText={descriptionError.text}
                        
                      />
                    </div>


                    <button className="updateAuthoritieButton" >Update</button>
                  </div>
                  <div className="updateAuthoritieRight">
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

                      </label>
                    </div>
                  </div>


                </form>
              </div>
            </div>
          </>)
      }
    </div>
  )
}
