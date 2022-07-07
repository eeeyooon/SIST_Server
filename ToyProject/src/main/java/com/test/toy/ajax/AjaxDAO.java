package com.test.toy.ajax;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.test.toy.DBUtil;

public class AjaxDAO {

	private Connection conn;
	private Statement stat;
	private PreparedStatement pstat;
	private ResultSet rs;
	
	public AjaxDAO() {
		conn = DBUtil.open();
	}

	public ArrayList<ResearchDTO> listResearch() {
		
		try {
			
			String sql = "select * from tblResearch where seq = 1";
			
			stat = conn.createStatement();
			rs = stat.executeQuery(sql);
			
			ArrayList<ResearchDTO> list = new ArrayList<ResearchDTO>();
			
			while (rs.next()) {
				
				ResearchDTO dto = new ResearchDTO();
				
				dto.setSeq(rs.getString("seq"));
				dto.setQuestion(rs.getString("question"));
				dto.setItem1(rs.getString("item1"));
				dto.setItem2(rs.getString("item2"));
				dto.setItem3(rs.getString("item3"));
				dto.setItem4(rs.getString("item4"));
				dto.setCnt1(rs.getString("cnt1"));
				dto.setCnt2(rs.getString("cnt2"));
				dto.setCnt3(rs.getString("cnt3"));
				dto.setCnt4(rs.getString("cnt4"));
				
				list.add(dto);
			}
			
			
			return list;
			
			
		} catch (Exception e) {
			System.out.println("AjaxDAO.listResearch");
			e.printStackTrace();

		}
		
		
		return null;
	}

	public int getCount() {


		try {
			
			String sql = "select count(*) as cnt from tblBoard";
			
			stat = conn.createStatement();
			
			rs = stat.executeQuery(sql);
			
			if (rs.next()) {
				return rs.getInt("cnt");
			}
			
			
		} catch (Exception e) {
			System.out.println("AjaxDAO.getCount");
			e.printStackTrace();

		}
		
		return 0;
	}

	public int checkid(String id) {
		
		try {
			
			String sql = "select count(*) as cnt from tblUser where id = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, id);
			
			rs = pstat.executeQuery();
			
			if (rs.next()) {
				
				return rs.getInt("cnt");
				
			}
			
		} catch (Exception e) {
			System.out.println("AjaxDAO.checkid");
			e.printStackTrace();

		}
		
		return 0;
	}

	public ArrayList<String> listBuseo() {
		
		try {
			
			String sql = "select distinct buseo from tblInsa order by buseo asc";
			
			stat = conn.createStatement();
			rs = stat.executeQuery(sql);
			
			ArrayList<String> blist = new ArrayList<String>();
			
			while (rs.next()) {
				
				blist.add(rs.getString("buseo"));
				
			}
			
			return blist;
			
		} catch (Exception e) {
			System.out.println("AjaxDAO.listBuseo");
			e.printStackTrace();

		}
		
		return null;
	}

	public ArrayList<BuseoDTO> listInsa(String buseo) {
		
		try {
			
			//선택한 부서 직원 명단 가져오기
			
			String sql = "select num, name, jikwi, tel, city from tblInsa where buseo = ?";
			
			pstat = conn.prepareStatement(sql);
			
			pstat.setString(1,  buseo);
			
			rs = pstat.executeQuery();
			
			ArrayList<BuseoDTO> list = new ArrayList<BuseoDTO>();
			
			while (rs.next()) {
				
				//레코드 1개 > 직원 1명 > BuseoDTO 1개
				BuseoDTO dto = new BuseoDTO();
				
				dto.setNum(rs.getString("num"));
				dto.setName(rs.getString("name"));
				dto.setJikwi(rs.getString("jikwi"));
				dto.setTel(rs.getString("tel"));
				dto.setCity(rs.getString("city"));
				
				list.add(dto);
			}
			
			return list;
			
			
		} catch (Exception e) {
			System.out.println("AjaxDAO.listInsa");
			e.printStackTrace();

		}
		
		return null;
	}

	
	//07.07
	public int updatePosition(DraggableDTO dto) {
		
		try {
			
			String sql = "update tblDraggable set left = ?, top = ? where id = ?";
			
			pstat = conn.prepareStatement(sql);
			pstat.setString(1, dto.getLeft());
			pstat.setString(2, dto.getTop());
			pstat.setString(3, dto.getId());
			
			return pstat.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("AjaxDAO.updatePosition");
			e.printStackTrace();

		}
		
		return 0;
	}

	public ArrayList<DraggableDTO> listDraggable() {
		
		try {
			
			String sql = "select * from tblDraggable";
			
			stat = conn.createStatement();
			
			rs = stat.executeQuery(sql);
			
			ArrayList<DraggableDTO> list = new ArrayList<DraggableDTO>();
			
			while (rs.next()) {
				
				DraggableDTO dto = new DraggableDTO();
				
				dto.setId(rs.getString("id")); 
				dto.setLeft(rs.getString("left"));
				dto.setTop(rs.getString("top"));
				
				list.add(dto);
			}
			
			return list;
			
		} catch (Exception e) {
			System.out.println("AjaxDAO.listDraggable");
			e.printStackTrace();

		}
		
		return null;
	}



}












