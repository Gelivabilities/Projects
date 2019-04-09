function ans=RankWithoutReply(vector)
    [A1,weizi] = sort(vector);
    [A2,ans] = sort(weizi);
    ans = size(vector,1)-ans+1;
end