# label non-sets generated with -P1 according to
# which rule is broken: span-rule or match-rule
function matchRuleBrokenInFeature(feature) {
    a = substr($1, feature, 1)
    b = substr($2, feature, 1)
    c = substr($3, feature, 1)
    return a == b && c != a
}
{
    if (matchRuleBrokenInFeature(1) || matchRuleBrokenInFeature(2) || matchRuleBrokenInFeature(3))
        print $0, "match-rule-broken"
    else
        print $0, "span-rule-broken"
}
