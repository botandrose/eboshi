module ShallowRouteHelper
  def invoices_path(client, options = {})
    client_invoices_path(client, options)
  end

  def invoice_path(invoice, options = {})
    client_invoice_path(invoice.client, invoice, options)
  end

  def new_invoice_path(client, options = {})
    new_client_invoice_path(client, options)
  end

  def edit_invoice_path(invoice, options = {})
    edit_client_invoice_path(invoice.client, invoice, options)
  end

  def payments_path(invoice, options = {})
    client_invoice_payments_path(invoice.client, invoice, options)
  end

  def new_payment_path(invoice, options = {})
    new_client_invoice_payment_path(invoice.client, invoice, options)
  end

  def new_adjustment_path(adjustment, options = {})
    new_client_adjustment_path(adjustment.client, adjustment, options)
  end

  def edit_adjustment_path(adjustment, options = {})
    edit_client_adjustment_path(adjustment.client, adjustment, options)
  end

  def work_path(work, options = {})
    client_work_path(work.client, work, options)
  end

  def edit_work_path(work, options = {})
    edit_client_work_path(work.client, work, options)
  end

  def merge_works_path(client, options = {})
    merge_client_works_path(client, options)
  end

  def convert_work_path(work, options = {})
    convert_client_work_path(work.client, work, options)
  end

  def line_item_path(work, options = {})
    client_line_item_path(work.client, work, options)
  end

  def assignments_path(client, options = {})
    client_assignments_path(client, options)
  end

  def assignment_path(assignment, options = {})
    client_assignment_path(assignment.client, assignment, options)
  end

  def new_assignment_path(client, options = {})
    new_client_assignment_path(client, options)
  end
end
