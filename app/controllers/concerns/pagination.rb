module Pagination
  # write useful methods for pagination on several controllers for solr

  def set_pagination_params
    @page = params[:page].blank? || params[:page].to_f.round <= 0 ? 1 : params[:page].to_f.round
    @limit = params[:limit].blank? ? default_pagination_limit : params[:limit].to_i
    @limit = @limit == 0 ? default_pagination_limit : @limit
    @offset = (@page - 1) * @limit
  end

  def default_pagination_limit
    10
  end

  def total_pages(total_count, limit)
    total_count = total_count.to_f
    limit > 0 ? (total_count / limit).ceil : (total_count / default_pagination_limit).ceil
  end
end
