#ifndef DATAMODEL_H
#define DATAMODEL_H

#include <QObject>
#include <QAbstractTableModel>
#include <QVector>

class dataModel : public QAbstractTableModel
{
    Q_OBJECT
public:
    explicit dataModel(QObject *parent = nullptr);
    struct RowElement {
        int id;
        QString name;
        QString surname;
        QStringList friends;
    };
    enum dataModelRole {
        IdRole = Qt::UserRole + 1,
        NameRole,
        SurnameRole,
        FriendsRole
    };
    int rowCount(const QModelIndex&) const override;
    int columnCount(const QModelIndex&) const override;
    QVariant data(const QModelIndex& Index, int role) const override;
    QHash<int,QByteArray> roleNames() const override;

    void appendRowElement(const RowElement& element);

private:
    QVector<RowElement> m_data;
};

#endif // DATAMODEL_H
