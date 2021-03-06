# Copyright (c) 2016 Microsoft Corporation. All Rights Reserved.
# Licensed under the MIT License (MIT)

Describe "Get-RsItemReference" {
        Context "Get-RsItemReference with min parameters"{

                $folderName = 'SutWriteRsFolderContentMinParameters' + [guid]::NewGuid()
                New-RsFolder -Path / -FolderName $folderName
                $folderPath = '/' + $folderName
                $localResourcesPath =   (Get-Item -Path ".\").FullName  + '\Tests\CatalogItems\testResources\emptyReport.rdl'
                Write-RsCatalogItem -Path $localResourcesPath -RsFolder $folderPath
                $report = (Get-RsFolderContent -RsFolder $folderPath )| Where-Object TypeName -eq 'Report'
                $reportReferences = Get-RsItemReference -Path $report.Path

                It "Should found a reference to a RsDataSet with min parameters" {
                   $dataSetReference = $reportReferences | Where-Object ReferenceType -eq 'DataSet'
                   $dataSetReference.Name | Should Be 'UnDataset'
                }

                It "Should found a reference to a RsDataSource with min parameters" {
                   $dataSourceReference = $reportReferences | Where-Object ReferenceType -eq 'DataSource'
                   $dataSourceReference.Name | Should Be 'SutWriteRsFolderContent_DataSource'
                }
                Remove-RsCatalogItem -RsFolder $folderPath
        }

        Context "Get-RsItemContent with Proxy parameter"{

                $folderName = 'SutWriteRsFolderContentMinParameters' + [guid]::NewGuid()
                New-RsFolder -Path / -FolderName $folderName
                $folderPath = '/' + $folderName
                $localResourcesPath =   (Get-Item -Path ".\").FullName  + '\Tests\CatalogItems\testResources\emptyReport.rdl'
                Write-RsCatalogItem -Path $localResourcesPath -RsFolder $folderPath
                $report = (Get-RsFolderContent -RsFolder $folderPath )| Where-Object TypeName -eq 'Report'
                $proxy = New-RsWebServiceProxy
                $reportReferences = Get-RsItemReference -Path $report.Path -Proxy $proxy

                It "Should found a reference to a RsDataSource of a report with Proxy Parameter" {
                   $dataSourceReference = $reportReferences | Where-Object ReferenceType -eq 'DataSource'
                   $dataSourceReference.Name | Should Be 'SutWriteRsFolderContent_DataSource'
                }
                Remove-RsCatalogItem -RsFolder $folderPath
        }

        Context "Get-RsItemContent with ReportServerUri Parameter"{

                $folderName = 'SutWriteRsFolderContentMinParameters' + [guid]::NewGuid()
                New-RsFolder -Path / -FolderName $folderName
                $folderPath = '/' + $folderName
                $localResourcesPath =   (Get-Item -Path ".\").FullName  + '\Tests\CatalogItems\testResources\emptyReport.rdl'
                Write-RsCatalogItem -Path $localResourcesPath -RsFolder $folderPath
                $report = (Get-RsFolderContent -RsFolder $folderPath )| Where-Object TypeName -eq 'Report'
                $reportServerUri = 'http://localhost/reportserver'
                $reportReferences = Get-RsItemReference -Path $report.Path -ReportServerUri $reportServerUri

                It "Should found a reference to a RsDataSource of a report with ReportServerUri Parameter" {
                   $dataSourceReference = $reportReferences | Where-Object ReferenceType -eq 'DataSource'
                   $dataSourceReference.Name | Should Be 'SutWriteRsFolderContent_DataSource'
                }
                Remove-RsCatalogItem -RsFolder $folderPath
        }

        Context "Get-RsItemContent with ReportServerUri and Proxy Parameter"{

                $folderName = 'SutWriteRsFolderContentMinParameters' + [guid]::NewGuid()
                New-RsFolder -Path / -FolderName $folderName
                $folderPath = '/' + $folderName
                $localResourcesPath =   (Get-Item -Path ".\").FullName  + '\Tests\CatalogItems\testResources\emptyReport.rdl'
                Write-RsCatalogItem -Path $localResourcesPath -RsFolder $folderPath
                $report = (Get-RsFolderContent -RsFolder $folderPath )| Where-Object TypeName -eq 'Report'
                $proxy = New-RsWebServiceProxy
                $reportServerUri = 'http://localhost/reportserver'
                $reportReferences = Get-RsItemReference -Path $report.Path -ReportServerUri $reportServerUri -Proxy $proxy

                It "Should found a reference to a RsDataSource of a report with ReportServerUri and Proxy Parameters" {
                   $dataSourceReference = $reportReferences | Where-Object ReferenceType -eq 'DataSource'
                   $dataSourceReference.Name | Should Be 'SutWriteRsFolderContent_DataSource'
                }
                Remove-RsCatalogItem -RsFolder $folderPath
        }
}