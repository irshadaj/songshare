module Site
  class PaginationSection < SitePrism::Section
    element :prev, 'a[rel=prev]'
    element :next, 'a[rel=next]'
  end
end
