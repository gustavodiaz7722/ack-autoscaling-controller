	// Build the TagPropagateAtLaunch map from the raw API response.
	// DescribeAutoScalingGroups returns TagDescription objects with
	// PropagateAtLaunch, but the generated code only copies Key/Value
	// into Spec.Tags. This hook extracts PropagateAtLaunch into the
	// separate TagPropagateAtLaunch map so delta comparison is accurate.
	for _, asg := range resp.AutoScalingGroups {
		if asg.AutoScalingGroupName != nil && ko.Spec.Name != nil && *asg.AutoScalingGroupName == *ko.Spec.Name {
			if len(asg.Tags) > 0 {
				palMap := make(map[string]*bool, len(asg.Tags))
				for _, t := range asg.Tags {
					if t.Key != nil && t.PropagateAtLaunch != nil {
						palMap[*t.Key] = t.PropagateAtLaunch
					}
				}
				ko.Spec.TagPropagateAtLaunch = palMap
			}
			break
		}
	}
