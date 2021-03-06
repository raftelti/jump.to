package to.jump.dao;

import java.util.Date;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import to.jump.models.Click;
import to.jump.models.Link;
import to.jump.utils.DateUtils;

@Repository
@Transactional
public class ClickDAO {
	@Autowired
	private SessionFactory sessionFactory;

	@Autowired
	LinkDAO linkDao;

	public void insertClick(Click click) {
		sessionFactory.getCurrentSession().persist(click);
		Link link = linkDao.getLinkById(click.getLinkId());
		link.setClicks(link.getClicks() + 1);

		linkDao.updateLink(link);
	}

	public void removeAllClicks(Link link) {
		sessionFactory.getCurrentSession()
				.createQuery("delete from Click c where c.linkId = :linkId")
				.setParameter("linkId", link.getId()).executeUpdate();
	}

	public long countClicks(Link link) {
		return (long) sessionFactory
				.getCurrentSession()
				.createQuery(
						"select count(*) from Click c where c.linkId = :linkId")
				.setParameter("linkId", link.getId()).uniqueResult();
	}

	public long countClicksOnDay(Link link, Date date) {
		Date begin = date;
		Date end = DateUtils.addDays(date, 1);

		return (long) sessionFactory
				.getCurrentSession()
				.createQuery(
						"select count(*) from Click c where c.linkId = :linkId and c.timestamp >= :begin and c.timestamp < :end")
				.setParameter("linkId", link.getId())
				.setDate("begin", begin)
				.setDate("end", end)
				.uniqueResult();
	}
	
	public long countClicksByBrowser(Link link, String browser) {
		return (long) sessionFactory
				.getCurrentSession()
				.createQuery(
						"select count(*) from Click c where c.linkId = :linkId and c.browser = :browser")
						.setParameter("linkId", link.getId())
						.setParameter("browser", browser)
				.uniqueResult();
	}
}
