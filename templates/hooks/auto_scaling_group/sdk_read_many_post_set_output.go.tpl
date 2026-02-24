	if ko.Spec.Name != nil {
		tags, err := rm.getTags(ctx, *ko.Spec.Name)
		if err != nil {
			return nil, err
		}
		ko.Spec.Tags = tags
	}
