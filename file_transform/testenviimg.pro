pro testEnviImg,path
  ;  compile_opt idl2
  ;  envi,/restore_base_save_files
  ;  envi_batch_init
  path = ENVI_PICKFILE(title='pick file')
  envi_open_file, path, r_fid=fid

  if (fid eq -1) then return
  ;ENVI_SELECT, fid=fid ,pos=pos
  envi_file_query, fid, dims=dims, nb=nb
  pos = lindgen(nb)
  num_cols = dims[2]-dims[1]+1
  num_rows = dims[4]-dims[3]+1
  image = fltarr(nb,num_cols,num_rows)
  for i=0,nb-1 do image[i,*,*]=$
    envi_get_data(fid=fid,dims=dims,pos=pos[i])
  tv,image,/true
end