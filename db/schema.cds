namespace my.Library;

using {managed} from '@sap/cds/common';

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
                      on Copies.Book = $self
}

entity Books.Authors {
    key Author : Association to one Authors @assert.target; //Ensure Foreign Key input
    key Book   : Association to one Books;
}

entity Books.Copies : managed {
    key CopyID        : Integer;
    key Book          : Association to one Books;

        @mandatory
        Status        : Association to one BookCopyStatus @assert.target;
        ReservedFrom  : DateTime;
        ReservedUntil : DateTime;
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
