import React, { Component, useEffect } from 'react';
import "./authoritiesList.css";
 
import Pagination from '@mui/material/Pagination';
import Stack from '@mui/material/Stack';
import { DataGrid } from '@mui/x-data-grid';
import DeleteForeverIcon from '@mui/icons-material/DeleteForever';
import { Link } from 'react-router-dom';
import { useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import CircularProgress from '@mui/material/CircularProgress';

import Chip from '@mui/material/Chip';
import Avatar from '@mui/material/Avatar';

import jwt_decode from "jwt-decode";

import { deleteAthoritie, loadAuthorities } from '../../../redux/actions/authoritiesActions';



export default function AuthoritiesList(props) {

    const authorities = useSelector(state => state.allAuthorities.authorities);
    const access = useSelector(state => state.user.user.access_token);
    const removedAuthoritie = useSelector(state => state.allAuthorities.removedAuthoritie);
    
    const dispatch = useDispatch();
    const [currentpage, setCurrentpage] = useState(1);

    useEffect(() => {
        console.log(access);
        dispatch(loadAuthorities(access, currentpage))
    }, [currentpage]);

    const handleDelete = (id) =>{
        if (window.confirm(`Confirmer la suppression d'authoritie' ${id}` )) {
            dispatch(deleteAthoritie(access,id,currentpage));
            window.location.reload()
        }   
    }

    


    const columns = [
        { field: 'id', headerName: 'ID', width: 70 },
        {
            field: "authoritie",
            headerName: "Authoritie",
            width: 200,
            renderCell: (params) => {
                return (
                    <>
                        <div key={params.id} style={{ display: "flex", flexWrap: "wrap" }}>
                            <div style={{ display: "flex" }}>
                                <Chip
                                    avatar={<Avatar alt="Natacha" src={params.row.logo} />}
                                    label={params.row.name}
                                    variant="outlined"
                                />
                            </div>
                        </div>

                    </>
                )
            },

        },

        {
            field: 'announces',
            headerName: 'Announces',
            width: 100,
            valueGetter: (params) => {
                return (params.row.announces.length)
            },
        },
        {
            field: 'branchs',
            headerName: 'branchs',
            valueGetter: (params) => {
                return (params.row.branchs.length)
            },
            width: 90,
        },
        {
            field: "tags",
            headerName: "",
            width: 500,
            renderCell: (params) => {
                return (
                    <>
                        {params.row.incident_types.map(res2 => {
                            return (
                                <div key={res2.id} style={{ display: "flex !important", flexWrap: "wrap" }}>
                                    <Chip
                                        avatar={<Avatar alt="Aatacha" src={res2.icon} />}
                                        label={res2.title}
                                        variant="outlined"
                                    />
                                </div>
                            )
                        })
                        }
                    </>
                )
            },

        },
        {
            field: "action",
            headerName: "Action",
            width: 150,
            renderCell: (params) => {
                //if (jwt_decode(access).hasOwnProperty("superadmin")) {
                return (
                    <>
                        <Link to={'/authoritie/' + params.row.id}>
                            <button className="userListEdit">Preview & Edit</button>
                        </Link>
                        <Link>
                            <DeleteForeverIcon className="userListDelete" onClick={() =>handleDelete(params.row.id)} />
                        </Link>
                    </>
                )
                //}

            },

        },


    ];


    return (
        <div className="userList">
            {
                Object.keys(authorities).length === 0 ? (
                    <>
                        <div style={{ textAlign: "center", height: "800px" }}>
                            <CircularProgress style={{ marginTop: "400px" }} />
                        </div></>
                ) : (
                    <>
                        <div className="userTitleContainer">
                            <h1 className="userTitle">Authoritieslist</h1>

                            <Link to="/newAuthoritie">
                                <button className="userAddButton">Ajouter</button>
                            </Link>

                        </div>
                        <div className="userTitleContainer">
                            <div style={{ marginLeft: "40%" }}>
                                <Stack >
                                    <Pagination count={authorities.last_page} color="primary" onChange={(e, page) => { setCurrentpage(page) }} />
                                </Stack>
                            </div>
                        </div>
                        <DataGrid
                            disableSelectionOnClick
                            rows={authorities.data}
                            columns={columns}
                            pageSize={12}
                            rowsPerPageOptions={[5]}
                            checkboxSelection
                        />
                    </>
                )
            }

        </div>
    );
}
