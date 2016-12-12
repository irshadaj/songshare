window.Songshare ?= {}

Songshare.alertError = (message) ->
  $('#page-body').prepend("<div class=\"alert alert-danger\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>#{message}</div>")

Songshare.alertSuccess = (message) ->
  $('#page-body').prepend("<div class=\"alert alert-success\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\" aria-label=\"Close\"><span aria-hidden=\"true\">&times;</span></button>#{message}</div>")
