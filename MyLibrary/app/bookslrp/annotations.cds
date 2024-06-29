using CatalogService as service from '../../srv/cat-service';

annotate service.Books with @odata.draft.enabled;

annotate service.Books with @(UI: {

    HeaderInfo             : {
        TypeName      : 'Book',
        TypeNamePlural: 'Books',
        Title         : {
            $Type: 'UI.DataField',
            Value: Title
        }
    },

    LineItem               : [
        {
            $Type: 'UI.DataField',
            Label: 'Id',
            Value: ID,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Title',
            Value: Title,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Pages',
            Value: Pages,
        }
    ],
    Facets                 : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'General Data',
            ID    : 'GeneralDataFacet',
            Target: '@UI.FieldGroup#GeneralData',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Authors',
            ID    : 'AuthorsFacet',
            Target: 'Authors/@UI.PresentationVariant#AuthorsPV',
        },
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Copies',
            ID    : 'CopiesFacet',
            Target: 'Copies/@UI.LineItem#Copies',
        },
    ],
    FieldGroup #GeneralData: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                Label: 'Id',
                Value: ID,
            },
            {
                Label: 'Title',
                Value: Title,
            },
            {
                Label: 'Pages',
                Value: Pages,
            }
        ]
    },

});

annotate service.BookAuthors with @(UI: {

    PresentationVariant #AuthorsPV: {
        $Type         : 'UI.PresentationVariantType',
        Visualizations: ['@UI.LineItem#AuthorsLines'],
        RequestAtLeast: [
            Author.FirstName,
            Author.LastName
        ]
    },

    HeaderInfo                    : {
        TypeName      : 'Author',
        TypeNamePlural: 'Authors',
        Title         : {
            $Type: 'UI.DataField',
            Value: Author.FullName
        }
    },

    LineItem #AuthorsLines        : [{
        $Type: 'UI.DataField',
        Label: 'ID',
        Value: Author_ID,
    }],

    Facets                        : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'General Data',
        ID    : 'GeneralDataFacet',
        Target: '@UI.FieldGroup#GeneralData',
    }],

    FieldGroup #GeneralData       : {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type                   : 'UI.DataField',
                Label                   : 'ID',
                Value                   : Author_ID,
                ![@Common.FieldControl] : #Mandatory,
            },
            {
                $Type                   : 'UI.DataField',
                Label                   : 'ID',
                Value                   : Author.FirstName,
                ![@Common.FieldControl] : #ReadOnly,
            },
            {
                $Type                   : 'UI.DataField',
                Label                   : 'ID',
                Value                   : Author.LastName,
                ![@Common.FieldControl] : #ReadOnly,
            }
        ]
    }
});

annotate service.BookCopies with @(UI: {

    LineItem #Copies       : [
        {
            $Type: 'UI.DataField',
            Label: 'Copy Id',
            Value: CopyID,
        },
        {
            $Type                   : 'UI.DataField',
            Label                   : 'Status',
            Value                   : Status_ID,
            ![@Common.FieldControl] : #Mandatory
        },
        {
            $Type         : 'UI.DataField',
            Label         : 'Reserved From',
            Value         : ReservedFrom,
            ![@UI.Hidden] : {$edmJson: {$Eq: [
                {$Path: 'Status_ID'},
                10
            ]}},
        },
        {
            $Type         : 'UI.DataField',
            Label         : 'Reserved Until',
            Value         : ReservedUntil,
            ![@UI.Hidden] : {$edmJson: {$Eq: [
                {$Path: 'Status_ID'},
                10
            ]}},
        },
    ],

    Facets                 : [{
        $Type : 'UI.ReferenceFacet',
        Label : 'General Data',
        ID    : 'GeneralDataFacet',
        Target: '@UI.FieldGroup#GeneralData',
    }],

    FieldGroup #GeneralData: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Copy Id',
                Value: CopyID,
            },
            {
                $Type                   : 'UI.DataField',
                Label                   : 'Status',
                Value                   : Status_ID,
                ![@Common.FieldControl] : #Mandatory
            },
            {
                $Type         : 'UI.DataField',
                Label         : 'Reserved From',
                Value         : ReservedFrom,
                ![@UI.Hidden] : {$edmJson: {$Eq: [
                    {$Path: 'Status_ID'},
                    10
                ]}},
            },
            {
                $Type         : 'UI.DataField',
                Label         : 'Reserved Until',
                Value         : ReservedUntil,
                ![@UI.Hidden] : {$edmJson: {$Eq: [
                    {$Path: 'Status_ID'},
                    10
                ]}},
            },
        ]
    },
});


annotate service.BookAuthors with {
    Author
    @(Common: {
        Text           : Author.FullName,
        TextArrangement: #TextLast,
        ValueList      : {
            Label         : 'Author',
            CollectionPath: 'Authors',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: Author_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'FirstName'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'LastName'
                }
            ]
        }
    });
}

annotate service.BookCopies with {
    Status
    @(Common: {
        Text           : Status.Text,
        TextArrangement: #TextOnly,
        ValueList      : {
            Label         : 'Status',
            CollectionPath: 'BookCopyStatus',
            Parameters    : [
                {
                    $Type            : 'Common.ValueListParameterInOut',
                    LocalDataProperty: Status_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type            : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'Text'
                }
            ]
        }
    });
}