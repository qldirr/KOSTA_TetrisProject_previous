package org.tetris.domain.project;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class ProjectMemberVO {
	
	private String pl_num;
	private List<String> pmembers;

}
