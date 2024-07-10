//namespace my.Library;

using {managed} from '@sap/cds/common';

context my.Library {

    entity Books : managed {
            @Common.Label: 'UUID'
        key ID      : UUID @(Core.Computed: true); // Auto Id

            @mandatory
            Title   : localized String;

            @mandatory
            Pages   : Integer;
            Authors : Composition of many Books.Authors
                          on Authors.Book = $self;
            Copies  : Composition of many Books.Copies
                          on Copies.Book = $self;
    }

    entity Books.Authors {
        key Author : Association to one Authors @assert.target; //Ensure Foreign Key input
        key Book   : Association to one Books;
    }

    entity Books.Copies : managed {
        key CopyID              : Integer;
        key Book                : Association to one Books;

            @mandatory
            Status              : Association to one BookCopyStatus @assert.target;
            ReservedFrom        : DateTime;
            ReservedUntil       : DateTime;
            virtual Criticality : Integer;
    }

    entity BookCopyStatus {
            @Common.Label: 'UUID'
        key ID   : Integer;
            Text : localized String;
    }

    entity Authors : managed {
            @Common.Label: 'UUID'
        key ID               : Integer;
            FirstName        : String;
            LastName         : String;
            virtual FullName : String;
    }

}

@cds.persistence.exists
@cds.persistence.calcview
entity CV_BOOKSREPORT2 {
        CREATEDAT       : Timestamp    @title: 'CREATEDAT: CREATEDAT';
        CREATEDBY       : String(255)  @title: 'CREATEDBY: CREATEDBY';
        MODIFIEDAT      : Timestamp    @title: 'MODIFIEDAT: MODIFIEDAT';
        MODIFIEDBY      : String(255)  @title: 'MODIFIEDBY: MODIFIEDBY';
    key ID              : String(36)   @title: 'ID: ID';
        TITLE           : String(5000) @title: 'TITLE: TITLE';
        PAGES           : Integer      @title: 'PAGES: PAGES';
        TOTALOFPAGES    : Integer64    @title: 'TOTALOFPAGES: TOTALOFPAGES';
        AVAILABLECOPIES : Integer64    @title: 'AVAILABLECOPIES: AVAILABLECOPIES';
}

@cds.persistence.exists
@cds.persistence.calcview
entity CV_BOOKSREPORT {
        CREATEDAT              : Timestamp    @title: 'Created At';
        CREATEDBY              : String(255)  @title: 'Created By';
        MODIFIEDAT             : Timestamp    @title: 'Changed At';
        MODIFIEDBY             : String(255)  @title: 'Changed By';
    key ID                     : String(36)   @title: 'ID';
        TITLE                  : String(5000) @title: 'Title';
        PAGES                  : Integer      @title: 'Pages';
        TotalOfAvailableCopies : Integer64    @title: 'TotalOfAvailableCopies';
        TotalOfCopies          : Integer64    @title: 'TotalOfCopies';
        PERCENTAGE_OF_AVAIL    : Integer      @title: 'Percentage of available copies';
}

@cds.persistence.exists
@cds.persistence.calcview
entity CV_AVAILABLEBOOKSFORRESERVATION {
        CREATEDAT              : Timestamp    @title: 'CREATEDAT: CREATEDAT';
        CREATEDBY              : String(255)  @title: 'CREATEDBY: CREATEDBY';
        MODIFIEDAT             : Timestamp    @title: 'MODIFIEDAT: MODIFIEDAT';
        MODIFIEDBY             : String(255)  @title: 'MODIFIEDBY: MODIFIEDBY';
    key ID                     : String(36)   @title: 'ID: ID';
        TITLE                  : String(5000) @title: 'TITLE: TITLE';
        PAGES                  : Integer      @title: 'PAGES: PAGES';
        TOTALOFCOPIES          : Integer64    @title: 'TOTALOFCOPIES: TOTALOFCOPIES';
        TOTALOFAVAILABLECOPIES : Integer64    @title: 'TOTALOFAVAILABLECOPIES: TOTALOFAVAILABLECOPIES';
        PERCENTAGE_OF_AVAIL    : Integer      @title: 'PERCENTAGE_OF_AVAIL: Percentage of available copies';
        AUTHORS_FULLNAME       : String(1000) @title: 'AUTHORS_FULLNAME: AUTHORS_FULLNAME';
}
