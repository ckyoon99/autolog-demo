
typeof(console) === "object" ? console.log('activexAdp start') : '';

var activexAdp = function (CertManX) {
    'use strict';

    function RemoveFromMedia(pszUserID, callback) {
        var RemoveFromMedia = CertManX.RemoveFromMedia(pszUserID);
        callback(RemoveFromMedia);
    }

    function CertManager_CertNew(pszUserID, pszPassword, callback) {
        var ex = CertManX.CertManager_CertNew(pszUserID, pszPassword);
        callback(ex);
    }

    function SetMatchedContext(pszUserID, pszSuffix) {
        return CertManX.SetMatchedContext(pszUserID, pszSuffix);
    }

    function UnSetMatchedContext(callback) {
        var result = CertManX.UnSetMatchedContext();
        callback(result);
    }

    function SetMatchedContextExt(pszUserID, pszSuffix, pszPassword, type, callback) {
        var dn = CertManX.SetMatchedContextExt(pszUserID, pszSuffix, pszPassword, type);
        callback(dn);
    }

    function SetServiceMode(host, mode) {
        return CertManX.SetServiceMode(host, mode);
    }

    function ClearSessionService(host, service) {
        return CertManX.ClearSessionService(host, service);
    }

    function SetSessionServicePort(port) {
        return CertManX.SetSessionServicePort(port);
    }

    function SetWrongPasswordLimit(count) {
        return CertManX.SetWrongPasswordLimit(count);
    }

    function GetLastErrorCode() {
        return CertManX.GetLastErrorCode();
    }

    function GetLastErrorMsg() {
        return CertManX.GetLastErrorMsg();
    }

    function GetPCIdentity(input, mode, callback) {
        var ret = CertManX.GetPCIdentity(input, mode);
        callback(ret);
    }

    function GetToken(pString, pToken) {
        return CertManX.GetToken(pString, pToken);
    }

    function SetDeviceOrder(pOrderStr) {
        return CertManX.SetDeviceOrder(pOrderStr);
    }

    function SetPasswordEncMode(mode) {
        return CertManX.SetPasswordEncMode(mode);
    }

    function SetExipreCheckSkip(flag) {
        return CertManX.SetExipreCheckSkip(flag);
    }

    // HARD_DISK('H'), REMOVABLE('R'),   PKCS11_KEY('U'), SMART_CARD('S')
    function SetDeviceViewOrder(pViewOrderStr) {
        return CertManX.SetDeviceViewOrder(pViewOrderStr);
    }

    function SetPolicyFilter(mode, pszOID) {
        return CertManX.SetPolicyFilter(mode, pszOID);
    }

    function SetWebAccMode(mode) {
        return CertManX.SetWebAccMode(mode);
    }

    function SetScanByDialogChoiceMode(mode) {
        return CertManX.SetScanByDialogChoiceMode(mode);
    }

    function SetLanguageMode(Mode) {
        return CertManX.SetLanguageMode(Mode);
    }

    function SetKeySaferMode(mode) {
        return CertManX.SetKeySaferMode(mode);
    }

    function VerifyDataB64(pB64Signature, mode, callback) {
        var verifydata = CertManX.VerifyDataB64(pB64Signature, mode);
        callback(verifydata);
    }

    function SignDataB64(pPassword, pPlainText, mode, callback) {
        var signdata = CertManX.SignDataB64(pPassword, pPlainText, mode);
        callback(signdata);
    }

    function SignDataNextB64(pPassword, pPlainText, mode) {
        return CertManX.SignDataNextB64(pPassword, pPlainText, mode);
    }

    function SignData_ne_B64(pPassword, pPlainText, mode, callback) {
        var nesigndata = CertManX.SignData_ne_B64(pPassword, pPlainText, mode);
        callback(nesigndata);
    }

    function CertManager_Issue(pszRefNo, pszAuthCode, pszUserID, pszPassword, callback) {
        var issue = CertManX.CertManager_Issue(pszRefNo, pszAuthCode, pszUserID, pszPassword);
        callback(issue);
    }

    function CertManager_Suspend(pszUserID, pszPassword, callback) {
        var ex = CertManX.CertManager_Suspend(pszUserID, pszPassword);
        callback(ex);
    }

    function CertManager_Revoke(pszUserID, pszPassword, callback) {
        var ex = CertManX.CertManager_Revoke(pszUserID, pszPassword);
        callback(ex);
    }

    function CertManager_KeyNew(pszUserID, pszPassword, callback) {
        var ex = CertManX.CertManager_KeyNew(pszUserID, pszPassword);
        callback(ex);
    }

    function CertManager_Status(pszUserID, callback) {
        return CertManX.CertManager_Status(pszUserID);
    }

    function RemoveLF(pSrc) {
        return CertManX.RemoveLF(pSrc);
    }

    function SetCertNewUrlInfo(pCertNewUrl) {
        return CertManX.SetCertNewUrlInfo(pCertNewUrl);
    }

    function ExportP12(pszUserID, pszPassword, callback) {
        var ex = CertManX.ExportP12(pszUserID, pszPassword);
        callback(ex);
    }

    function ImportP12(pszPassword, callback) {
        var im = CertManX.ImportP12(pszPassword);
        callback(im);
    }

    function VerifyPassword(pszUserID, callback) {
        var verifypw = CertManX.VerifyPassword(pszUserID);
        callback(verifypw);
    }

    function CertManager_ChangePassword(pszUserID, pszOldPassword, pszNewPassword, callback) {
        var changepw = CertManX.CertManager_ChangePassword(pszUserID, pszOldPassword, pszNewPassword);
        callback(changepw);
    }

    function ChangeStorageMedia(pszUserID, callback) {
        var ChangeStorage = CertManX.ChangeStorageMedia(pszUserID);
        callback(ChangeStorage);
    }

    function trayOn(callback) {
        callback("ok");
    }

    function trayOff(callback) {
        callback("ok");
    }

    function certServiceSetup(callback) {
        callback("ok");
    }

    function ShowConfigMenuX(callback) {
        var result = CertManX.ShowConfigMenuX("");
        callback(result);
    }

    function doubleClickBlock(key) {
        return false;
    }

    function SetInfoPage(mode) {
        if (mode === 0 || mode === 1) {
            return true;
        } else {
            return false;
        }
    }

    return {
        CertManager_Issue: CertManager_Issue,
        CertManager_Suspend: CertManager_Suspend,
        CertManager_Revoke: CertManager_Revoke,
        CertManager_CertNew: CertManager_CertNew,
        CertManager_KeyNew: CertManager_KeyNew,
        CertManager_Status: CertManager_Status,
        CertManager_ChangePassword: CertManager_ChangePassword,
        ChangeStorageMedia: ChangeStorageMedia,
        RemoveFromMedia: RemoveFromMedia,
        VerifyPassword: VerifyPassword,
        ExportP12: ExportP12,
        ImportP12: ImportP12,

        GetPCIdentity: GetPCIdentity,
        UnSetMatchedContext: UnSetMatchedContext,
        SetMatchedContext: SetMatchedContext,
        SetMatchedContextExt: SetMatchedContextExt,

        GetLastErrorCode: GetLastErrorCode,
        GetLastErrorMsg: GetLastErrorMsg,
        GetToken: GetToken,
        SetDeviceOrder: SetDeviceOrder,
        SetExipreCheckSkip: SetExipreCheckSkip,
        SetDeviceViewOrder: SetDeviceViewOrder,
        SetPolicyFilter: SetPolicyFilter,

        VerifyDataB64: VerifyDataB64,
        SignDataB64: SignDataB64,
        SignData_ne_B64: SignData_ne_B64,

        SetServiceMode: SetServiceMode,
        // 추가
        SetCertNewUrlInfo: SetCertNewUrlInfo,
        ShowConfigMenuX: ShowConfigMenuX,
        TrayOn: trayOn,
        TrayOff: trayOff,
        CertServiceSetup: certServiceSetup,
        doubleClickBlock: doubleClickBlock,
        SetInfoPage: SetInfoPage,

        // 미구현
        SignDataNextB64: SignDataNextB64,
        SetLanguageMode: SetLanguageMode,
        SetKeySaferMode: SetKeySaferMode,
        SetScanByDialogChoiceMode: SetScanByDialogChoiceMode,
        SetWrongPasswordLimit: SetWrongPasswordLimit,
        SetWebAccMode: SetWebAccMode,
        SetPasswordEncMode: SetPasswordEncMode,
        SetSessionServicePort: SetSessionServicePort,
        ClearSessionService: ClearSessionService,
        RemoveLF: RemoveLF
    }

};


window.getCookieForActiveX = function () {
    var cName = "koscomActiveX";
    cName = cName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cName);
    var cValue = '';
    if (start != -1) {
        start += cName.length;
        var end = cookieData.indexOf(';', start);
        if (end == -1) end = cookieData.length;
        cValue = cookieData.substring(start, end);
    }
    return unescape(cValue);
};

function loadActiveObject(CertManX) {

    // check activex
    var found = false;
    var objectTags = document.getElementsByTagName('object');
    for (i = 0; i < objectTags.length; i++) {
        if (objectTags[i].classid == "CLSID:EC5D5118-9FDE-4A3E-84F3-C2B711740E70") {
            CertManX = activexAdp(objectTags[i]);
            found = true;
            break;
        }
    }

    if (!found) { // not found
        var obj = document.createElement('object');
        obj.classid = "CLSID:EC5D5118-9FDE-4A3E-84F3-C2B711740E70";
        obj.codeBase = "http://www.signkorea.com/SKCommAX.cab#version=9,9,0,5";
        obj.width = "1";
        obj.height = "1";
        document.getElementsByTagName('head')[0].appendChild(obj);
        CertManX = activexAdp(obj);
    }
    return CertManX;
}

typeof(console) === "object" ? console.log('activexAdp end') : '';