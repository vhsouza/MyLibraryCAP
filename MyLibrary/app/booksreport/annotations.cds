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
        }
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
