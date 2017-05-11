%K nearest neightbors character classification

function KNNChars()

	%get data from image file and flatten it
    function Im = get_imag_as_row_vec(filename)

        Im = imread(filename);
        Im = Im(:)';
        Im = double(Im);
    end

	%get all images in a folder belonging to a class as a row matrix of observations
    function [data, classinfo] = loadClassTrainingData(type, class, classData, classindex)
        
        %count number of files in folder
        samples = dir(strcat('samples/', type, '/', class));
        samples = samples(~logical([samples(:).isdir]));
        sample_range = min([20, size(samples, 1)]);
        
        data = zeros(sample_range, 32^2);
        classinfo = classData;
        
        for j = 1:sample_range
            filename = ['samples\\', type, '\\', class, '\\', samples(j).name];
            
            if(~isdir(filename))
                classinfo = [classinfo; classindex];
                data(j, :) = get_imag_as_row_vec(filename);
            end
        end
    end

    function error = count_errors(results, targets)
    
        assert(max(size(results)) == max(size(targets)), 'length of result vector of classification must equal target vector');
        error = 0;
        for i = 1:max(size(results))
            switch results(i)

                case 3
                    error = error + ~(targets(i) == 39);
            end
        end
    end

	%create matrix of observations and corresponding training targets
    type = 'typed';
    trainingClass = dir(['samples/', type]);
    trainingClass = trainingClass([1:26, 29:end]);
    
    observations = zeros(0, 32^2);
    classinfo = zeros(0, 1);
    classes = cell(0, 1);
    
    for i = 1:size(trainingClass, 1)
        
        [data, classinfo] = loadClassTrainingData(type, trainingClass(i).name, classinfo, i);
        observations = [observations; data];
        classes{i, 1} = trainingClass(i).name;
    end
    
	%create row matrix of test samples
    testData = dir('samples/TestData');
    testData = testData([1:26, 29:end]);
    classInfoTest = zeros(0, 1);
    dataTest = zeros(size(testData, 1), 32^2);
    
    for i = 1:size(testData, 1)
        filename = ['samples/TestData/', testData(i).name];
        classInfoTest = [classInfoTest; i];
        dataTest(i, :) = get_imag_as_row_vec(filename);
    end
    
    test_results = Nearest_Neighbor(observations', classinfo', dataTest', 3);
    
    for i = 1:size(test_results, 2)
        disp([num2str(test_results(1, i)), ' ', classes{test_results(1, i), 1}, classes{i, 1}, num2str(i)])
    end
    
	%Compute error
    comp = test_results - classInfoTest';
    err_rate = nnz(comp) / size(test_results, 2);
    disp(err_rate)
end
