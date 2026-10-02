# Implementation Plan - Booking Dashboard, Filters, and Cancellation Workflow

Refine booking filters, owner confirmation behavior (auto-canceling/deleting other bookings for the room), and cancellation capabilities for both tenants and owners.

## User Review Required

> [!IMPORTANT]
> - **Tenant Filters**: Removed "Already Rented" filter; tenants will see **All**, **Pending**, and **Confirmed**.
> - **Owner Filters**: **All**, **Pending**, and **Confirmed**.
> - **Owner Confirmation**: When an owner confirms a booking, other pending/draft bookings for the same room will be automatically cancelled and deleted (removed from UI).
> - **Cancellation**: Both tenants (for their pending/confirmed bookings) and owners (for accepted/confirmed bookings) will have the ability to cancel bookings.

## Proposed Changes

### Booking Filters & UI

#### [MODIFY] [booking_filter_chips.dart](file:///home/thet-mon/Flutter_Project/rental_room/lib/presentation/pages/booking/widgets/booking_filter_chips.dart)
- Update filter chips list for tenants to include only **All**, **Pending**, and **Confirmed** (removing "Already Rented").
- Keep owner filters as **All**, **Pending**, and **Confirmed**.

#### [MODIFY] [booking_list_content.dart](file:///home/thet-mon/Flutter_Project/rental_room/lib/presentation/pages/booking/widgets/booking_list_content.dart)
- Remove `already_rented` filter handling for tenants.
- Update filtering logic to strictly filter by `all`, `pending`, and `confirmed` for both tenant and owner.

### Booking Confirmation & Auto-Cancellation/Deletion

#### [MODIFY] [booking_data_source.dart](file:///home/thet-mon/Flutter_Project/rental_room/lib/data/datasource/remote/booking_data_source.dart)
- In `cancelOtherPendingBookingsForRoom`, when owner confirms a booking, update other pending/draft bookings for that room to `cancelled` and delete them (`doc.reference.delete()`) so they don't show up in the UI anymore.

### Cancellation Actions for Tenants and Owners

#### [MODIFY] [booking_action_section.dart](file:///home/thet-mon/Flutter_Project/rental_room/lib/presentation/pages/booking/widgets/booking_action_section.dart)
- Enable cancellation for tenants (on pending/confirmed bookings).
- Enable cancellation for owners on accepted/confirmed bookings.

#### [MODIFY] [owner_booking_detail_view.dart](file:///home/thet-mon/Flutter_Project/rental_room/lib/presentation/pages/booking/owner_booking_detail_view.dart) and [new_booking_view.dart](file:///home/thet-mon/Flutter_Project/rental_room/lib/presentation/pages/booking/new_booking_view.dart) / [booking_card.dart](file:///home/thet-mon/Flutter_Project/rental_room/lib/presentation/pages/booking/widgets/booking_card.dart)
- Wire up owner cancellation action for confirmed bookings.
- Wire up tenant cancellation action.

## Verification Plan

### Automated Tests
- Run project build & analyzer checks.

### Manual Verification
- Test tenant booking list filters (**All**, **Pending**, **Confirmed**).
- Test owner booking list filters (**All**, **Pending**, **Confirmed**).
- Test owner confirming a booking and verifying other pending bookings for that room are automatically cancelled and deleted.
- Test tenant cancelling a booking request.
- Test owner cancelling an accepted/confirmed booking request.
