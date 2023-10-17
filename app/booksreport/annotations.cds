using CatalogService as service from '../../srv/cat-service';

annotate service.CV_BooksReport with @(UI: {

    HeaderInfo             : {
        TypeName      : 'Book',
        TypeNamePlural: 'Books',
        Title         : {
            $Type: 'UI.DataField',
            Value: TITLE
        }
    },

    SelectionFields        : [
        ID,
        TITLE,
        PAGES
    ],

    LineItem               : [
        {
            $Type: 'UI.DataField',
            Label: 'Id',
            Value: ID,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Title',
            Value: TITLE,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Pages',
            Value: PAGES,
        },
        {
            $Type: 'UI.DataField',
            Label: 'Total of Copies',
            Value: TotalOfCopies,
        },
        {
            $Type                    : 'UI.DataField',
            Label                    : 'Available Copies',
            Value                    : TotalOfAvailableCopies,
            Criticality              : #Positive,
            CriticalityRepresentation: #WithoutIcon,
        },
        {
            $Type                    : 'UI.DataField',
            Label                    : '% Available Copies',
            Value                    : PERCENTAGE_OF_AVAIL,
            Criticality              : #Positive,
            CriticalityRepresentation: #WithIcon,
        },
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
            Label : 'Copies',
            ID    : 'CopiesFacet',
            Target: 'Copies/@UI.LineItem#BooksReportCopies',
        },
    ],
    FieldGroup #GeneralData: {
        $Type: 'UI.FieldGroupType',
        Data : [
            {
                $Type: 'UI.DataField',
                Label: 'Id',
                Value: ID,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Title',
                Value: TITLE,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Pages',
                Value: PAGES,
            },
            {
                $Type: 'UI.DataField',
                Label: 'Total of Copies',
                Value: TotalOfCopies,
            },
            {
                $Type                    : 'UI.DataField',
                Label                    : 'Available Copies',
                Value                    : TotalOfAvailableCopies,
                Criticality              : #Positive,
                CriticalityRepresentation: #WithIcon,
            },
            {
                $Type                    : 'UI.DataField',
                Label                    : '%Available Copies',
                Value                    : PERCENTAGE_OF_AVAIL,
                Criticality              : #Positive,
                CriticalityRepresentation: #WithIcon,
            },

        ]
    },

});

annotate service.BookCopies with @(UI: {

LineItem #BooksReportCopies: [
    {
        $Type: 'UI.DataField',
        Label: 'Copy Id',
        Value: CopyID,
    },
    {
        $Type                  : 'UI.DataField',
        Label                  : 'Status',
        Value                  : Status_ID,
        Criticality            : Criticality,
        ![@Common.FieldControl]: #Mandatory,
    },
    {
        $Type        : 'UI.DataField',
        Label        : 'Reserved From',
        Value        : ReservedFrom,
        ![@UI.Hidden]: {$edmJson: {$Eq: [
            {$Path: 'Status_ID'},
            10
        ]}},
    },
    {
        $Type        : 'UI.DataField',
        Label        : 'Reserved Until',
        Value        : ReservedUntil,
        ![@UI.Hidden]: {$edmJson: {$Eq: [
            {$Path: 'Status_ID'},
            10
        ]}},
    },
], });
