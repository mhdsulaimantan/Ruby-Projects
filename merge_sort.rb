class Sort

    def initialize(list)
        @list = list
    end

    # get the result for merge sort
    def merge_sort
        return split(@list)
    end

    private 
    def split(arr)
        if arr.length <= 1
            return arr 
        end  
        
        half = arr.length/2
        left = split(arr[0..half - 1])
        right = split(arr[half..])
        merge(left, right)
    end

    private 
    def merge(left, right, list =[])
        until left.empty? and right.empty?
            if left.empty?
                list << right.first
                right.shift
            elsif right.empty?
                list << left.first
                left.shift
            else
                if left.first > right.first
                    list << right.first
                    right.shift 
                else
                    list << left.first
                    left.shift 
                end
            end
        end
        return list
    end
end

arr = [1, 3, 2, 4, 8, 6, 3]
puts Sort.new(arr).merge_sort()