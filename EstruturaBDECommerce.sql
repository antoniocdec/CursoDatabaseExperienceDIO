
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `ecommercebd`
--
CREATE DATABASE IF NOT EXISTS `ecommercebd` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `ecommercebd`;

-- --------------------------------------------------------

--
-- Estrutura da tabela `entrega`
--

CREATE TABLE IF NOT EXISTS `entrega` (
  `idEntrega` int(11) NOT NULL AUTO_INCREMENT,
  `StatusEntrega` varchar(45) DEFAULT NULL,
  `EnderocoEntregue` varchar(45) DEFAULT NULL,
  `RecebedorNome` varchar(45) DEFAULT NULL,
  `RecebedorDocumento` varchar(45) DEFAULT NULL,
  `CodigoRastreio` varchar(45) DEFAULT NULL,
  `Entregacol` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEntrega`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `estoque`
--

CREATE TABLE IF NOT EXISTS `estoque` (
  `idEstoque` int(11) NOT NULL,
  `Local` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idEstoque`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `fornecedor`
--

CREATE TABLE IF NOT EXISTS `fornecedor` (
  `idFornecedor` int(11) NOT NULL,
  `RazaoSocial` varchar(45) DEFAULT NULL,
  `CNPJ` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idFornecedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `fornecedor_produto`
--

CREATE TABLE IF NOT EXISTS `fornecedor_produto` (
  `Fornecedor_idFornecedor` int(11) NOT NULL,
  `Produto_idProduto` int(11) NOT NULL,
  PRIMARY KEY (`Fornecedor_idFornecedor`,`Produto_idProduto`),
  KEY `fk_Fornecedor_has_Produto_Produto1` (`Produto_idProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `meiospagamento`
--

CREATE TABLE IF NOT EXISTS `meiospagamento` (
  `idMeiosPagamento` int(11) NOT NULL,
  `ContaBancaria` varchar(45) DEFAULT NULL,
  `CartaoCredito` varchar(45) DEFAULT NULL,
  `PessoaFisica_idPessoaFisica` int(11) DEFAULT NULL,
  `Pedido_idPedido` int(11) DEFAULT NULL,
  `PessoaJuridica_idPessoaJuridica` int(11) DEFAULT NULL,
  PRIMARY KEY (`idMeiosPagamento`),
  KEY `fk_MeiosPagamento_PessoaFisica1` (`PessoaFisica_idPessoaFisica`),
  KEY `fk_MeiosPagamento_Pedido1` (`Pedido_idPedido`),
  KEY `fk_MeiosPagamento_PessoaJuridica1` (`PessoaJuridica_idPessoaJuridica`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pedido`
--

CREATE TABLE IF NOT EXISTS `pedido` (
  `idPedido` int(11) NOT NULL,
  `StatusPedido` varchar(45) DEFAULT NULL,
  `Descricao` varchar(45) DEFAULT NULL,
  `Frete` float DEFAULT NULL,
  `PessoaFisica_idPessoaFisica` int(11) NOT NULL,
  `PessoaJuridica_idPessoaJuridica` int(11) NOT NULL,
  `Entrega_idEntrega` int(11) NOT NULL,
  PRIMARY KEY (`idPedido`,`PessoaFisica_idPessoaFisica`,`PessoaJuridica_idPessoaJuridica`,`Entrega_idEntrega`),
  KEY `fk_Pedido_PessoaFisica1` (`PessoaFisica_idPessoaFisica`),
  KEY `fk_Pedido_PessoaJuridica1` (`PessoaJuridica_idPessoaJuridica`),
  KEY `fk_Pedido_Entrega1` (`Entrega_idEntrega`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pessoafisica`
--

CREATE TABLE IF NOT EXISTS `pessoafisica` (
  `idPessoaFisica` int(11) NOT NULL,
  `Nome` varchar(45) DEFAULT NULL,
  `CPF` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idPessoaFisica`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `pessoajuridica`
--

CREATE TABLE IF NOT EXISTS `pessoajuridica` (
  `idPessoaJuridica` int(11) NOT NULL,
  `RazaoSocial` varchar(45) DEFAULT NULL,
  `CNPJ` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idPessoaJuridica`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto`
--

CREATE TABLE IF NOT EXISTS `produto` (
  `idProduto` int(11) NOT NULL,
  `Descricao` varchar(45) DEFAULT NULL,
  `Categoria` varchar(45) DEFAULT NULL,
  `Valor` double DEFAULT NULL,
  PRIMARY KEY (`idProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto_em_estoque`
--

CREATE TABLE IF NOT EXISTS `produto_em_estoque` (
  `Produto_idProduto` int(11) NOT NULL,
  `Estoque_idEstoque` int(11) NOT NULL,
  `Quantidade` int(11) DEFAULT NULL,
  PRIMARY KEY (`Produto_idProduto`,`Estoque_idEstoque`),
  KEY `fk_Produto_has_Estoque_Estoque1` (`Estoque_idEstoque`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `produto_pedidos`
--

CREATE TABLE IF NOT EXISTS `produto_pedidos` (
  `Produto_idProduto` int(11) NOT NULL,
  `Pedido_idPedido` int(11) NOT NULL,
  `QuantidadePedido` int(11) DEFAULT NULL,
  PRIMARY KEY (`Produto_idProduto`,`Pedido_idPedido`),
  KEY `fk_Produto_has_Pedido_Pedido1` (`Pedido_idPedido`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vendedor`
--

CREATE TABLE IF NOT EXISTS `vendedor` (
  `idVendedor` int(11) NOT NULL,
  `RazaoSocial` varchar(45) DEFAULT NULL,
  `Local` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idVendedor`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura da tabela `vendedor_fornece_produtos`
--

CREATE TABLE IF NOT EXISTS `vendedor_fornece_produtos` (
  `Vendedor_idVendedor` int(11) NOT NULL,
  `Produto_idProduto` int(11) NOT NULL,
  `Quantidade` int(11) DEFAULT NULL,
  PRIMARY KEY (`Vendedor_idVendedor`,`Produto_idProduto`),
  KEY `fk_Vendedor_has_Produto_Produto1` (`Produto_idProduto`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Restrições para despejos de tabelas
--

--
-- Limitadores para a tabela `fornecedor_produto`
--
ALTER TABLE `fornecedor_produto`
  ADD CONSTRAINT `fk_Fornecedor_has_Produto_Fornecedor` FOREIGN KEY (`Fornecedor_idFornecedor`) REFERENCES `fornecedor` (`idFornecedor`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Fornecedor_has_Produto_Produto1` FOREIGN KEY (`Produto_idProduto`) REFERENCES `produto` (`idProduto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `meiospagamento`
--
ALTER TABLE `meiospagamento`
  ADD CONSTRAINT `fk_MeiosPagamento_Pedido1` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `pedido` (`idPedido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_MeiosPagamento_PessoaFisica1` FOREIGN KEY (`PessoaFisica_idPessoaFisica`) REFERENCES `pessoafisica` (`idPessoaFisica`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_MeiosPagamento_PessoaJuridica1` FOREIGN KEY (`PessoaJuridica_idPessoaJuridica`) REFERENCES `pessoajuridica` (`idPessoaJuridica`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `pedido`
--
ALTER TABLE `pedido`
  ADD CONSTRAINT `fk_Pedido_Entrega1` FOREIGN KEY (`Entrega_idEntrega`) REFERENCES `mydb`.`entrega` (`idEntrega`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Pedido_PessoaFisica1` FOREIGN KEY (`PessoaFisica_idPessoaFisica`) REFERENCES `mydb`.`pessoafisica` (`idPessoaFisica`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Pedido_PessoaJuridica1` FOREIGN KEY (`PessoaJuridica_idPessoaJuridica`) REFERENCES `mydb`.`pessoajuridica` (`idPessoaJuridica`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `produto_em_estoque`
--
ALTER TABLE `produto_em_estoque`
  ADD CONSTRAINT `fk_Produto_has_Estoque_Estoque1` FOREIGN KEY (`Estoque_idEstoque`) REFERENCES `estoque` (`idEstoque`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Produto_has_Estoque_Produto1` FOREIGN KEY (`Produto_idProduto`) REFERENCES `produto` (`idProduto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `produto_pedidos`
--
ALTER TABLE `produto_pedidos`
  ADD CONSTRAINT `fk_Produto_has_Pedido_Pedido1` FOREIGN KEY (`Pedido_idPedido`) REFERENCES `pedido` (`idPedido`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Produto_has_Pedido_Produto1` FOREIGN KEY (`Produto_idProduto`) REFERENCES `produto` (`idProduto`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limitadores para a tabela `vendedor_fornece_produtos`
--
ALTER TABLE `vendedor_fornece_produtos`
  ADD CONSTRAINT `fk_Vendedor_has_Produto_Produto1` FOREIGN KEY (`Produto_idProduto`) REFERENCES `produto` (`idProduto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_Vendedor_has_Produto_Vendedor1` FOREIGN KEY (`Vendedor_idVendedor`) REFERENCES `vendedor` (`idVendedor`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
