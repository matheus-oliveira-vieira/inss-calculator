module Pagination
  def paginate(collection:, params: {})
    pagination = PaginationService.new(collection, params)

    [ pagination.metadata, pagination.results ]
  end
end
