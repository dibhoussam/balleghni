import React, { useEffect } from 'react';
import "./reportsList.css";

import Pagination from '@mui/material/Pagination';
import Stack from '@mui/material/Stack';
import { DataGrid } from '@mui/x-data-grid';
import DeleteForeverIcon from '@mui/icons-material/DeleteForever';
import { Link } from 'react-router-dom';
import { useState } from 'react';
import { useDispatch, useSelector } from 'react-redux';
import CircularProgress from '@mui/material/CircularProgress';

import { loadReports, setReports } from '../../../redux/actions/reportsActions';
import Chip from '@mui/material/Chip';
import FaceIcon from '@mui/icons-material/Face';
import jwt_decode from "jwt-decode";



export default function ReportsList(props) {

  const reports = useSelector(state => state.allreports.reports);
  const access = useSelector(state => state.user.user.access_token);
  const dispatch = useDispatch();
  const [currentpage, setCurrentpage] = useState(1);


  useEffect(() => {
    dispatch(loadReports(access, currentpage))

  }, [currentpage]);

  //const a = jwt_decode(props.access);


  //console.log(reports);
  const [data, setData] = useState(reports.data);
  

  const columns = [
    { field: 'id', headerName: 'ID', width: 70 },
    { field: 'created_at', headerName: 'Date de creation', width: 200 },
    {
      field: 'description',
      headerName: 'description',
      type: 'number',
      width: 200,
    },
    {
      field: "wilaya",
      headerName: 'Wilaya',
      width: 90,
      valueGetter: (params) => {
        return (params.row.location.wilaya.ar_name)
      }
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
      field: "action",
      headerName: "Action",
      width: 150,
      renderCell: (params) => {
        // if (jwt_decode(access).hasOwnProperty("superadmin")) {
        return (
          <>
            <Link to={'/report/' + params.row.id}>
              <button className="userListEdit">Preview</button>
            </Link>
            
          </>
        )
        //}

      },

    },
    {
      field: "tags",
      headerName: "tags",
      width: 600,
      renderCell: (params) => {
        return (
          <>
            {params.row.incident_types.map(res2 => {
              return (
                <div key={res2.id} style={{ display: "flex !important", flexWrap: "wrap" }}>
                  <div style={{ display: "flex" }}>
                    <Chip icon={<FaceIcon />} label={res2.title} variant="outlined" />
                  </div>
                </div>
              )
            })
            }
          </>
        )
      },

    }

  ];



  return (
    <div className="userList">
      {
        Object.keys(reports).length === 0 ? (
          <>
            <div style={{ textAlign: "center", height: "800px" }}>
              <CircularProgress style={{ marginTop: "400px" }} />
            </div></>
        ) : (
          <>
            <div className="userTitleContainer">
              <h1 className="userTitle">Reports list</h1>
              
            </div>
            <div className="userTitleContainer">
              <div style={{ marginLeft: "40%" }}>
                <Stack >
                  <Pagination count={reports.last_page} color="primary" onChange={(e, page) => { setCurrentpage(page) }} />
                </Stack>
              </div>
            </div>
            <div className="diaplayContainer">
            <DataGrid
              disableSelectionOnClick
              rows={reports.data}
              columns={columns}
              pageSize={20}
              rowsPerPageOptions={[5]}
              checkboxSelection
            />
            </div>
          </>
        )
      }

    </div>
  );
}
