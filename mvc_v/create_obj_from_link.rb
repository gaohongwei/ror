= link_to('Send Feedback', 
    messages_path(message: {to_str: feedback_email,  domain: domain, subject: feedback_subject, body:feedback_body }), 
    remote: true, 
    method: :post, 
    id: 'send_feedback')
