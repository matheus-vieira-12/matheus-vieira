#Include "Totvs.ch"
#Include "Protheus.ch"

/**************************************************************************************************
{Protheus.doc} fExcel1
@description	Relatorio de estoque Med office por grupo de itens
@type   		Funcao	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		05/08/2022
@database		05/08/2022
@country		Brasil
@language		PT-BR
@obs			05/08/2022 - Controle de documentacao
@return		    Nil
*****************************************************************************************************/

User Function fExcel1()

Local _aCabec   := {}
Local _aDados   := {} 
Local _aParam   := {}
Local _aParRet  := {}
Local _cNomArq  := "RelProd_"+ RetCodUsr() + StrTran( Time() , ":" , "" ) +".xls"
Local _cAba     := "SB1"
Local _cTabela  := "Estoque - Med office" 
Local _cCodDe	:= Space(TamSx3("B1_COD")   [01])
Local _cCodAte	:= Space(TamSx3("B1_COD")   [01])
Local _cArmazem := Space(TamSx3("B2_LOCAL") [01])
Local _cFilial  := Space(TamSx3("B2_FILIAL")[01]) 
Local _cPath    := Space(200)                        
Local _nI       := 0
Local _oExcel   := Nil
Local _oMsExcel := Nil

    If ApOleClient( "MSExcel" ) 

        AADD( _aParam , { 1 , "  Codigo De.:"   , _cCodDe      , "" ,""    ,"SB1"  ,""   , 090 , .F. })
        AADD( _aParam , { 1 , "  Codigo Ate.:"  , _cCodAte     , "" ,""    ,"SB1"  ,""   , 090 , .F. })
        AADD( _aParam , { 1 , "  Local.:"       , _cArmazem    , "" ,""    ,"NNR"  ,""   , 050 , .F. })
        AADD( _aParam , { 1 , "  Filial.:"      , _cFilial     , "" ,""    ,"SM0"  ,""   , 050 , .F. })
        AADD( _aParam , { 6 , "  Destino"	    , _cPath       , "" , ".T." , ".T." , 060 , .T. , "" , "C:\" , GETF_LOCALHARD + GETF_RETDIRECTORY } )


        For _nI := 1 To Len( _aParam )
            AADD( _aParRet , _aParam[_nI][03] )
        Next _nI
	
        If Parambox( _aParam , 'Extracao em Planilha ' , @_aParRet ,,, .F. ,,,,, .F. , .F. ) 

            FWMsgRun( , {|| _aCabec := fCabc()           } ,, "Aguarde! Inicializando a estrutura do relatorio..." )
            FWMsgRun( , {|| _aDados := fQuery(  _aCabec ) } ,, "Aguarde! Selecionando registros..."                )
            _cPath := AllTrim(MV_PAR05)

            // Instancia Objeto
            _oExcel  := FWMSExcel():New()
        
            // Criação de nova aba
            _oExcel:AddworkSheet( _cAba )

            // Criaação de tabela
            _oExcel:AddTable( _cAba , _cTabela )

            // Criação de colunas
            For _nI := 1 To Len( _aCabec )
                _oExcel:AddColumn( _cAba , _cTabela , _aCabec[_nI][02] , _aCabec[_nI][05] , 1 , .F. )
            Next _nI

            For _nI := 1 To Len( _aDados )

                // Criação de Linhas
                _oExcel:AddRow( _cAba , _cTabela , _aDados[_nI] )

            Next _nI

            If !Empty( _oExcel:aWorkSheet )

                _oExcel:Activate()
                _oExcel:GetXMLFile( _cNomArq )
        
                FWMsgRun( , {|| CpyS2T( "\SYSTEM\"+ _cNomArq , _cPath ) } ,, "Aguarde! Copiando arquivo..." )

                _oMsExcel := MsExcel():New()
                _oMsExcel:WorkBooks:Open( _cPath + _cNomArq ) // Abre a planilha
                _oMsExcel:SetVisible(.T.) // Exportar planilha do excel usando FWMsExcel 
                _oMsExcel:Destroy()

            EndIf
		
        Else
            MsgStop( "Execução cancelada pelo usuario" , "Atenção!" )
        EndIf
	
    Else
        MsgStop( "Microsoft Excel nÃo instalado no computador local!" , "Atenção!" )
	EndIf

Return()

/**************************************************************************************************
{Protheus.doc} fQuery
@description	Funcao para gerar o cabecalho do relatorio
@type   		Funcao	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		05/08/2022
@database		05/08/2022
@country		Brasil
@language		PT-BR
@obs			05/08/2022 - Controle de documentacao
@param			_aCabec, array
@return		    array
*****************************************************************************************************/
Static Function fCabc()

Local _aRet     := {}

        AADD( _aRet , { "B1_COD"         , "CODIGO"           , "C" , "" , 2 } )
        AADD( _aRet , { "B2_FILIAL"      , "FILIAL"           , "C" , "" , 2 } ) 
        AADD( _aRet , { "B1_DESC"        , "DESCRICAO"        , "C" , "" , 2 } ) 
        AADD( _aRet , { "B1_PRV1"        , "PRECO VENDA"      , "N" , "" , 2 } ) 
        AADD( _aRet , { "B1_TIPO"        , "TIPO"             , "C" , "" , 2 } )
        AADD( _aRet , { "B1_LOCPAD"      , "ARMAZEM"          , "C" , "" , 2 } )
        AADD( _aRet , { "B1_CODBAR"      , "COD BARRAS"       , "C" , "" , 1 } )
        AADD( _aRet , { "B1_CONTA"       , "CTA CONTABIL"     , "C" , "" , 1 } )
        AADD( _aRet , { "B1_GARANT"      , "GARANTIA"         , "C" , "" , 1 } )
        AADD( _aRet , { "B1_GRUPO"       , "GRUPO"            , "C" , "" , 1 } )
        AADD( _aRet , { "B1_GRTRIB"      , "GRUPO TRIB"       , "C" , "" , 1 } )
        AADD( _aRet , { "B1_POSIPI"      , "POS.IPI"          , "C" , "" , 1 } )
        AADD( _aRet , { "B1_UM"          , "UNIDADE"          , "C" , "" , 3 } )
        AADD( _aRet , { "BM_DESC"        , "DESC GRUPO"       , "C" , "" , 3 } )
        AADD( _aRet , { "B2_LOCAL"       , "ARMAZEM"          , "C" , "" , 3 } )
        AADD( _aRet , { "B2_QATU"        , "SALDO ATUAL"      , "N" , "" , 3 } )
        AADD( _aRet , { "NNR_CODIGO"     , "CODIGO"           , "C" , "" , 3 } )   
        AADD( _aRet , { "BM_GRUPO"       , "GRUPO"            , "C" , "" , 3 } )

Return( _aRet )

/**************************************************************************************************
{Protheus.doc} fQuery
@description	Funcao para gerar aquery de produtos
@type   		Funcao	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		05/08/2022
@database		05/08/2022
@country		Brasil
@language		PT-BR
@obs			05/08/2022 - Controle de documentacao
@param			_aCabec, array
@return		    array
*****************************************************************************************************/
Static Function fQuery( _aCabec )

Local _aRet     := {}
Local _cQuery   := ""
Local _cAlias   := GetNextAlias()

    _cQuery := " SELECT      "
    _cQuery += " B1_COD,     "                         
    _cQuery += " B2_FILIAL,  "
    _cQuery += " B1_DESC,    "                       
    _cQuery += " B1_PRV1,    "                        
    _cQuery += " B1_TIPO,    "                       
    _cQuery += " B1_LOCPAD,  "                      
    _cQuery += " B1_CODBAR,  "                                             
    _cQuery += " B1_CONTA,   "                                               
    _cQuery += " B1_GARANT,  "                   
    _cQuery += " B1_GRUPO,   "                       
    _cQuery += " B1_GRTRIB,  "                      
    _cQuery += " B1_POSIPI,  "                     
    _cQuery += " B1_UM,      "                
    _cQuery += " BM_DESC,    "                      
    _cQuery += " B2_LOCAL,   "
    _cQuery += " B2_QATU,    "
    _cQuery += " NNR_CODIGO, "
    _cQuery += " BM_GRUPO    "
    _cQuery += " FROM "+ RetSqlName("SB2")  + " B2"
    _cQuery += " INNER JOIN "+ RetSqlName("NNR") + " AS NNR ON "+ RetSqlDel("NNR") +" AND NNR_CODIGO = B2_LOCAL AND NNR_FILIAL = B2_FILIAL"
    _cQuery += " INNER JOIN "+ RetSqlName("SB1") + " AS SB1 ON "+ RetSqlDel("SB1") +" AND B1_COD = B2_COD" 
    _cQuery += " INNER JOIN "+ RetSqlName("SBM") + " AS SBM ON "+ RetSqlDel("SBM") +" AND BM_GRUPO = B1_GRUPO "
    _cQuery += " WHERE "
    _cQuery += "  B2.D_E_L_E_T_ = '' "

    If !Empty(MV_PAR01) .AND. !Empty(MV_PAR02)
        _cQuery += " AND B2_COD BETWEEN  '"+MV_PAR01+"' AND '"+MV_PAR02+"' "
    EndIf

    If !Empty(MV_PAR03)
        _cQuery += "AND B2_LOCAL = '"+MV_PAR03+"'"
    EndIf

    If !Empty(MV_PAR04)
        _cQuery += "AND B2_FILIAL = '"+MV_PAR04+"'"
    EndIf  

     //porta Alias
    If Select( _cAlias ) > 0
        (_cAlias)->( DBCloseArea() )//fecha o alias 
    EndIf
                                                                 
    DBUseArea( .T. , "TOPCONN" , TcGenQry(,,_cQuery) , _cAlias , .T. , .F. ) 

    DBSelectArea(_cAlias)
    (_cAlias)->( DBGoTop() )
    While (_cAlias)->( !Eof() )

          AADD( _aRet , { fDefineType( (_cAlias)->B1_COD        , _aCabec , 01 ) ,;
                          fDefineType( (_cAlias)->B2_FILIAL     , _aCabec , 02 ) ,;
                          fDefineType( (_cAlias)->B1_DESC       , _aCabec , 03 ) ,;
                          fDefineType( (_cAlias)->B1_PRV1       , _aCabec , 04 ) ,;
                          fDefineType( (_cAlias)->B1_TIPO       , _aCabec , 05 ) ,;
                          fDefineType( (_cAlias)->B1_LOCPAD     , _aCabec , 06 ) ,;
                          fDefineType( (_cAlias)->B1_CODBAR     , _aCabec , 07 ) ,;
                          fDefineType( (_cAlias)->B1_CONTA      , _aCabec , 08 ) ,;
                          fDefineType( (_cAlias)->B1_GARANT     , _aCabec , 09 ) ,;
                          fDefineType( (_cAlias)->B1_GRUPO      , _aCabec , 10 ) ,;
                          fDefineType( (_cAlias)->B1_GRTRIB     , _aCabec , 11 ) ,;
                          fDefineType( (_cAlias)->B1_POSIPI     , _aCabec , 12 ) ,;
                          fDefineType( (_cAlias)->B1_UM         , _aCabec , 13 ) ,;
                          fDefineType( (_cAlias)->BM_DESC       , _aCabec , 14 ) ,;
                          fDefineType( (_cAlias)->B2_LOCAL      , _aCabec , 15 ) ,;
                          fDefineType( (_cAlias)->B2_QATU       , _aCabec , 16 ) ,;
                          fDefineType( (_cAlias)->NNR_CODIGO    , _aCabec , 17 ) ,;
                          fDefineType( (_cAlias)->BM_GRUPO      , _aCabec , 18 ) })
                                 

            (_cAlias)->( DBSkip() )
    EndDo

Return( _aRet )

/**************************************************************************************************
{Protheus.doc} fDefineType
@description	Funcao para definir o valor de cada campo
@type   		Funcao	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		05/08/2022
@database		05/08/2022
@country		Brasil
@language		PT-BR
@obs			05/08/2022 - Controle de documentacao
@param			_xValor, String
@param			_aCabec, array
@param          _nPos, Numeric
@return		    Type
*****************************************************************************************************/
Static Function fDefineType( _xValor , _aCabec , _nPos )

Local _xRet := NIL

    Do Case
        Case _aCabec[_nPos][03] == "C" ; _xRet := AllTrim(    _xValor )//caracter
        Case _aCabec[_nPos][03] == "D" ; _xRet := DTOC( STOD( _xValor ) )//data
        Case _aCabec[_nPos][03] == "N" ; _xRet := Transform(  _xValor , _aCabec[_nPos][04] )//numero
    EndCase

Return( _xRet )
