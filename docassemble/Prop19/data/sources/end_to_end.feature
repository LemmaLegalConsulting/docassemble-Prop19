@end_to_end
Feature: Single beneficiary Prop 19

  # Seeded with ALDashboard's static fixture generator, then reviewed against the interview.
  Scenario: Complete the interview and reach its final document screen
    Given I start the interview at "PROP19.yml"
    And the maximum seconds for each Step in this Scenario is 240
    And the user gets to "download PROP19" with this data:
      | var | value |
      | acknowledged_information_use | True |
      | decedent.name.first | John |
      | decedent.name.last | Smith |
      | decedent.address.address | 123 Main Street |
      | decedent.address.city | Boston |
      | decedent.address.state | MA |
      | decedent.address.zip | 02108 |
      | first_beneficiary.name.first | Jane |
      | first_beneficiary.name.last | Smith |
      | first_beneficiary.address.address | 123 Main Street |
      | first_beneficiary.address.city | Boston |
      | first_beneficiary.address.state | MA |
      | first_beneficiary.address.zip | 02108 |
      | client.name.first | Jane |
      | client.name.last | Smith |
      | client.address.address | 123 Main Street |
      | client.address.city | Boston |
      | client.address.state | MA |
      | client.address.zip | 02108 |
      | client_address.address | 123 Main Street |
      | client_address.city | Boston |
      | client_address.state | MA |
      | client_address.zip | 02108 |
      | parcel.address | 123 Main Street |
      | parcel.city | Boston |
      | parcel.state | MA |
      | parcel.zip | 02108 |
      | does_bene2_exist | False |
      | parcel.apn | 1234-567-890 |
      | decedent.death_date | 01/02/2025 |
      | were_others_excludable | False |
      | future_occupancy_date | 01/02/2026 |
    Then I should see the phrase "ready to download and deliver."
