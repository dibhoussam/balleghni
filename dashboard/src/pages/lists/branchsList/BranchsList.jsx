import React, { useEffect } from 'react';
import "./branchList.css";
 
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

import FaceIcon from '@mui/icons-material/Face';
import jwt_decode from "jwt-decode";
import { loadIncidents } from '../../../redux/actions/incidentsActions';
import { deleteBranch, loadBranchs, resetBranch } from '../../../redux/actions/branchsActions';
import LocalPhoneIcon from '@mui/icons-material/LocalPhone';
import LocalPhone from '@mui/icons-material/LocalPhone';



export default function BranchsList(props) {

    const branchs = useSelector(state => state.allBranchs.branchs);
    const access = useSelector(state => state.user.user.access_token);
    let userInfo = useSelector(state => state.user.userInfo)
    const dispatch = useDispatch();
    const [currentpage, setCurrentpage] = useState();

    useEffect(() => {
        setCurrentpage(1)
    }, []);


    useEffect(() => {
        dispatch(loadBranchs(access, currentpage))

    }, [currentpage]);

    const handleDelete = (id) =>{
        if (window.confirm(`Confirmer la suppression de branch ${id}` )) {
            dispatch(deleteBranch(access,id,currentpage));
        }
        
    }



    const columns = [
        { field: 'id', headerName: 'ID', width: 70 },
        { field: 'email', headerName: 'Email', width: 200 },
        {
            field: 'wilaya',
            headerName: 'wilaya',
            width: 100,
            valueGetter: (params) => {
                return (params.row.location.wilaya.ar_name)
            },
        },
        {
            field: 'daira',
            headerName: 'Daira',
            valueGetter: (params) => {
                return (params.row.location.daira.ar_name)
            },
            width: 90,
        },
        {
            field: 'commune',
            headerName: 'Commune',
            valueGetter: (params) => {
                return (params.row.location.commune.ar_name)
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
                        {params.row.phones.map(res2 => {
                            return (
                                <div key={res2.id} style={{ display: "flex !important", flexWrap: "wrap" }}>
                                    <div style={{ display: "flex", margin: "3px" }}>
                                        <Chip icon={<LocalPhone />} label={res2.phone} variant="outlined" />
                                    </div>
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
                        <Link to={'/branch/' + params.row.id}>
                            <button className="userListEdit">Preview & Edit</button>
                        </Link>
                        
                            <DeleteForeverIcon className="userListDelete" onClick={() =>handleDelete(params.row.id)} />
                        
                    </>
                )
                //}

            },

        },


    ];

    return (
        <div className="userList">

            {
                Object.keys(branchs).length === 0 ? (
                    <>
                        <div style={{ textAlign: "center", height: "800px" }}>
                            <CircularProgress style={{ marginTop: "400px" }} />
                        </div></>
                ) : (
                    <>
                        <div className="userTitleContainer">
                            <h1 className="userTitle">Branchslist</h1>
                            {!userInfo.hasOwnProperty('wilaya') &&
                            <Link to="/newBranch">
                                <button className="userAddButton">Ajouter</button>
                            </Link>
                            }
                        </div>
                        <div className="userTitleContainer">
                            <div style={{ marginLeft: "40%" }}>
                                <Stack >
                                    <Pagination count={branchs.last_page} color="primary" onChange={(e, page) => { setCurrentpage(page) }} />
                                </Stack>
                            </div>
                        </div>
                        <DataGrid
                            disableSelectionOnClick
                            rows={branchs.data}
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
