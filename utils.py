def check_availability_overlap(availabilities, new_start_date, new_end_date):
    for availability in availabilities:
        existing_start_date = availability.start_date
        existing_end_date = availability.end_date

        if (
            (existing_start_date <= new_start_date <= existing_end_date) or
            (existing_start_date <= new_end_date <= existing_end_date) or
            (new_start_date <= existing_start_date and new_end_date >= existing_end_date)
        ):
            return True
    return False