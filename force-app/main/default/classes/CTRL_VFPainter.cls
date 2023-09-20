public class CTRL_VFPainter {
    
    public String strImageBlob {get;set;}
    public Id objId {get;set;} 
    public String contentDocLinkId {get;set;} 
    public CTRL_VFPainter() {
        objId = ApexPages.CurrentPage().getparameters().get('ID');
    }
    
    public PageReference  getDrawing() {
        contentDocLinkId=createDocument(objId,'note '+Datetime.now().format('yyyy-MM-dd\'T\'HH:mm:ss.SSS\'Z\'')+'.png',Encodingutil.base64Decode(strImageBlob.substring(strImageBlob.indexOf(',') + 1)));
        return null;

    }
    public static Id createDocument(Id parentId, String fileName, Blob data) {
        
        ContentVersion versionData = new ContentVersion();
        versionData.ContentLocation = 'S';
        versionData.VersionData = data;
        versionData.Title = fileName;
        versionData.PathOnClient = filename;
        insert versionData;
        
        ContentDocumentLink conDocLink = new ContentDocumentLink();
        conDocLink.ContentDocumentId = [SELECT Id, ContentDocumentId FROM ContentVersion WHERE Id = :versionData.Id].ContentDocumentId;
        conDocLink.LinkedEntityId = parentId;
        conDocLink.ShareType = 'V';
        insert conDocLink;

        return conDocLink.Id;
    }
    
}