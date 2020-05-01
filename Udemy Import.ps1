$users = import-csv "C:\Users\Tanderson\Desktop\udemy-users.csv"

Foreach ($user in $users){

    $email = $user.email
    $username = $email -replace '@tenable.com'

    If(dsquery user -samid $username) {

        If ($user.group1 -like "Administration" -Or $user.group2 -like "Applied Research"){
            Add-adgroupmember -identity "udemy - administration" -Members $username
        }

        If ($user.group1 -like "Applied Research" -Or $user.group2 -like "Applied Research"){
            Add-adgroupmember -identity "udemy - applied research" -Members $username
        }
    
        If ($user.group1 -like "Business Platforms" -Or $user.group2 -like "Business Platforms"){
            Add-adgroupmember -identity "udemy - Business Platforms" -Members $username
        }
    
        If ($user.group1 -like "Channel Sales" -Or $user.group2 -like "Channel Sales"){
           Add-adgroupmember -identity "udemy - Channel Sales" -Members $username
        }

        If ($user.group1 -like "Communications & Corporate Marketing" -Or $user.group2 -like "Communications & Corportate Marketing"){
            Add-adgroupmember -identity "udemy - Communications and Corporate Marketing" -Members $username
        }

        If ($user.group1 -like "Cloud Platforms" -Or $user.group2 -like "Communications & Corportate Marketing"){
            Add-adgroupmember -identity "udemy - cloud platforms" -Members $username
        }

        If ($user.group1 -like "Competitive Intelligence & Analyst Relations" -Or $user.group2 -like "Competitive Intelligence & Analyst Relations"){
            Add-adgroupmember -identity "udemy - Competitive Intelligence and Analyst Relations" -Members $username
        }

        If ($user.group1 -like "Corporate Real Estate" -Or $user.group2 -like "Corporate Real Estate"){
            Add-adgroupmember -identity "udemy - Corporate Real Estate" -Members $username
        }

        If ($user.group1 -like "Customer Advocacy - Admin" -Or $user.group2 -like "Customer Advocacy"){
            Add-adgroupmember -identity "udemy - Customer Advocacy" -Members $username
        }

        If ($user.group1 -like "Customer Sales" -Or $user.group2 -like "Customer Sales"){
            Add-adgroupmember -identity "udemy - Customer Sales" -Members $username
        }

        If ($user.group1 -like "Customer Success" -Or $user.group2 -like "Customer Success"){
            Add-adgroupmember -identity "udemy - Customer Success" -Members $username
        }

        If ($user.group1 -like "Digital Marketing" -Or $user.group2 -like "Digital Marketing"){
            Add-adgroupmember -identity "udemy - Digital Marketing" -Members $username
        }

        If ($user.group1 -like "Enablement" -Or $user.group2 -like "Enablement"){
            Add-adgroupmember -identity "udemy - Enablement" -Members $username
        }

        If ($user.group1 -like "Engineering" -Or $user.group2 -like "Engineering"){
            Add-adgroupmember -identity "udemy - engineering" -Members $username
        }
    
        If ($user.group1 -like "Facilities" -Or $user.group2 -like "Facilities"){
            Add-adgroupmember -identity "udemy - Facilities" -Members $username
        }
    
        If ($user.group1 -like "Federal Sales" -Or $user.group2 -like "Federal Sales"){
            Add-adgroupmember -identity "udemy - Federal Sales" -Members $username
        }
    
        If ($user.group1 -like "Field & Channel Marketing" -Or $user.group2 -like "Field & Channel Marketing"){
            Add-adgroupmember -identity "udemy - Field and Channel Marketing" -Members $username
        }
    
        If ($user.group1 -like "Finance" -Or $user.group2 -like "Finance"){
            Add-adgroupmember -identity "udemy - Finance" -Members $username
        }
    
        If ($user.group1 -like "Global Campaigns" -Or $user.group2 -like "Global Campaigns"){
            Add-adgroupmember -identity "udemy - Global Campaigns" -Members $username
        }
    
        If ($user.group1 -like "Government Affairs" -Or $user.group2 -like "Government Affairs"){
           Add-adgroupmember -identity "udemy - Government Affairs" -Members $username
        }
    
        If ($user.group1 -like "High Velocity" -Or $user.group2 -like "High Velocity"){
            Add-adgroupmember -identity "udemy - High Velocity" -Members $username
        }
        
        If ($user.group1 -like "Human Resources" -Or $user.group2 -like "Human Resources"){
            Add-adgroupmember -identity "udemy - HR" -Members $username
        }
        
        If ($user.group1 -like "Information Security" -Or $user.group2 -like "Information Security"){
            Add-adgroupmember -identity "udemy - Information Security" -Members $username
        }
        
        If ($user.group1 -like "Information Technology" -Or $user.group2 -like "Information Technology"){
            Add-adgroupmember -identity "udemy - Information Technology" -Members $username
        }
    
        If ($user.group1 -like "LATAM Channel Sales" -Or $user.group2 -like "LATAM Channel Sales"){
            Add-adgroupmember -identity "udemy - LATAM Channel Sales" -Members $username
        }
        
        If ($user.group1 -like "LATAM Lead Generation" -Or $user.group2 -like "LATAM Lead Generation"){
            Add-adgroupmember -identity "udemy - LATAM Lead Generation" -Members $username
        }
        
        If ($user.group1 -like "LATAM Sales" -Or $user.group2 -like "LATAM Sales"){
            Add-adgroupmember -identity "udemy - LATAM Sales" -Members $username
        }
        
        If ($user.group1 -like "Lead Generation" -Or $user.group2 -like "Lead Generation"){
            Add-adgroupmember -identity "udemy - Lead Generation" -Members $username
        }
        
        If ($user.group1 -like "Legal" -Or $user.group2 -like "Legal"){
            Add-adgroupmember -identity "udemy - Legal" -Members $username
        }
        
        If ($user.group1 -like "Marketing - Executive & Admin" -Or $user.group2 -like "Marketing - Executive & Admin"){
            Add-adgroupmember -identity "udemy - Marketing Executive and Admin" -Members $username
        }
        
        If ($user.group1 -like "Marketing Operations" -Or $user.group2 -like "Marketing Operations"){
            Add-adgroupmember -identity "udemy - Marketing Operations" -Members $username
        }
        
        If ($user.group1 -like "Product Management" -Or $user.group2 -like "Product Management"){
            Add-adgroupmember -identity "udemy - Product Management" -Members $username
        }
        
        If ($user.group1 -like "Product Marketing" -Or $user.group2 -like "Product Marketing"){
            Add-adgroupmember -identity "udemy - Product Marketing" -Members $username
        }
        
        If ($user.group1 -like "Product Security" -Or $user.group2 -like "Product Security"){
            Add-adgroupmember -identity "udemy - Product Security" -Members $username
        }
        
        If ($user.group1 -like "Professional Services" -Or $user.group2 -like "Professional Services"){
            Add-adgroupmember -identity "udemy - Professional Services" -Members $username
        }
        
        If ($user.group1 -like "Program Management" -Or $user.group2 -like "Program Management"){
            Add-adgroupmember -identity "udemy - Program Management" -Members $username
        }
        
        If ($user.group1 -like "Program Management Office" -Or $user.group2 -like "Program Management Office"){
            Add-adgroupmember -identity "udemy - Program Management Office" -Members $username
        }
        
        If ($user.group1 -like "Research" -Or $user.group2 -like "Research" -Or $user.group3 -like "Research"){
            Add-adgroupmember -identity "udemy - Research" -Members $username
        }
        
        If ($user.group1 -like "Research and Development" -Or $user.group2 -like "Research and Developement" -Or $user.group3 -like "Research and Development"){
            Add-adgroupmember -identity "udemy - Research and Development" -Members $username
        }
        
        If ($user.group1 -like "Sales" -Or $user.group2 -like "Sales"){
            Add-adgroupmember -identity "udemy - Sales" -Members $username
        }
        
        If ($user.group1 -like "Sales Engineering" -Or $user.group2 -like "Sales Engineering" -Or $user.group3 -like "Sales Engineering"){
            Add-adgroupmember -identity "udemy - Sales Engineering" -Members $username
        }
        
        If ($user.group1 -like "Sales Executive" -Or $user.group2 -like "Sales Executive"){
            Add-adgroupmember -identity "udemy - Sales Executive" -Members $username
        }
        
        If ($user.group1 -like "Sales Operations" -Or $user.group2 -like "Sales Operations"){
            Add-adgroupmember -identity "udemy - Sales Operations" -Members $username
        }
        
        If ($user.group1 -like "Technical Alliances - Business Development" -Or $user.group2 -like "Technical Alliances - Business Development"){
            Add-adgroupmember -identity "udemy - Technical Alliances - Business Development" -Members $username
        }
        
        If ($user.group1 -like "Technical Alliances - Architecture" -Or $user.group2 -like "Technical Alliances Architecture"){
            Add-adgroupmember -identity "udemy - Technical Alliances Arcitecture" -Members $username
        }
        
        If ($user.group1 -like "Technical Support" -Or $user.group2 -like "Technical Support" -Or $user.group3 -like "Technical Support"){
            Add-adgroupmember -identity "udemy - Technical Support" -Members $username
        }
        
        If ($user.group1 -like "Training" -Or $user.group2 -like "Training"){
            Add-adgroupmember -identity "udemy - Training" -Members $username
        }
    }
    Else{
         Write-Host "$username does not exist"
    }

} 