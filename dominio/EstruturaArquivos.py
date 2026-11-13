# -*- coding: utf-8 -*-

__author__ = 'marc'


# Estrutura responsável por listar todos os diretorios
# e arquivos precisam ser tratados
class EstruturaArquivos(object):
    def __init__(self,diretorioAtual,diretorios,arquivos):
        self.diretorioAtual = diretorioAtual
        self.diretorios = diretorios
        self._arquivos = arquivos

    def __iter__(self):
        return self

    #def next(self):
    #    if not self.diretorioAtual

    @property
    def arquivos(self):
        return self._arquivos

    @property
    def exercicios(self):
        resultado = []
        for arquivo in self._arquivos:
            if 'exercise' in arquivo and '~' not in arquivo:
                resultado.append(arquivo)
        return resultado