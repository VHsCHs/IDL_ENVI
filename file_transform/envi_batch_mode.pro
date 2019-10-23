PRO ENVI_BATCH_MODE 
  COMPILE_OPT IDL2
  ENVI,/RESTOR_BASE_SAVE_FILES
  ENVI_BATCH_INIT,log_file='batch.LOG'
  
  direc=DIALOG_PICKFILE(/DIRECTORY,title="请选择包含raw文件的目录")
  filelist = file_search(direc,'*.raw',count = num,/test_regular)
  print,direc
  IF file_test(direc+ 'BSQ\',/directory) EQ 0 THEN file_mkdir,direc+ 'BSQ\'
  IF file_test(direc+ 'TXT\',/directory) EQ 0 THEN file_mkdir,direc+ 'TXT\'
  FOREACH filename,filelist DO BEGIN
;    e = ENVI()
;    raster = e.OpenRaster(filename)
;    newFIle = e.GetTemporaryFIlename('ENVI')
;    subraster = ENVISubsetRaster(raster)
;    subraster.Exoort,newFile,'ENVI',INTERLEAVE = bsq
    ENVI_OPEN_FILE,filename,r_fid=fid
    IF(fid EQ -1) THEN BEGIN
      STOP,'NO FILES IS AVILABLE!'
      ENVI_BATCH_EXIT
      RETURN
    ENDIF
    ENVI_FILE_QUERY,fid, $
      fname =fName, $
      sname = sName, $
      nb = nb, $
      dims = dims
    ENVI_DOIT,'CONVERT_DOIT', $
      DIMS = dims, $
      FID = fid, $
      O_INTERLEAVE = 0, $
      OUT_NAME = direc + 'BSQ\' + sname + '.BSQ', $
      POS =lindgen(nb), $
      R_FID = rFid
    ;ENVI_FILE_QUERY,fid,fNAME=fileName
    ;tmp = DIALOG_MESSAGE(fileName,/infor)
    ;data = envi_get_slice(fid=fid,pos = lindgen(nb))
    ;help,data
  ENDFOREACH
  
  BSQ_filelist = file_search(direc,'*.BSQ',count = num,/test_regular)
  FOREACH filename,BSQ_filelist DO BEGIN
    ENVI_OPEN_FILE,filename,r_fid=fid
    IF(fid EQ -1) THEN BEGIN
      STOP,'NO FILES IS AVILABLE!'
      ENVI_BATCH_EXIT
      RETURN
    ENDIF
    ENVI_FILE_QUERY,fid, $
      fname =fName, $
      sname = sName, $
      nb = nb, $
      dims = dims
    out_name = direc + 'TXT\' + sname + '.txt'
    ENVI_OUTPUT_TO_EXTERNAL_FORMAT, $
      dims = dims,pos = lindgen(nb), $
      out_name = out_name, /ASCII, $
;      FIELD = [14,4],fid = fid
      FIELD = [7,0],fid = fid
  ENDFOREACH
  ENVI_BATCH_EXIT
END