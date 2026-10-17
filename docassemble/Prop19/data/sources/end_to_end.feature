@end_to_end
Feature: Single beneficiary Prop 19

  # Seeded with ALDashboard's static fixture generator, then reviewed against the interview.
  Scenario: Complete the interview and reach its final document screen
    Given I start the interview at "PROP19.yml"
    And the maximum seconds for each Step in this Scenario is 240
    And the user gets to "download PROP19" with this data:
      | var | value |
      | decedent.name.first | John |
      | decedent.name.last | Smith |
      | first_beneficiary.name.first | Jane |
      | first_beneficiary.name.last | Smith |
      | client.name.first | Jane |
      | client.name.last | Smith |
      | client_address.address | 123 Shattuck Avenue |
      | client_address.city | Berkeley |
      | client_address.state | CA |
      | client_address.zip | 94704 |
      | parcel.address | 123 Shattuck Avenue |
      | parcel.city | Berkeley |
      | parcel.state | CA |
      | parcel.zip | 94704 |
      | does_bene2_exist | False |
      | users[0].name.first | Jane |
      | users[0].name.last | Smith |
      | parcel.apn | 1234-567-890 |
      | decedent.death_date | 01/02/2025 |
      | future_occupancy_date | 01/02/2026 |
    Then I should see the phrase "ready to download and deliver."
    And I download "PROP19.pdf"
