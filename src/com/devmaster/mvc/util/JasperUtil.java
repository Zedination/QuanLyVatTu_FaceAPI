package com.devmaster.mvc.util;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Locale;
import java.util.Map;

import javax.print.PrintService;
import javax.print.PrintServiceLookup;
import javax.print.attribute.HashPrintRequestAttributeSet;
import javax.print.attribute.HashPrintServiceAttributeSet;
import javax.print.attribute.PrintRequestAttributeSet;
import javax.print.attribute.PrintServiceAttributeSet;
import javax.print.attribute.standard.Copies;
import javax.print.attribute.standard.PrinterName;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JasperExportManager;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.JasperReport;
import net.sf.jasperreports.engine.export.HtmlExporter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRPrintServiceExporter;
import net.sf.jasperreports.engine.export.ooxml.JRDocxExporter;
import net.sf.jasperreports.engine.export.ooxml.JRXlsxExporter;
import net.sf.jasperreports.engine.query.JRQueryExecuterFactory;
import net.sf.jasperreports.engine.util.JRLoader;
import net.sf.jasperreports.engine.util.JRProperties;
import net.sf.jasperreports.export.SimpleExporterInput;
import net.sf.jasperreports.export.SimpleHtmlExporterOutput;
import net.sf.jasperreports.export.SimpleOutputStreamExporterOutput;
import net.sf.jasperreports.export.SimplePdfExporterConfiguration;
import net.sf.jasperreports.export.SimplePrintServiceExporterConfiguration;
import net.sf.jasperreports.export.SimpleXlsxReportConfiguration;
import net.sf.jasperreports.view.JasperViewer;

import org.apache.log4j.Logger;

public class JasperUtil {
	private static Logger log = Logger.getLogger(JasperUtil.class);
	private static String getPathFileTemplate(String fileName, HttpServletRequest request) {
		ServletContext context = request.getSession().getServletContext();
		String contextPath = context.getRealPath("/");
		String pathFileTemplate = contextPath + "/report/" + fileName + ".jasper";
		return pathFileTemplate;
	}
	
	public static JasperPrint getJasperPrint(String rptFileName, Map<String, Object> mapJasperParas, HttpServletRequest request) 
			 throws FileNotFoundException, JRException, SQLException
	{
		String fullPathFileTemplate = JasperUtil.getPathFileTemplate(rptFileName, request);
		InputStream inputStream = new FileInputStream(fullPathFileTemplate);
		JasperReport jasperReport = (JasperReport) JRLoader.loadObject(inputStream);
		jasperReport.setProperty( "net.sf.jasperreports.query.executer.factory.plsql"
                ,"com.jaspersoft.jrx.query.PlSqlQueryExecuterFactory");
		//Maybe this too, but not positive
		JRProperties.setProperty( JRQueryExecuterFactory.QUERY_EXECUTER_FACTORY_PREFIX+"plsql"
                   ,"com.jaspersoft.jrx.query.PlSqlQueryExecuterFactory");
		DataSource ds = DBUtil.jdbcTemplate.getDataSource();
		Connection cn = ds.getConnection();
		
		JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, mapJasperParas, cn);
		if(cn != null) {
			cn.close();
		}
		return jasperPrint;
	}
	
	public static void createReport(String rptFileName, Map<String, Object> mapJasperParas, 
			String fileExtend, HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		Connection cn = null;
		try {
			
			String fullPathFileTemplate = JasperUtil.getPathFileTemplate(rptFileName, request);
			InputStream inputStream = new FileInputStream(fullPathFileTemplate);
			JasperReport jasperReport = (JasperReport) JRLoader.loadObject(inputStream);
			jasperReport.setProperty( "net.sf.jasperreports.query.executer.factory.plsql", "com.jaspersoft.jrx.query.PlSqlQueryExecuterFactory");
			JRProperties.setProperty( JRQueryExecuterFactory.QUERY_EXECUTER_FACTORY_PREFIX+"plsql"
	                   ,"com.jaspersoft.jrx.query.PlSqlQueryExecuterFactory");
			//DataSource ds = DB.jdbcTemplate.getDataSource();
			cn = DBUtil.jdbcTemplate.getDataSource().getConnection();//ds.getConnection(); //
			
			JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, mapJasperParas, cn);
		
			OutputStream outputStream = null;
			switch (fileExtend) {
			case Constant.FORMAT_PDF_PREVIEW:
				response.setContentType(Constant.CONTENT_TYPE_PDF_VIEWONJSP);
				outputStream = response.getOutputStream();
				response.setHeader("Content-Disposition", "inline; filename=" + rptFileName + ".PDF");
				expJasper2Pdf_New1(jasperPrint, outputStream);
				break;
			case Constant.FORMAT_PDF:
				response.setContentType(Constant.CONTENT_TYPE_PDF_SAVEDIALOG);
				outputStream = response.getOutputStream();
				response.setHeader("Content-Disposition", "inline; filename="+ rptFileName + ".PDF");
				expJasper2Pdf_New1(jasperPrint, outputStream);
				break;
//				JasperViewer.viewReport(jasperPrint,false);
//				break;
			case Constant.FORMAT_DOC:
				response.setContentType(Constant.CONTENT_TYPE_DOC);
				outputStream = response.getOutputStream();
				response.setHeader("Content-Disposition", "inline; filename="+ rptFileName + ".DOC");
				expJasper2Docx_New(jasperPrint, outputStream);
				break;
			case Constant.FORMAT_XLS:
				response.setContentType(Constant.CONTENT_TYPE_XLS);
				outputStream = response.getOutputStream();
				response.setHeader("Content-Disposition", "inline; filename="+ rptFileName + ".XLSX");
				expJasper2Excel_New(jasperPrint, outputStream);
				break;
			}

		} catch (Exception ex) {
			log.error("Lỗi trong JasperUtils.createReport(), : "+ ex.toString());
		} finally {
			if(cn != null) {
				cn.close();
			}
		}
	}
	
	public static void createReport(String rptFileName, JasperPrint jasperPrint, 
			String fileExtend, HttpServletRequest request, HttpServletResponse response) throws Exception
	{
		try {
			OutputStream outputStream = response.getOutputStream();
			switch (fileExtend) {
			case Constant.FORMAT_PDF_PREVIEW:
				response.setContentType(Constant.CONTENT_TYPE_PDF_VIEWONJSP);
				response.setHeader("Content-Disposition", "inline; filename=" + rptFileName + ".PDF");
				expJasper2Pdf_New1(jasperPrint, outputStream);
				break;
			case Constant.FORMAT_PDF:
				
				  response.setContentType(Constant.CONTENT_TYPE_PDF_SAVEDIALOG);
				  response.setHeader("Content-Disposition", "inline; filename="+ rptFileName +
				  ".PDF"); expJasper2Pdf_New1(jasperPrint, outputStream); break;
				 
				
			case Constant.FORMAT_DOC:
				response.setContentType(Constant.CONTENT_TYPE_DOC);
				response.setHeader("Content-Disposition", "inline; filename="+ rptFileName + ".DOCX");
				expJasper2Docx_New(jasperPrint, outputStream);
				break;
			case Constant.FORMAT_XLS:
				response.setContentType(Constant.CONTENT_TYPE_XLS);
				response.setHeader("Content-Disposition", "inline; filename="+ rptFileName + ".XLSX");
				expJasper2Excel_New(jasperPrint, outputStream);
				break;
			}
		} catch (Exception ex) {
			log.error("Lỗi trong JasperUtils.createReport(), : "+ ex.toString());
		} 
	}
	
	public static void previewReport(String fileTemplate, Map<String, Object> parameters)
	{
		try{

			InputStream inputStream = new FileInputStream(fileTemplate);
			JasperReport jasperReport = (JasperReport) JRLoader.loadObject(inputStream);
			jasperReport.setProperty( "net.sf.jasperreports.query.executer.factory.plsql"
                    ,"com.jaspersoft.jrx.query.PlSqlQueryExecuterFactory");
			//Maybe this too, but not positive
			JRProperties.setProperty( JRQueryExecuterFactory.QUERY_EXECUTER_FACTORY_PREFIX+"plsql"
	                   ,"com.jaspersoft.jrx.query.PlSqlQueryExecuterFactory");
			//DataSource ds = DB.jdbcTemplate.getDataSource();
			Connection cn = DBUtil.jdbcTemplate.getDataSource().getConnection();//ds.getConnection();
			
			JasperPrint jasperPrint = JasperFillManager.fillReport(jasperReport, parameters, cn);
			if(cn != null) {
				cn.close();
			}
			JasperViewer viewer = new JasperViewer(jasperPrint, false);
			viewer.setVisible(true);
		}
		catch(Exception ex){
			log.error("Lỗi trong JasperUtils.createReport(), : "+ ex.toString());
		}
	}
	
	private static void expJasper2Pdf_New(JasperPrint jasperPrint, OutputStream outputStream) throws JRException {
		JasperExportManager.exportReportToPdfStream(jasperPrint, outputStream);
	}

	@SuppressWarnings("deprecation")
	private static void expJasper2Pdf_New1(JasperPrint jasperPrint, OutputStream outputStream) throws JRException {
		JRPdfExporter exporter = new JRPdfExporter();
		
		exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(outputStream));
		//exporter.setExporterOutput((OutputStreamExporterOutput) new SimpleWriterExporterOutput(outputStream, "UTF-8"));
		SimplePdfExporterConfiguration configuration = new SimplePdfExporterConfiguration();
		exporter.setConfiguration(configuration);

		exporter.exportReport();
	}

	private static void expJasper2Excel_New(JasperPrint jasperPrint, OutputStream outputStream) throws JRException {
		JRXlsxExporter exporter = new JRXlsxExporter();
		exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(outputStream));
		SimpleXlsxReportConfiguration configuration = new SimpleXlsxReportConfiguration();
		configuration.setOnePagePerSheet(false);// true: Mỗi page được ghi thành 1 sheet khác nhau.
		configuration.setDetectCellType(true);
		configuration.setCollapseRowSpan(false);
		configuration.setWhitePageBackground(false);
		configuration.setRemoveEmptySpaceBetweenRows(true);
		exporter.setConfiguration(configuration);

		exporter.exportReport();
	}

	@SuppressWarnings({ })
	private static void expJasper2Docx_New(JasperPrint jasperPrint, OutputStream outputStream) throws JRException {
		JRDocxExporter exporter = new JRDocxExporter();
		exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
		exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(outputStream));
		exporter.exportReport();
	}
	
	private static void expJasper2Html_New(JasperPrint jasperPrint, OutputStream outputStream) throws JRException {
		HtmlExporter exporter = new HtmlExporter();
		exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
        exporter.setExporterOutput(new SimpleHtmlExporterOutput(outputStream));
        exporter.exportReport();
	}
	
	private static void expJasper2Pdf_Printer(JasperPrint jasperPrint, OutputStream outputStream) throws JRException {
		PrintRequestAttributeSet printRequestAttributeSet = new HashPrintRequestAttributeSet();
        //printRequestAttributeSet.add(MediaSizeName.ISO_A4);
        printRequestAttributeSet.add(new Copies(1));

        PrintService defaultPrintService = 
			    PrintServiceLookup.lookupDefaultPrintService();
			if (defaultPrintService != null) {
			    String printServiceName = defaultPrintService.getName();
			} else {
			}
        PrintServiceAttributeSet printServiceAttributeSet = new HashPrintServiceAttributeSet();
        printServiceAttributeSet.add(new PrinterName(defaultPrintService.getName(), Locale.getDefault()));
        //printServiceAttributeSet.add(new PrinterName("////pcestamparia//Argox OS-214 plus series PPLA", null));
        //printServiceAttributeSet.add(new PrinterName("//pcestamparia/Argox OS-214 plus series PPLA", null));
        //printServiceAttributeSet.add(new PrinterName("////pcestamparia//Argox_OS-214_plus_series_PPLA", Locale.getDefault()));
        JRPrintServiceExporter exporter = new JRPrintServiceExporter();

        exporter.setExporterInput(new SimpleExporterInput(jasperPrint));
        //exporter.setExporterOutput(new SimpleOutputStreamExporterOutput(outputStream));
        SimplePrintServiceExporterConfiguration configuration = new SimplePrintServiceExporterConfiguration();
        configuration.setPrintRequestAttributeSet(printRequestAttributeSet);
        configuration.setPrintServiceAttributeSet(printServiceAttributeSet);
        exporter.setConfiguration(configuration);
        //true para aprecer opções
        configuration.setDisplayPageDialog(false);
        configuration.setDisplayPrintDialog(false);

        exporter.setConfiguration(configuration);

        exporter.exportReport();  
        
	}
}
