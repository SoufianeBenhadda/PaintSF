@isTest
public class CTRL_VFPainter_Test {
    static testMethod void testCreateDocument() {
        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        Blob testData = Blob.valueOf('Test Data');


        Id contentDocLinkId = CTRL_VFPainter.createDocument(testAccount.Id, 'TestFile.txt', testData);


        System.assertEquals(
            [SELECT Id FROM ContentDocumentLink WHERE Id = :contentDocLinkId].Id,
            contentDocLinkId,
            'ContentDocumentLink record not created'
        );
    }

    static testMethod void testGetDrawing() {

        Account testAccount = new Account(Name = 'Test Account');
        insert testAccount;

        CTRL_VFPainter painter = new CTRL_VFPainter();
        painter.strImageBlob = 'data:image/png;base64,TestImageBase64Data';
        painter.objId = testAccount.Id;

        PageReference pageRef = painter.getDrawing();

        System.assertEquals(null, pageRef, 'PageReference should be null');
    }
}
