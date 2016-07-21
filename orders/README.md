# CSV Importing

This is a simplified version of a piece of functionality. Our customers are medical equipment companies, called DMES. DMEs (Durable Medical Equipment Company) use many different billing systems, some commercial, some homegrown, some are even just an excel spreadsheet. We give various options for synchronizing this data, one option is the DME can send us CSV files each time things change, and we'll process the CSV to make the appropriate changes.

In this problem we're only going to consider three data types: Patients, Orders, and Invoices. Invoices is a join between Patients and Orders.

 * patient columns: patient_id, patient_name, state
 * order columns: order_id, category, state
 * invoice columns: patient_id, order_id, state

For all data types, state is in ['active', 'deleted']. The patient_id and order_id are globally unique, so a new id means a new record, an id they've seen before means an update to an existing record.

Attached is a .zip of CSVs. You should write a program that processes the files in order. You'll need to determine the type of data in the csv based on the headers in the first row. At the end, you need to spit out a list of active orders, and for each order a list of active patients with active invoices in that order. You only have to display the order category, and for patients, the name of the patient is fine in the list.

Watch out for quoting problems if you try to parse the CSVs by hand. An active invoice might point to a deleted patient, and invoices may be deleted as well. Column order in the CSV is unspecified, one patient csv may be ordered differently than the next.

Write automated tests that you think are acceptable to cover the expected behavior as if this was being pushed out to production.

The frontend doesn't have to be flashy, but since we're a web app, we expect the UI to be in the form of a web page. The UI does not need to be editable, just display it read-only.

Some gotchas:

 * Some of the invoices are invalid (reference non-existing patient or order). Think of a solution to handle this, and document your thoughts either in the code where it’s happening, or in your Readme.
 * Don’t feel the need to do any extra credit or other features, we know you guys have busy lives. Try to keep it simple.
