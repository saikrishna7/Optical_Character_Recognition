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
            error_old = error;
            switch results(i)

                case 3%lowercase C and uppercase C are indistinguishable
                    error = error + ~(targets(i) == 39 || targets(i) == 3);
                case 12%lowercase L, uppercase I, and 1 are indistinguishable
                    error = error + ~(targets(i) == 28 || targets(i) == 45 || targets(i) == 12);
                case 15%lowercase O, uppercase O and 0 are indistinguishable
                    error = error + ~(targets(i) == 27 || targets(i) == 51 || targets(i) == 15);
                case 16%lowercase P and uppercase P are indistinguishable
                    error = error + ~(targets(i) == 52 || targets(i) == 16);
                case 19%lowercase S and uppercase S are indistinguishable
                    error = error + ~(targets(i) == 55 || targets(i) ==  19);
                case 22%lowercase V and uppercase V are indistinguishable
                    error = error + ~(targets(i) == 58 || targets(i) == 22);
                case 23%lowercase W and uppercase W are indistinguishable
                    error = error + ~(targets(i) == 59 || targets(i) == 23);
                case 24%lowercase X and uppercase X are indistinguishable
                    error = error + ~(targets(i) == 60 || targets(i) == 24);
                case 26%lowercase Z and uppercase Z are indistinguishable
                    error = error + ~(targets(i) == 62 || targets(i) == 26);
                case 27%lowercase O, uppercase O and 0 are indistinguishable
                    error = error + ~(targets(i) == 15 || targets(i) == 51 || targets(i) == 27);
                case 28%lowercase L, uppercase I, and 1 are indistinguishable
                    error = error + ~(targets(i) == 12 || targets(i) == 45 || targets(i) == 28);
                case 39%lowercase C and uppercase C are indistinguishable
                    error = error + ~(targets(i) == 3 || targets(i) == 39);
                case 45%lowercase L, uppercase I, and 1 are indistinguishable
                    error = error + ~(targets(i) == 28 || targets(i) == 12 || targets(i) == 45);
                case 51%lowercase O, uppercase O and 0 are indistinguishable
                    error = error + ~(targets(i) == 27 || targets(i) == 15 || targets(i) == 51);
                case 52%lowercase P and uppercase P are indistinguishable
                    error = error + ~(targets(i) == 16 || targets(i) == 52);
                case 55%lowercase S and uppercase S are indistinguishable
                    error = error + ~(targets(i) == 19 || targets(i) == 55);
                case 58%lowercase V and uppercase V are indistinguishable
                    error = error + ~(targets(i) == 22 || targets(i) == 58);
                case 59%lowercase W and uppercase W are indistinguishable
                    error = error + ~(targets(i) == 23 || targets(i) == 59);
                case 60%lowercase X and uppercase X are indistinguishable
                    error = error + ~(targets(i) == 24 || targets(i) == 60);
                case 62%lowercase Z and uppercase Z are indistinguishable
                    error = error + ~(targets(i) == 26 || targets(i) == 62);
                otherwise
                    error = error + (results(i) ~= targets(i));
            end
        end
    end

	%create matrix of observations and corresponding training targets
    type = 'written';
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
    targets = zeros(0, 1);
    dataTest = zeros(size(testData, 1), 32^2);
    
    for i = 1:size(testData, 1)
        filename = ['samples/TestData/', testData(i).name];
        targets = [targets; i];
        dataTest(i, :) = get_imag_as_row_vec(filename);
    end
    
    test_results = Nearest_Neighbor(observations', classinfo', dataTest', 1);%dataTest', 1);
    
    for i = 1:size(test_results, 2)
        disp([num2str(test_results(1, i)), ' ', classes{test_results(1, i), 1}, ' ', classes{i, 1}, ' ', num2str(i)])
    end
    
	%Compute error
    err_rate = count_errors(test_results, targets) / size(test_results, 2);
    disp(err_rate)
end
