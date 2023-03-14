#include "datamodel.h"

dataModel::dataModel(QObject * parent) : QAbstractTableModel(parent)
{

}

int dataModel::rowCount(const QModelIndex &) const
{
    return m_data.size();
}

int dataModel::columnCount(const QModelIndex &) const
{
    return 1;
}

QVariant dataModel::data(const QModelIndex &Index, int role) const
{
    const int row{Index.row()};
    if(row >= 0 && row < m_data.size()) {
        if(role == dataModel::IdRole)
            return m_data[row].id;
        if(role == dataModel::NameRole)
            return m_data[row].name;
        if(role == dataModel::SurnameRole)
            return m_data[row].surname;
        if(role == dataModel::FriendsRole)
            return m_data[row].friends;
        if(role == Qt::DisplayRole) {
            const int col{Index.column()};
            if (col == 0)
                return m_data[row].id;
            if (col == 1)
                return m_data[row].name;
            if (col == 2)
                return m_data[row].surname;
        }
    }
    return QVariant();
}

QHash<int, QByteArray> dataModel::roleNames() const
{
    return {
        {dataModel::IdRole, "rowid"},
        {dataModel::NameRole, "name"},
        {dataModel::SurnameRole, "surname"},
        {dataModel::FriendsRole, "friends"}
    };
}

void dataModel::appendRowElement(const dataModel::RowElement &element)
{
    QAbstractTableModel::beginInsertRows(QModelIndex(), m_data.size(), m_data.size() + 1);
    m_data.push_back(element);
    QAbstractTableModel::endInsertRows();
}
