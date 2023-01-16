#Include "Totvs.ch"
#Include "Protheus.ch"

/**************************************************************************************************
{Protheus.doc} fRealNotas
@description	Nota fiscal de Entrada e Saida
@type   		Funcao	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		12/08/2022
@database		12/08/2022
@country		Brasil
@language		PT-BR
@obs			12/08/2022 - Controle de documentacao
@return		    Nil
*****************************************************************************************************/
User Function fRelNotas()
Local _aCabec     := {}
Local _aDados     := {} 
Local _aParam     := {}
Local _aParRet    := {}
Local _cNomArq    := "RelNota_"+ RetCodUsr() + StrTran( Time() , ":" , "" ) +".xls"
Local _cAba       := "SD2"
Local _cTabela    := "NF DE SAIDA"
Local _cCustoDe   := Space(TamSx3("D1_CC")        [01])
Local _cCustoAte  := Space(TamSx3("D1_CC")        [01])
Local _cCodDe     := Space(TamSx3("D1_COD")       [01])
Local _cCodAte    := Space(TamSx3("D1_COD")       [01])
Local _cFilialDe  := Space(TamSx3("D1_FILIAL")    [01])
Local _cFilialAte := Space(TamSx3("D1_FILIAL")    [01])
Local _dDataDe    := Space(TamSx3("D1_EMISSAO")   [01])
local _dDataAte   := Space(TamSx3("D1_EMISSAO")   [01])
Local _cPath      := Space(200) 
Local _nI         := 0
Local _oExcel     := Nil
Local _oMsExcel   := Nil
Local nVinc

    If ApOleClient( "MSExcel" )

        AADD( _aParam , { 2 , "  Tipo de nota"          , nVinc          , {"1=NF. Entrada", "2=NF. Saida"}, 090 , ".T.", .F.})// MV_PAR01
        AADD( _aParam , { 1 , "  Centro de Custo De.:"  , _cCustoDe      , "" ,""  ,"CTT"  ,""   , 090 , .F. })// MV_PAR02
        AADD( _aParam , { 1 , "  Centro de Custo Ate.:" , _cCustoAte     , "" ,""  ,"CTT"  ,""   , 090 , .F. })// MV_PAR03
        AADD( _aParam , { 1 , "  Produto De.:"          , _cCodDe        , "" ,""  ,"SB1"  ,""   , 090 , .F. })// MV_PAR04
        AADD( _aParam , { 1 , "  Produto Ate.:"         , _cCodAte       , "" ,""  ,"SB1"  ,""   , 090 , .F. })// MV_PAR05
        AADD( _aParam , { 1 , "  Filial De.:"           , _cFilialDe     , "" ,""  ,"SM0"  ,""   , 090 , .F. })// MV_PAR06
        AADD( _aParam , { 1 , "  Filial Ate.:"          , _cFilialAte    , "" ,""  ,"SM0"  ,""   , 090 , .F. })// MV_PAR07
        AADD( _aParam , { 1 , "  Data De.:"             , Ctod(Space(8)+_dDataDe) , ""  ,"" ,"" ,"" , 50, .F.})// MV_PAR08
        AADD( _aParam , { 1 , "  Data Ate.:"            , Ctod(Space(8)+_dDataAte) , ""  ,"" ,"" ,"" , 50, .F.})// MV_PAR09
        AADD( _aParam , { 6 , "  Destino"	            , _cPath         , "" , ".T.", ".T." , 060 , .T. , "" , "C:\" , GETF_LOCALHARD + GETF_RETDIRECTORY } )// MV_PAR10

        For _nI := 1 To Len( _aParam )
            AADD( _aParRet , _aParam[_nI][03] )
        Next _nI
	
        If Parambox( _aParam , 'Extracao em Planilha ' , @_aParRet ,,, .F. ,,,,, .F. , .F. ) 

            if MV_PAR01 == "1"
                _cTabela := "NF DE ENTRADA"
            Else 
                _cTabela    := "NF DE SAIDA"
            EndIf 
 
            FWMsgRun( , {|| _aCabec := fCabc()           } ,, "Aguarde! Inicializando a estrutura do relatorio..." )
            FWMsgRun( , {|| _aDados := fQuery(  _aCabec ) } ,, "Aguarde! Selecionando registros..."                )
            _cPath := AllTrim(MV_PAR10)

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
        MsgStop( "Microsoft Excel não instalado no computador local!" , "Atenção!" )
	EndIf

Return()
/**************************************************************************************************
{Protheus.doc} fRealNotas
@description	Nota fiscal de Entrada e Saida
@type   		Funcao	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		12/08/2022
@database		12/08/2022
@country		Brasil
@language		PT-BR
@obs			12/08/2022 - Controle de documentacao
@return		    Nil
*****************************************************************************************************/
Static Function fCabc()

Local _aRet     := {}
    If MV_PAR01 == "1"

        AADD( _aRet , { "D1_COD "      , "CODIGO"        , "C" , "" , 2 } )
        AADD( _aRet , { "B1_DESC "     , "DESCRICAO"     , "C" , "" , 2 } )
        AADD( _aRet , { "D1_ITEM"      , "ITEM"          , "C" , "" , 2 } )
        AADD( _aRet , { "D1_FILIAL"    , "FILIAL"        , "C" , "" , 2 } )
        AADD( _aRet , { "D1_VUNIT"     , "VLR.UNITARIO"  , "N" , "" , 2 } )
        AADD( _aRet , { "D1_TOTAL"     , "VLR.TOTAL"     , "N" , "" , 2 } )
        AADD( _aRet , { "D1_QUANT"     , "QUANTIDADE"    , "C" , "" , 2 } )
        AADD( _aRet , { "D1_CF"        , "COD.FISCAL"    , "C" , "" , 2 } )
        AADD( _aRet , { "D1_CC "       , "CENTRO CUSTO"  , "C" , "" , 2 } )
        AADD( _aRet , { "CTT_DESC01 "  , "DESC CUSTO "   , "C" , "" , 1 } )
        AADD( _aRet , { "D1_FORNECE "  , "FORNECEDO"     , "C" , "" , 1 } )
        AADD( _aRet , { "A2_NOME "     , "NOME FORNECE"  , "C" , "" , 1 } )
        AADD( _aRet , { "D1_LOCAL "    , "LOCAL"         , "C" , "" , 1 } )
        AADD( _aRet , { "D1_DTDIGIT "  , "DT DIGITACAO"  , "D" , "" , 1 } )
        AADD( _aRet , { "D1_UM "       , "UNIDADE"       , "C" , "" , 1 } )
        AADD( _aRet , { "D1_DTVALID "  , "VALID.LOTE"    , "D" , "" , 1 } )
        AADD( _aRet , { "D1_DOC "      , "DOCUMENTO"     , "C" , "" , 1 } )
        AADD( _aRet , { "D1_SEGUM "    , "SEGUNDA UM"    , "C" , "" , 1 } )
        AADD( _aRet , { "D1_EMISSAO "  , "DT EMISSAO"    , "D" , "" , 1 } )
    Else

        AADD( _aRet , { "D2_FILIA "   , "FILIAL"       , "C" , "" , 2 } )
        AADD( _aRet , { "D2_COD "     , "CODIGO"       , "C" , "" , 2 } )
        AADD( _aRet , { "B1_DESC "    , "DESCRICAO"    , "C" , "" , 2 } )
        AADD( _aRet , { "D2_PRCVEN "  , "VLR.UNITARIO" , "N" , "" , 2 } )
        AADD( _aRet , { "D2_TES    "  , "TIPO SAIDA"   , "C" , "" , 2 } )      
        AADD( _aRet , { "D2_NUMSEQ "  , "NUM.SEQUENC"  , "C" , "" , 2 } )
        AADD( _aRet , { "D2_EMISSAO"  , "EMISSAO"      , "D" , "" , 1 } )
        AADD( _aRet , { "D2_CCUSTO "  , "CENTRO CUSTO" , "C" , "" , 1 } )
        AADD( _aRet , { "CTT_DESC01 " , "DESC CUSTO "  , "C" , "" , 1 } )
        AADD( _aRet , { "D2_QUANT"    , "QUANTIDADE"   , "N" , "" , 1 } )
        AADD( _aRet , { "D2_CLIENTE"  , "CLIENTE"      , "C" , "" , 1 } )
        AADD( _aRet , { "A1_NOME "    , "NOME"         , "C" , "" , 1 } )
        AADD( _aRet , { "D2_TOTAL"    , "VLR.TOTAL"    , "N" , "" , 1 } )
        AADD( _aRet , { "D2_UM"       , "UNIDADE"      , "C" , "" , 1 } )
        AADD( _aRet , { "D2_DESC"     , "DESCRIÇAO"    , "N" , "" , 3 } )
        AADD( _aRet , { "D2_EST"      , "ESTADO DEST"  , "C" , "" , 3 } )
        AADD( _aRet , { "D2_LOJA"     , "LOJA"         , "C" , "" , 3 } )
        AADD( _aRet , { "D2_PEDIDO"   , "PEDIDO"       , "C" , "" , 3 } )
        AADD( _aRet , { "D2_CONTA"    , "CONTA"        , "C" , "" , 3 } )
        

    EndIf
Return( _aRet )
/**************************************************************************************************
{Protheus.doc} fRealNotas
@description	Nota fiscal de Entrada e Saida
@type   		Funcao	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		12/08/2022
@database		12/08/2022
@country		Brasil
@language		PT-BR
@obs			12/08/2022 - Controle de documentacao
@return		    Nil
*****************************************************************************************************/
Static Function fQuery( _aCabec )

Local _aRet     := {}
Local _cQuery   := ""
Local _cAlias   := GetNextAlias()

    If MV_PAR01 == "1"

        _cQuery := " SELECT  "
        _cQuery += " D1_COD, "
        _cQuery += " B1_DESC,  "
        _cQuery += " D1_ITEM, " 
        _cQuery += " D1_FILIAL, "
        _cQuery += " D1_VUNIT, " 
        _cQuery += " D1_TOTAL, "
        _cQuery += " D1_QUANT, "
        _cQuery += " D1_CF, " 
        _cQuery += " D1_CC, "
        _cQuery += " CTT_DESC01, "
        _cQuery += " D1_FORNECE, "
        _cQuery += " A2_NOME, "
        _cQuery += " D1_LOCAL, " 
        _cQuery += " D1_DTDIGIT,"
        _cQuery += " D1_UM,"
        _cQuery += " D1_DTVALID,"    
        _cQuery += " D1_DOC,"
        _cQuery += " D1_SEGUM, "
        _cQuery += " D1_EMISSAO "
        _cQuery += " FROM "+ RetSqlName("SD1")+ " D1"
        _cQuery += " INNER JOIN "+ RetSqlName("CTT")+ " AS CTT ON " + RetSqlDel("CTT")+" AND CTT_CUSTO = D1_CC "
        _cQuery += " INNER JOIN "+ RetSqlName("SB1")+ " AS SB1 ON " + RetSqlDel("SB1")+" AND B1_COD = D1_COD "
        _cQuery += " INNER JOIN "+ RetSqlName("SA2")+ " AS SA2 ON " + RetSqlDel("SA2")+" AND A2_COD = D1_FORNECE AND A2_LOJA = D1_LOJA "
        _cQuery += " WHERE "
        _cQuery += " D1.D_E_L_E_T_ = '' "

        If !Empty(MV_PAR02) .AND. !Empty(MV_PAR03) // Mostra se ela esta vazia 
            _cQuery += " AND D1_CC BETWEEN  '"+MV_PAR02+"' AND '"+MV_PAR03+"' "
        EndIf

        If !Empty(MV_PAR04) .AND. !Empty(MV_PAR05) // Mostra se ela esta vazia 
            _cQuery += " AND D1_COD BETWEEN  '"+MV_PAR04+"' AND '"+MV_PAR05+"' "
        EndIf

        If !Empty(MV_PAR06) .AND. !Empty(MV_PAR07) // Mostra se ela esta vazia 
            _cQuery += " AND D1_FILIAL BETWEEN  '"+MV_PAR06+"' AND '"+MV_PAR07+"' "
        EndIf

        If !Empty(MV_PAR08) .AND. !Empty(MV_PAR09) // Mostra se ela esta vazia 
           _cQuery += " AND D1_EMISSAO BETWEEN  '"+Dtos(MV_PAR08)+"' AND '"+Dtos(MV_PAR09)+"' "
        EndIf

    Else
        _cQuery := " SELECT  "
        _cQuery += " D2_FILIAL, "
        _cQuery += " D2_COD,  "
        _cQuery += " B1_DESC,  "
        _cQuery += " D2_PRCVEN,  "
        _cQuery += " D2_TES,  "
        _cQuery += " D2_NUMSEQ,  "
        _cQuery += " D2_EMISSAO,  "
        _cQuery += " D2_CCUSTO, "
        _cQuery += " CTT_DESC01, "
        _cQuery += " D2_QUANT, "
        _cQuery += " D2_CLIENTE, "
        _cQuery += " A1_NOME, "
        _cQuery += " D2_TOTAL ,"
        _cQuery += " D2_UM ,"
        _cQuery += " D2_DESC, "
        _cQuery += " D2_EST, "
        _cQuery += " D2_LOJA ,"
        _cQuery += " D2_PEDIDO , "
        _cQuery += " D2_CONTA  "
        _cQuery += " FROM "+ RetSqlName("SD2")+ " D2"
        _cQuery += " INNER JOIN "+ RetSqlName("SA1")+ " AS SA1 ON " + RetSqlDel("SA1")+" AND A1_COD = D2_CLIENTE AND A1_LOJA = D2_LOJA  "
        _cQuery += " INNER JOIN "+ RetSqlName("CTT")+ " AS CTT ON " + RetSqlDel("CTT")+" AND CTT_CUSTO = D2_CCUSTO "
        _cQuery += " INNER JOIN "+ RetSqlName("SB1")+ " AS SB1 ON " + RetSqlDel("SB1")+" AND B1_COD = D2_COD "
        _cQuery += " WHERE "
        _cQuery += " D2.D_E_L_E_T_ = '' " 

        If !Empty(MV_PAR02) .AND. !Empty(MV_PAR03) // Mostra se ela esta vazia 
            _cQuery += " AND D2_CCUSTO BETWEEN  '"+MV_PAR02+"' AND '"+MV_PAR03+"' "
        EndIf

        If !Empty(MV_PAR04) .AND. !Empty(MV_PAR05) // Mostra se ela esta vazia 
            _cQuery += " AND D2_COD BETWEEN  '"+MV_PAR04+"' AND '"+MV_PAR05+"' "
        EndIf

        If !Empty(MV_PAR06) .AND. !Empty(MV_PAR07) // Mostra se ela esta vazia 
            _cQuery += " AND D2_FILIAL BETWEEN  '"+MV_PAR06+"' AND '"+MV_PAR07+"' "
        EndIf

        If !Empty(MV_PAR08) .AND. !Empty(MV_PAR09) // Mostra se ela esta vazia 
           _cQuery += " AND D2_EMISSAO BETWEEN  '"+Dtos(MV_PAR08)+"' AND '"+Dtos(MV_PAR09)+"' "
        EndIf

    EndIf

        If Select( _cAlias ) > 0
            (_cAlias)->( DBCloseArea() )//fecha o alias 
        EndIf

        DBUseArea( .T. , "TOPCONN" , TcGenQry(,,_cQuery) , _cAlias , .T. , .F. )

        DBSelectArea(_cAlias)
        (_cAlias)->( DBGoTop() )
        While (_cAlias)->( !Eof() )

            If MV_PAR01 == "1"

                AADD( _aRet ,{ fDefineType( (_cAlias)->D1_COD      , _aCabec , 01 ) ,;
                               fDefineType( (_cAlias)->B1_DESC     , _aCabec , 02 ) ,;
                               fDefineType( (_cAlias)->D1_ITEM     , _aCabec , 03 ) ,;
                               fDefineType( (_cAlias)->D1_FILIAL   , _aCabec , 04 ) ,;
                               fDefineType( (_cAlias)->D1_VUNIT    , _aCabec , 05 ) ,;
                               fDefineType( (_cAlias)->D1_TOTAL    , _aCabec , 06 ) ,;
                               fDefineType( (_cAlias)->D1_QUANT    , _aCabec , 07 ) ,;
                               fDefineType( (_cAlias)->D1_CF       , _aCabec , 08 ) ,;
                               fDefineType( (_cAlias)->D1_CC       , _aCabec , 09 ) ,;
                               fDefineType( (_cAlias)->CTT_DESC01  , _aCabec , 10 ) ,;
                               fDefineType( (_cAlias)->D1_FORNECE  , _aCabec , 11 ) ,;
                               fDefineType( (_cAlias)->A2_NOME     , _aCabec , 12 ) ,;
                               fDefineType( (_cAlias)->D1_LOCAL    , _aCabec , 13 ) ,;
                               fDefineType( (_cAlias)->D1_DTDIGIT  , _aCabec , 14 ) ,;
                               fDefineType( (_cAlias)->D1_UM       , _aCabec , 15 ) ,;
                               fDefineType( (_cAlias)->D1_DTVALID  , _aCabec , 16 ) ,;
                               fDefineType( (_cAlias)->D1_DOC      , _aCabec , 17 ) ,; 
                               fDefineType( (_cAlias)->D1_SEGUM    , _aCabec , 18 ) ,;
                               fDefineType( (_cAlias)->D1_EMISSAO  , _aCabec , 19 ) })
            Else
                AADD( _aRet ,{ fDefineType( (_cAlias)->D2_FILIAL  , _aCabec , 01 ) ,;
                               fDefineType( (_cAlias)->D2_COD     , _aCabec , 02 ) ,;
                               fDefineType( (_cAlias)->B1_DESC    , _aCabec , 03 ) ,;
                               fDefineType( (_cAlias)->D2_PRCVEN  , _aCabec , 04 ) ,;
                               fDefineType( (_cAlias)->D2_TES     , _aCabec , 05 ) ,;
                               fDefineType( (_cAlias)->D2_NUMSEQ  , _aCabec , 06 ) ,;
                               fDefineType( (_cAlias)->D2_EMISSAO , _aCabec , 07 ) ,;
                               fDefineType( (_cAlias)->D2_CCUSTO  , _aCabec , 08 ) ,;
                               fDefineType( (_cAlias)->CTT_DESC01 , _aCabec , 09 ) ,;
                               fDefineType( (_cAlias)->D2_QUANT   , _aCabec , 10 ) ,;
                               fDefineType( (_cAlias)->D2_CLIENTE , _aCabec , 11 ) ,;
                               fDefineType( (_cAlias)->A1_NOME    , _aCabec , 12 ) ,;
                               fDefineType( (_cAlias)->D2_TOTAL   , _aCabec , 13 ) ,;
                               fDefineType( (_cAlias)->D2_UM      , _aCabec , 14 ) ,;
                               fDefineType( (_cAlias)->D2_DESC    , _aCabec , 15 ) ,;
                               fDefineType( (_cAlias)->D2_EST     , _aCabec , 16 ) ,;
                               fDefineType( (_cAlias)->D2_LOJA    , _aCabec , 17 ) ,;
                               fDefineType( (_cAlias)->D2_PEDIDO  , _aCabec , 18 ) ,;
                               fDefineType( (_cAlias)->D2_CONTA   , _aCabec , 19 ) })
                               

            EndIf
                                 
                (_cAlias)->( DBSkip() )
    EndDo

Return( _aRet )
/**************************************************************************************************
{Protheus.doc} fRealNotas
@description	Nota fiscal de Entrada e Saida
@type   		Funcao	
@author			Matheus Rocha Vieira
@version   		1.00
@since     		12/08/2022
@database		12/08/2022
@country		Brasil
@language		PT-BR
@obs			12/08/2022 - Controle de documentacao
@return		    Nil
*****************************************************************************************************/
Static Function fDefineType( _xValor , _aCabec , _nPos )

Local _xRet := NIL

    Do Case
        Case _aCabec[_nPos][03] == "C" ; _xRet := AllTrim(    _xValor )//caracter
        Case _aCabec[_nPos][03] == "D" ; _xRet := DTOC( STOD( _xValor ) )//data
        Case _aCabec[_nPos][03] == "N" ; _xRet := Transform(  _xValor , _aCabec[_nPos][04] )//numero
    EndCase

Return( _xRet )

