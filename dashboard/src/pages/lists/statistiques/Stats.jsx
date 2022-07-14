import React from 'react'
import { useDispatch, useSelector } from 'react-redux';
import { useEffect, useState } from 'react';
import { getAuthoritie, removeSelectedAuthoritie } from '../../../redux/actions/authoritiesActions';
import CircularProgress from '@mui/material/CircularProgress';

export default function Stats() {
    

    const dispatch = useDispatch();

    let authoritie = useSelector(state => state.allAuthorities.authoritie);
    const access = useSelector(state => state.user.user.access_token);
    let userInfo = useSelector(state => state.user.userInfo)
    let id;
    if (userInfo.hasOwnProperty("authoritie")) {
        id = userInfo.authoritie
      }else if (userInfo.hasOwnProperty("wilaya")) {
        id = userInfo.wilaya
      }

    useEffect(() => {
        dispatch(removeSelectedAuthoritie())
        dispatch(getAuthoritie(access, 103))
      }, [])


    console.log(id);
    let statsPath= process.env.REACT_APP_SUPERSET_END_POINT+"/"+authoritie.slug
    console.log(statsPath);

    return (
        <div className="user">
            {
                Object.keys(authoritie).length === 0 ? (
                    <>
                        <div style={{ textAlign: "center", height: "800px" }}>
                            <CircularProgress style={{ marginTop: "400px" }} />
                        </div>
                    </>
                ) : (
                    <>
                        <iframe src={statsPath} width="100%" height="100%" style={{ border: 0 }} allowFullScreen loading="lazy" referrerPolicy="no-referrer-when-downgrade" />

                    </>
                )
            }
        </div>
    )
}
