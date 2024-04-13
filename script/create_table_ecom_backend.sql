create table attachments
(
    id         bigint unsigned auto_increment
        primary key,
    url        varchar(191) default '' not null,
    created_at timestamp               null,
    updated_at timestamp               null
);

create table authors
(
    id          bigint unsigned auto_increment
        primary key,
    name        varchar(191)              not null,
    is_approved tinyint(1)   default 0    not null,
    image       json                      null,
    cover_image json                      null,
    slug        varchar(191)              not null,
    language    varchar(191) default 'en' not null,
    bio         text                      null,
    quote       text                      null,
    born        varchar(191)              null,
    death       varchar(191)              null,
    languages   varchar(191)              null,
    socials     json                      null,
    created_at  timestamp                 null,
    updated_at  timestamp                 null
);

create table delivery_times
(
    id          int unsigned auto_increment
        primary key,
    title       varchar(191)              not null,
    slug        varchar(191)              not null,
    icon        varchar(191)              not null,
    description text                      null,
    language    varchar(191) default 'en' not null,
    created_at  timestamp                 null,
    updated_at  timestamp                 null
);

create table digital_files
(
    id            bigint unsigned auto_increment
        primary key,
    attachment_id bigint unsigned not null,
    url           varchar(191)    not null,
    file_name     varchar(191)    not null,
    fileable_type varchar(191)    not null,
    fileable_id   bigint unsigned not null,
    created_at    timestamp       null,
    updated_at    timestamp       null
);

create table download_tokens
(
    id              bigint unsigned auto_increment
        primary key,
    token           varchar(191)         not null,
    downloaded      tinyint(1) default 0 not null,
    digital_file_id bigint unsigned      null,
    payload         text                 null,
    user_id         bigint unsigned      null,
    created_at      timestamp            null,
    updated_at      timestamp            null,
    constraint download_tokens_digital_file_id_foreign
        foreign key (digital_file_id) references digital_files (id)
            on delete cascade
);

create table failed_jobs
(
    id         bigint unsigned auto_increment
        primary key,
    uuid       varchar(191)                        not null,
    connection text                                not null,
    queue      text                                not null,
    payload    longtext                            not null,
    exception  longtext                            not null,
    failed_at  timestamp default CURRENT_TIMESTAMP not null,
    constraint failed_jobs_uuid_unique
        unique (uuid)
);

create table flash_sales
(
    id           bigint unsigned auto_increment
        primary key,
    title        varchar(191)                                                                  not null,
    slug         varchar(191)                                                                  not null,
    description  text                                                                          null,
    start_date   datetime                                        default '2024-03-13 06:50:44' not null,
    end_date     datetime                                                                      not null,
    sale_status  tinyint(1)                                      default 0                     not null,
    type         enum ( 'fixed_rate', 'percentage') default 'percentage'          not null,
    rate         int                                                                           null,
    sale_builder json                                                                          null,
    image        json                                                                          null,
    cover_image  json                                                                          null,
    language     varchar(191)                                                                  null,
    deleted_at   timestamp                                                                     null,
    created_at   timestamp                                                                     null,
    updated_at   timestamp                                                                     null
);

create table flash_sale_requests
(
    id             bigint unsigned auto_increment
        primary key,
    title          varchar(191)              not null,
    flash_sale_id  bigint unsigned           not null,
    request_status tinyint(1)   default 0    not null,
    note           varchar(191)              null,
    language       varchar(191) default 'en' not null,
    deleted_at     timestamp                 null,
    created_at     timestamp                 null,
    updated_at     timestamp                 null,
    constraint flash_sale_requests_flash_sale_id_foreign
        foreign key (flash_sale_id) references flash_sales (id)
            on delete cascade
);

create table jobs
(
    id           bigint unsigned auto_increment
        primary key,
    queue        varchar(191)     not null,
    payload      longtext         not null,
    attempts     tinyint unsigned not null,
    reserved_at  int unsigned     null,
    available_at int unsigned     not null,
    created_at   int unsigned     not null
);

create index jobs_queue_index
    on jobs (queue);

create table media
(
    id                    bigint unsigned auto_increment
        primary key,
    model_type            varchar(191)    not null,
    model_id              bigint unsigned not null,
    uuid                  char(36)        null,
    collection_name       varchar(191)    not null,
    name                  varchar(191)    not null,
    file_name             varchar(191)    not null,
    mime_type             varchar(191)    null,
    disk                  varchar(191)    not null,
    conversions_disk      varchar(191)    null,
    size                  bigint unsigned not null,
    manipulations         json            not null,
    generated_conversions json            not null,
    custom_properties     json            not null,
    responsive_images     json            not null,
    order_column          int unsigned    null,
    created_at            timestamp       null,
    updated_at            timestamp       null
);

create index media_model_type_model_id_index
    on media (model_type, model_id);

create table migrations
(
    id        int unsigned auto_increment
        primary key,
    migration varchar(191) not null,
    batch     int          not null
);

create table password_resets
(
    email      varchar(191) not null,
    token      varchar(191) not null,
    created_at timestamp    null
);

create index password_resets_email_index
    on password_resets (email);

create table permissions
(
    id         bigint unsigned auto_increment
        primary key,
    name       varchar(191) not null,
    guard_name varchar(191) not null,
    created_at timestamp    null,
    updated_at timestamp    null
);

create table model_has_permissions
(
    permission_id bigint unsigned not null,
    model_type    varchar(191)    not null,
    model_id      bigint unsigned not null,
    primary key (permission_id, model_id, model_type),
    constraint model_has_permissions_permission_id_foreign
        foreign key (permission_id) references permissions (id)
            on delete cascade
);

create index model_has_permissions_model_id_model_type_index
    on model_has_permissions (model_id, model_type);

create table personal_access_tokens
(
    id             bigint unsigned auto_increment
        primary key,
    tokenable_type varchar(191)    not null,
    tokenable_id   bigint unsigned not null,
    name           varchar(191)    not null,
    token          varchar(64)     not null,
    abilities      text            null,
    last_used_at   timestamp       null,
    expires_at     timestamp       null,
    created_at     timestamp       null,
    updated_at     timestamp       null,
    constraint personal_access_tokens_token_unique
        unique (token)
);

create index personal_access_tokens_tokenable_type_tokenable_id_index
    on personal_access_tokens (tokenable_type, tokenable_id);

create table product_tomxu
(
    id          int auto_increment
        primary key,
    product_id  bigint unsigned not null,
    price_tomxu int             not null,
    updated_at  timestamp       null,
    created_at  timestamp       null,
    deleted_at  timestamp       null
);

create table refund_reasons
(
    id         bigint unsigned auto_increment
        primary key,
    name       varchar(191)              not null,
    slug       varchar(191)              not null,
    language   varchar(191) default 'en' not null,
    created_at timestamp                 null,
    updated_at timestamp                 null,
    deleted_at timestamp                 null
);

create table resources
(
    id          bigint unsigned auto_increment
        primary key,
    name        varchar(191)                                                                  not null,
    slug        varchar(191)                                                                  not null,
    language    varchar(191) default 'en'                                                     not null,
    icon        varchar(191)                                                                  null,
    details     text                                                                          null,
    image       json                                                                          null,
    is_approved tinyint(1)   default 0                                                        not null,
    price       double                                                                        null,
    type        enum ('DROPOFF_LOCATION', 'PICKUP_LOCATION', 'PERSON', 'DEPOSIT', 'FEATURES') not null,
    created_at  timestamp                                                                     null,
    updated_at  timestamp                                                                     null
);

create table roles
(
    id         bigint unsigned auto_increment
        primary key,
    name       varchar(191) not null,
    guard_name varchar(191) not null,
    created_at timestamp    null,
    updated_at timestamp    null
);

create table model_has_roles
(
    role_id    bigint unsigned not null,
    model_type varchar(191)    not null,
    model_id   bigint unsigned not null,
    primary key (role_id, model_id, model_type),
    constraint model_has_roles_role_id_foreign
        foreign key (role_id) references roles (id)
            on delete cascade
);

create index model_has_roles_model_id_model_type_index
    on model_has_roles (model_id, model_type);

create table role_has_permissions
(
    permission_id bigint unsigned not null,
    role_id       bigint unsigned not null,
    primary key (permission_id, role_id),
    constraint role_has_permissions_permission_id_foreign
        foreign key (permission_id) references permissions (id)
            on delete cascade,
    constraint role_has_permissions_role_id_foreign
        foreign key (role_id) references roles (id)
            on delete cascade
);

create table settings
(
    id         bigint unsigned auto_increment
        primary key,
    options    json                      not null,
    language   varchar(191) default 'en' not null,
    created_at timestamp                 null,
    updated_at timestamp                 null,
    constraint settings_language_unique
        unique (language)
);

create table shipping_classes
(
    id         bigint unsigned auto_increment
        primary key,
    name       varchar(191)                                                           not null,
    amount     double                                                                 not null,
    is_global  varchar(191)                                           default '1'     not null,
    type       enum ('fixed', 'free_shipping') default 'fixed' not null,
    created_at timestamp                                                              null,
    updated_at timestamp                                                              null
);

create table shops
(
    id            bigint unsigned auto_increment
        primary key,
    owner_id      bigint unsigned      not null,
    name          varchar(191)         null,
    slug          varchar(191)         null,
    description   text                 null,
    cover_image   json                 null,
    logo          json                 null,
    is_active     tinyint(1) default 0 not null,
    address       json                 null,
    settings      json                 null,
    notifications json                 null,
    created_at    timestamp            null,
    updated_at    timestamp            null
);

create table attributes
(
    id         bigint unsigned auto_increment
        primary key,
    slug       varchar(191)              not null,
    language   varchar(191) default 'en' not null,
    name       varchar(191)              not null,
    shop_id    bigint unsigned           null,
    created_at timestamp                 null,
    updated_at timestamp                 null,
    constraint attributes_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade
);

create table attribute_values
(
    id           bigint unsigned auto_increment
        primary key,
    slug         varchar(191)              not null,
    attribute_id bigint unsigned           not null,
    value        varchar(191)              not null,
    language     varchar(191) default 'en' not null,
    meta         varchar(191)              null,
    created_at   timestamp                 null,
    updated_at   timestamp                 null,
    constraint attribute_values_attribute_id_foreign
        foreign key (attribute_id) references attributes (id)
            on delete cascade
);

create table balances
(
    id                    bigint unsigned auto_increment
        primary key,
    shop_id               bigint unsigned  not null,
    admin_commission_rate double           null,
    total_earnings        double default 0 not null,
    withdrawn_amount      double default 0 not null,
    current_balance       double default 0 not null,
    payment_info          json             null,
    created_at            timestamp        null,
    updated_at            timestamp        null,
    constraint balances_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade
);

create table refund_policies
(
    id          bigint unsigned auto_increment
        primary key,
    title       varchar(191)                                   not null,
    slug        varchar(191)                                   not null,
    description text                                           null,
    target      enum ('vendor', 'customer')  default 'vendor'  not null,
    language    varchar(191)                 default 'en'      not null,
    status      enum ('approved', 'pending') default 'pending' not null,
    shop_id     bigint unsigned                                null,
    created_at  timestamp                                      null,
    updated_at  timestamp                                      null,
    deleted_at  timestamp                                      null,
    constraint refund_policies_slug_unique
        unique (slug),
    constraint refund_policies_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete set null
);

create table tax_classes
(
    id          bigint unsigned auto_increment
        primary key,
    country     varchar(191)         null,
    state       varchar(191)         null,
    zip         varchar(191)         null,
    city        varchar(191)         null,
    rate        double               not null,
    name        varchar(191)         null,
    is_global   int                  null,
    priority    int                  null,
    on_shipping tinyint(1) default 1 not null,
    created_at  timestamp            null,
    updated_at  timestamp            null
);

create table types
(
    id                  bigint unsigned auto_increment
        primary key,
    name                varchar(191)              not null,
    settings            json                      null,
    slug                varchar(191)              not null,
    language            varchar(191) default 'en' not null,
    icon                varchar(191)              null,
    promotional_sliders json                      null,
    created_at          timestamp                 null,
    updated_at          timestamp                 null
);

create table banners
(
    id          bigint unsigned auto_increment
        primary key,
    type_id     bigint unsigned not null,
    title       text            not null,
    description text            null,
    image       json            null,
    created_at  timestamp       null,
    updated_at  timestamp       null,
    constraint banners_type_id_foreign
        foreign key (type_id) references types (id)
            on delete cascade
);

create table categories
(
    id         bigint unsigned auto_increment
        primary key,
    name       varchar(191)              not null,
    slug       varchar(191)              not null,
    language   varchar(191) default 'en' not null,
    icon       varchar(191)              null,
    image      json                      null,
    details    text                      null,
    parent     bigint unsigned           null,
    type_id    bigint unsigned           null,
    created_at timestamp                 null,
    updated_at timestamp                 null,
    deleted_at timestamp                 null,
    constraint categories_parent_foreign
        foreign key (parent) references categories (id)
            on delete cascade,
    constraint categories_type_id_foreign
        foreign key (type_id) references types (id)
            on delete cascade
);

create table category_shop
(
    id          bigint unsigned auto_increment
        primary key,
    shop_id     bigint unsigned not null,
    category_id bigint unsigned not null,
    constraint category_shop_category_id_foreign
        foreign key (category_id) references categories (id)
            on delete cascade,
    constraint category_shop_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade
);

create table manufacturers
(
    id          bigint unsigned auto_increment
        primary key,
    name        varchar(191)              not null,
    is_approved tinyint(1)   default 0    not null,
    image       json                      null,
    cover_image json                      null,
    slug        varchar(191)              not null,
    language    varchar(191) default 'en' not null,
    type_id     bigint unsigned           not null,
    description text                      null,
    website     varchar(191)              null,
    socials     json                      null,
    created_at  timestamp                 null,
    updated_at  timestamp                 null,
    constraint manufacturers_type_id_foreign
        foreign key (type_id) references types (id)
            on delete cascade
);

create table products
(
    id                           bigint unsigned auto_increment
        primary key,
    name                         varchar(191)                                                                                    not null,
    slug                         varchar(191)                                                                                    not null,
    description                  text                                                                                            null,
    type_id                      bigint unsigned                                                                                 not null,
    price                        double                                                                                          null,
    shop_id                      bigint unsigned                                                                                 null,
    sale_price                   double                                                                                          null,
    language                     varchar(191)                                                                   default 'en'     not null,
    min_price                    double(8, 2)                                                                                    null,
    max_price                    double(8, 2)                                                                                    null,
    sku                          varchar(191)                                                                                    null,
    preview_url                  varchar(191)                                                                                    null,
    quantity                     int                                                                            default 0        not null,
    sold_quantity                int                                                                            default 0        not null,
    in_stock                     tinyint(1)                                                                     default 1        not null,
    is_taxable                   tinyint(1)                                                                     default 0        not null,
    in_flash_sale                int                                                                            default 0        not null,
    shipping_class_id            bigint unsigned                                                                                 null,
    status                       enum ('under_review', 'approved', 'rejected', 'publish', 'unpublish', 'draft') default 'draft'  not null,
    product_type                 enum ('simple', 'variable')                                                    default 'simple' not null,
    unit                         varchar(191)                                                                                    not null,
    height                       varchar(191)                                                                                    null,
    width                        varchar(191)                                                                                    null,
    length                       varchar(191)                                                                                    null,
    image                        json                                                                                            null,
    video                        json                                                                                            null,
    gallery                      json                                                                                            null,
    deleted_at                   timestamp                                                                                       null,
    created_at                   timestamp                                                                                       null,
    updated_at                   timestamp                                                                                       null,
    author_id                    bigint unsigned                                                                                 null,
    manufacturer_id              bigint unsigned                                                                                 null,
    is_digital                   tinyint(1)                                                                     default 0        not null,
    is_external                  tinyint(1)                                                                     default 0        not null,
    external_product_url         varchar(191)                                                                                    null,
    external_product_button_text varchar(191)                                                                                    null,
    blocked_dates                varchar(191)                                                                                    null,
    constraint products_author_id_foreign
        foreign key (author_id) references authors (id)
            on delete cascade,
    constraint products_manufacturer_id_foreign
        foreign key (manufacturer_id) references manufacturers (id)
            on delete cascade,
    constraint products_shipping_class_id_foreign
        foreign key (shipping_class_id) references shipping_classes (id),
    constraint products_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade,
    constraint products_type_id_foreign
        foreign key (type_id) references types (id)
            on delete cascade
);

create table attribute_product
(
    id                 bigint unsigned auto_increment
        primary key,
    attribute_value_id bigint unsigned not null,
    product_id         bigint unsigned not null,
    created_at         timestamp       null,
    updated_at         timestamp       null,
    constraint attribute_product_attribute_value_id_foreign
        foreign key (attribute_value_id) references attribute_values (id)
            on delete cascade,
    constraint attribute_product_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade
);

create table category_product
(
    id          bigint unsigned auto_increment
        primary key,
    product_id  bigint unsigned not null,
    category_id bigint unsigned not null,
    constraint category_product_category_id_foreign
        foreign key (category_id) references categories (id)
            on delete cascade,
    constraint category_product_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade
);

create table deposit_product
(
    resource_id bigint unsigned null,
    product_id  bigint unsigned null,
    constraint deposit_product_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade,
    constraint deposit_product_resource_id_foreign
        foreign key (resource_id) references resources (id)
            on delete cascade
);

create table dropoff_location_product
(
    resource_id bigint unsigned null,
    product_id  bigint unsigned null,
    constraint dropoff_location_product_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade,
    constraint dropoff_location_product_resource_id_foreign
        foreign key (resource_id) references resources (id)
            on delete cascade
);

create table feature_product
(
    resource_id bigint unsigned null,
    product_id  bigint unsigned null,
    constraint feature_product_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade,
    constraint feature_product_resource_id_foreign
        foreign key (resource_id) references resources (id)
            on delete cascade
);

create table flash_sale_products
(
    flash_sale_id bigint unsigned not null,
    product_id    bigint unsigned not null,
    constraint flash_sale_products_flash_sale_id_foreign
        foreign key (flash_sale_id) references flash_sales (id)
            on delete cascade,
    constraint flash_sale_products_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade
);

create table flash_sale_requests_products
(
    flash_sale_requests_id bigint unsigned null,
    product_id             bigint unsigned null,
    constraint flash_sale_requests_products_flash_sale_requests_id_foreign
        foreign key (flash_sale_requests_id) references flash_sale_requests (id)
            on delete cascade,
    constraint flash_sale_requests_products_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade
);

create table person_product
(
    resource_id bigint unsigned null,
    product_id  bigint unsigned null,
    constraint person_product_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade,
    constraint person_product_resource_id_foreign
        foreign key (resource_id) references resources (id)
            on delete cascade
);

create table pickup_location_product
(
    resource_id bigint unsigned null,
    product_id  bigint unsigned null,
    constraint pickup_location_product_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade,
    constraint pickup_location_product_resource_id_foreign
        foreign key (resource_id) references resources (id)
            on delete cascade
);

create table products_meta
(
    id         int unsigned auto_increment
        primary key,
    product_id bigint unsigned             not null,
    type       varchar(191) default 'null' not null,
    `key`      varchar(191)                not null,
    value      text                        null,
    created_at timestamp                   null,
    updated_at timestamp                   null,
    constraint products_meta_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade
);

create index products_meta_key_index
    on products_meta (`key`);

create table tags
(
    id         bigint unsigned auto_increment
        primary key,
    name       varchar(191)              not null,
    slug       varchar(191)              not null,
    language   varchar(191) default 'en' not null,
    icon       varchar(191)              null,
    image      json                      null,
    details    text                      null,
    type_id    bigint unsigned           null,
    created_at timestamp                 null,
    updated_at timestamp                 null,
    deleted_at timestamp                 null,
    constraint tags_type_id_foreign
        foreign key (type_id) references types (id)
);

create table product_tag
(
    id         bigint unsigned auto_increment
        primary key,
    product_id bigint unsigned not null,
    tag_id     bigint unsigned not null,
    constraint product_tag_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade,
    constraint product_tag_tag_id_foreign
        foreign key (tag_id) references tags (id)
            on delete cascade
);

create table users
(
    id                 bigint unsigned auto_increment
        primary key,
    email              varchar(255)                                                             null,
    username           varchar(255)                                                             null,
    password           varchar(255)                                                             not null,
    name               varchar(191)                                                             not null,
    email_verified_at  timestamp                                                                null,
    remember_token     varchar(100)                                                             null,
    is_active          tinyint(1)                                            default 1          not null,
    shop_id            bigint unsigned                                                          null,
    role               enum ('member', 'agency', 'customer', 'fund')         default 'member'   null,
    package_id         bigint unsigned                                                          null,
    first_name         varchar(255)                                                             null,
    last_name          varchar(255)                                                             null,
    date_of_birth      bigint unsigned                                                          null,
    gender             enum ('Male', 'Female', 'Other')                                         null,
    phone              varchar(255)                                                             null,
    address            varchar(255)                                                             null,
    two_fa_key         varchar(255)                                                             null,
    two_fa_enabled     tinyint(1)                                                               null,
    status             enum ('active', 'inactive', 'restricted', 'locked')   default 'inactive' null,
    slug               varchar(255)                                                             null,
    status_updated_at  bigint                                                                   null,
    kyc_status         enum ('new', 'pending', 'approved', 'rejected')       default 'new'      null,
    kyc_at             bigint                                                                   null,
    ref_code           varchar(50)                                                              null,
    fcm_token          varchar(255)                                                             null,
    fcm_id             varchar(255)                                                             null,
    jwt_token          text                                                                     null,
    profile_image      varchar(255)                                                             null,
    profile_image_full varchar(255)                                                             null,
    cover_image        varchar(255)                                                             null,
    cover_image_full   varchar(255)                                                             null,
    nation             varchar(255)                                                             null,
    lang               enum ('vi', 'en', 'ar', 'hi', 'ja', 'ko', 'ru', 'zh') default 'vi'       null,
    created_at         bigint unsigned                                                          null,
    buy_package_at     bigint unsigned                                                          null,
    updated_at         bigint unsigned                                                          null,
    expired_premium_at bigint unsigned                                                          null,
    post_enabled       tinyint(1)                                            default 0          null,
    introduce          text                                                                     null,
    socket_id          varchar(50)                                                              null,
    firebase_id        varchar(255)                                                             null,
    constraint user_email
        unique (email),
    constraint user_refcode
        unique (ref_code),
    constraint user_username
        unique (username)
)
    row_format = DYNAMIC;

create fulltext index user_jwt_token
    on users (jwt_token);

create index user_package_id
    on users (package_id);

create index user_phone
    on users (phone);

create table users_balance
(
    id         bigint unsigned auto_increment
        primary key,
    user_id    bigint unsigned                          not null,
    token_id   bigint unsigned                          not null,
    balance    decimal(24, 6) unsigned default 0.000000 not null,
    created_at bigint unsigned                          null,
    updated_at bigint unsigned                          null,
    constraint user_balance_user_id_balance_uq
        unique (user_id, token_id),
    constraint user_balance_user_id_FK
        foreign key (user_id) references users (id)
)
    row_format = DYNAMIC;

create index user_balance_token_id
    on users_balance (token_id);

create index user_balance_user_id
    on users_balance (user_id);

create table users_old
(
    id                bigint unsigned auto_increment
        primary key,
    name              varchar(191)         not null,
    email             varchar(191)         not null,
    email_verified_at timestamp            null,
    password          varchar(191)         null,
    remember_token    varchar(100)         null,
    created_at        timestamp            null,
    updated_at        timestamp            null,
    is_active         tinyint(1) default 1 not null,
    shop_id           bigint unsigned      null,
    constraint users_email_unique
        unique (email),
    constraint users_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade
);

create table abusive_reports
(
    id         bigint unsigned auto_increment
        primary key,
    user_id    bigint unsigned not null,
    model_type varchar(191)    not null,
    model_id   bigint unsigned not null,
    message    text            not null,
    created_at timestamp       null,
    updated_at timestamp       null,
    constraint abusive_reports_user_id_foreign
        foreign key (user_id) references users_old (id)
            on delete cascade
);

create index abusive_reports_model_type_model_id_index
    on abusive_reports (model_type, model_id);

create table address
(
    id          bigint unsigned auto_increment
        primary key,
    title       varchar(191)         not null,
    type        varchar(191)         not null,
    `default`   tinyint(1) default 0 not null,
    address     json                 not null,
    location    json                 null,
    customer_id bigint unsigned      not null,
    created_at  timestamp            null,
    updated_at  timestamp            null,
    constraint address_customer_id_foreign
        foreign key (customer_id) references users_old (id)
);

create table conversations
(
    id         bigint unsigned auto_increment
        primary key,
    user_id    bigint unsigned not null,
    shop_id    bigint unsigned not null,
    created_at timestamp       null,
    updated_at timestamp       null,
    constraint conversations_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade,
    constraint conversations_user_id_foreign
        foreign key (user_id) references users_old (id)
            on delete cascade
);

create table coupons
(
    id                  bigint unsigned auto_increment
        primary key,
    code                varchar(191)                                                           not null,
    language            varchar(191)                                           default 'en'    not null,
    description         text                                                                   null,
    image               json                                                                   null,
    type                enum ( 'percentage', 'free_shipping', 'fixed') default 'fixed' not null,
    amount              double(8, 2)                                           default 0.00    not null,
    minimum_cart_amount double(8, 2)                                           default 0.00    not null,
    active_from         varchar(191)                                                           not null,
    expire_at           varchar(191)                                                           not null,
    target              tinyint(1)                                             default 0       not null comment 'Default value is false but For authenticated customer the value is true',
    is_approve          tinyint(1)                                             default 0       not null,
    shop_id             bigint unsigned                                                        null,
    user_id             bigint unsigned                                                        null,
    created_at          timestamp                                                              null,
    updated_at          timestamp                                                              null,
    deleted_at          timestamp                                                              null,
    constraint coupons_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade,
    constraint coupons_user_id_foreign
        foreign key (user_id) references users_old (id)
            on delete cascade
);

create table faqs
(
    id              bigint unsigned auto_increment
        primary key,
    user_id         bigint unsigned not null,
    shop_id         bigint unsigned null,
    faq_title       text            not null,
    slug            varchar(191)    not null,
    faq_description text            not null,
    faq_type        varchar(191)    null,
    issued_by       varchar(191)    null,
    language        varchar(191)    null,
    deleted_at      timestamp       null,
    created_at      timestamp       null,
    updated_at      timestamp       null,
    constraint faqs_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade,
    constraint faqs_user_id_foreign
        foreign key (user_id) references users_old (id)
            on delete cascade
);

create table feedbacks
(
    id         bigint unsigned auto_increment
        primary key,
    user_id    bigint unsigned not null,
    model_type varchar(191)    not null,
    model_id   bigint unsigned not null,
    positive   tinyint(1)      null,
    negative   tinyint(1)      null,
    created_at timestamp       null,
    updated_at timestamp       null,
    constraint feedbacks_user_id_foreign
        foreign key (user_id) references users_old (id)
            on delete cascade
);

create index feedbacks_model_type_model_id_index
    on feedbacks (model_type, model_id);

create table messages
(
    id              bigint unsigned auto_increment
        primary key,
    conversation_id bigint unsigned not null,
    user_id         bigint unsigned not null,
    body            text            not null,
    created_at      timestamp       null,
    updated_at      timestamp       null,
    constraint messages_conversation_id_foreign
        foreign key (conversation_id) references conversations (id)
            on delete cascade,
    constraint messages_user_id_foreign
        foreign key (user_id) references users_old (id)
            on delete cascade
);

create table notify_logs
(
    id                   bigint unsigned auto_increment
        primary key,
    receiver             bigint unsigned      not null,
    sender               bigint unsigned      null,
    notify_type          text                 null,
    notify_receiver_type text                 null,
    is_read              tinyint(1) default 0 not null,
    notify_tracker       text                 null,
    notify_text          text                 null,
    deleted_at           timestamp            null,
    created_at           timestamp            null,
    updated_at           timestamp            null,
    constraint notify_logs_receiver_foreign
        foreign key (receiver) references users_old (id)
            on delete cascade,
    constraint notify_logs_sender_foreign
        foreign key (sender) references users_old (id)
            on delete cascade
);

create table orders
(
    id                      bigint unsigned auto_increment
        primary key,
    tracking_number         varchar(191)                                                                                                                                                                                                                                         not null,
    customer_id             bigint unsigned                                                                                                                                                                                                                                      null,
    customer_contact        varchar(191)                                                                                                                                                                                                                                         not null,
    customer_name           varchar(191)                                                                                                                                                                                                                                         null,
    amount                  double                                                                                                                                                                                                                                               not null,
    sales_tax               double                                                                                                                                                                                                                                               null,
    paid_total              double                                                                                                                                                                                                                                               null,
    total                   double                                                                                                                                                                                                                                               null,
    note                    longtext                                                                                                                                                                                                                                             null,
    cancelled_amount        decimal(8, 2)                                                                                                                                                                                                              default 0.00              not null,
    cancelled_tax           decimal(8, 2)                                                                                                                                                                                                              default 0.00              not null,
    cancelled_delivery_fee  decimal(8, 2)                                                                                                                                                                                                              default 0.00              not null,
    language                varchar(191)                                                                                                                                                                                                               default 'en'              not null,
    coupon_id               bigint unsigned                                                                                                                                                                                                                                      null,
    parent_id               bigint unsigned                                                                                                                                                                                                                                      null,
    shop_id                 bigint unsigned                                                                                                                                                                                                                                      null,
    discount                double                                                                                                                                                                                                                                               null,
    payment_gateway         varchar(191)                                                                                                                                                                                                                                         null,
    altered_payment_gateway varchar(191)                                                                                                                                                                                                                                         null,
    shipping_address        json                                                                                                                                                                                                                                                 null,
    billing_address         json                                                                                                                                                                                                                                                 null,
    logistics_provider      bigint unsigned                                                                                                                                                                                                                                      null,
    delivery_fee            double                                                                                                                                                                                                                                               null,
    delivery_time           varchar(191)                                                                                                                                                                                                                                         null,
    order_status            enum ('order-pending', 'order-processing', 'order-completed', 'order-cancelled', 'order-refunded', 'order-failed', 'order-at-local-facility', 'order-out-for-delivery')                                                    default 'order-pending'   not null,
    payment_status          enum ('payment-pending', 'payment-processing', 'payment-success', 'payment-failed', 'payment-reversal', 'payment-refunded', 'payment-cash-on-delivery', 'payment-cash', 'payment-wallet', 'payment-awaiting-for-approval') default 'payment-pending' not null,
    deleted_at              timestamp                                                                                                                                                                                                                                            null,
    created_at              timestamp                                                                                                                                                                                                                                            null,
    updated_at              timestamp                                                                                                                                                                                                                                            null,
    total_tomxu             double                                                                                                                                                                                                                                               null,
    constraint orders_tracking_number_unique
        unique (tracking_number),
    constraint orders_customer_id_foreign
        foreign key (customer_id) references users_old (id),
    constraint orders_parent_id_foreign
        foreign key (parent_id) references orders (id)
            on delete cascade,
    constraint orders_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade
);

create table availabilities
(
    id               bigint unsigned auto_increment
        primary key,
    `from`           varchar(191)              not null,
    `to`             varchar(191)              not null,
    language         varchar(191) default 'en' not null,
    booking_duration varchar(191)              not null,
    order_quantity   int                       not null,
    bookable_type    varchar(191)              not null,
    bookable_id      bigint unsigned           not null,
    order_id         bigint unsigned           null,
    product_id       bigint unsigned           null,
    created_at       timestamp                 null,
    updated_at       timestamp                 null,
    constraint availabilities_order_id_foreign
        foreign key (order_id) references orders (id)
            on delete cascade,
    constraint availabilities_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade
);

create table order_wallet_points
(
    id         bigint unsigned auto_increment
        primary key,
    amount     double          null,
    order_id   bigint unsigned null,
    created_at timestamp       null,
    updated_at timestamp       null,
    constraint order_wallet_points_order_id_foreign
        foreign key (order_id) references orders (id)
            on delete cascade
);

create table ordered_files
(
    id              bigint unsigned auto_increment
        primary key,
    purchase_key    varchar(191)    not null,
    digital_file_id bigint unsigned not null,
    tracking_number varchar(191)    null,
    customer_id     bigint unsigned not null,
    created_at      timestamp       null,
    updated_at      timestamp       null,
    constraint ordered_files_customer_id_foreign
        foreign key (customer_id) references users_old (id)
            on delete cascade,
    constraint ordered_files_digital_file_id_foreign
        foreign key (digital_file_id) references digital_files (id)
            on delete cascade,
    constraint ordered_files_tracking_number_foreign
        foreign key (tracking_number) references orders (tracking_number)
            on delete cascade
);

create table participants
(
    id              bigint unsigned auto_increment
        primary key,
    conversation_id bigint unsigned       not null,
    type            enum ('shop', 'user') not null,
    user_id         bigint unsigned       not null,
    shop_id         bigint unsigned       not null,
    message_id      bigint unsigned       not null,
    notify          tinyint(1) default 0  not null,
    last_read       timestamp             null,
    created_at      timestamp             null,
    updated_at      timestamp             null,
    constraint participants_conversation_id_foreign
        foreign key (conversation_id) references conversations (id)
            on delete cascade,
    constraint participants_message_id_foreign
        foreign key (message_id) references messages (id)
            on delete cascade,
    constraint participants_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade,
    constraint participants_user_id_foreign
        foreign key (user_id) references users_old (id)
            on delete cascade
);

create table payment_gateways
(
    id           bigint unsigned auto_increment
        primary key,
    user_id      bigint unsigned not null,
    customer_id  varchar(191)    not null,
    gateway_name varchar(191)    null,
    deleted_at   timestamp       null,
    created_at   timestamp       null,
    updated_at   timestamp       null,
    constraint payment_gateways_user_id_foreign
        foreign key (user_id) references users_old (id)
            on delete cascade
);

create table payment_intents
(
    id                  bigint unsigned auto_increment
        primary key,
    order_id            bigint unsigned null,
    tracking_number     varchar(191)    null,
    payment_gateway     varchar(191)    null,
    payment_intent_info json            null,
    deleted_at          timestamp       null,
    created_at          timestamp       null,
    updated_at          timestamp       null,
    constraint payment_intents_order_id_foreign
        foreign key (order_id) references orders (id)
            on delete cascade
);

create table payment_methods
(
    id                 bigint unsigned auto_increment
        primary key,
    method_key         varchar(191)         not null,
    payment_gateway_id bigint unsigned      null,
    default_card       tinyint(1) default 0 null,
    fingerprint        varchar(191)         not null,
    owner_name         varchar(191)         null,
    network            varchar(191)         null,
    type               varchar(191)         null,
    last4              varchar(191)         null,
    expires            varchar(191)         null,
    origin             varchar(191)         null,
    verification_check varchar(191)         null,
    deleted_at         timestamp            null,
    created_at         timestamp            null,
    updated_at         timestamp            null,
    constraint payment_methods_fingerprint_unique
        unique (fingerprint),
    constraint payment_methods_method_key_unique
        unique (method_key),
    constraint payment_methods_payment_gateway_id_foreign
        foreign key (payment_gateway_id) references payment_gateways (id)
            on delete cascade
);

create table providers
(
    id               bigint unsigned auto_increment
        primary key,
    user_id          bigint unsigned not null,
    provider_user_id varchar(191)    not null,
    provider         varchar(191)    not null,
    created_at       timestamp       null,
    updated_at       timestamp       null,
    constraint providers_user_id_foreign
        foreign key (user_id) references users_old (id)
            on delete cascade
);

create table questions
(
    id         bigint unsigned auto_increment
        primary key,
    user_id    bigint unsigned not null,
    shop_id    bigint unsigned not null,
    product_id bigint unsigned not null,
    question   text            not null,
    answer     text            null,
    deleted_at timestamp       null,
    created_at timestamp       null,
    updated_at timestamp       null,
    constraint questions_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade,
    constraint questions_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade,
    constraint questions_user_id_foreign
        foreign key (user_id) references users_old (id)
            on delete cascade
);

create table refunds
(
    id               bigint unsigned auto_increment
        primary key,
    amount           double                                                 default 0         not null,
    status           enum ('approved', 'pending', 'rejected', 'processing') default 'pending' not null,
    title            varchar(191)                                                             null,
    description      text                                                                     null,
    images           json                                                                     null,
    order_id         bigint unsigned                                                          null,
    customer_id      bigint unsigned                                                          null,
    refund_policy_id bigint unsigned                                                          null,
    shop_id          bigint unsigned                                                          null,
    refund_reason_id bigint unsigned                                                          null,
    created_at       timestamp                                                                null,
    updated_at       timestamp                                                                null,
    constraint refunds_customer_id_foreign
        foreign key (customer_id) references users_old (id)
            on delete cascade,
    constraint refunds_order_id_foreign
        foreign key (order_id) references orders (id)
            on delete cascade,
    constraint refunds_refund_policy_id_foreign
        foreign key (refund_policy_id) references refund_policies (id)
            on delete set null,
    constraint refunds_refund_reason_id_foreign
        foreign key (refund_reason_id) references refund_reasons (id)
            on delete set null,
    constraint refunds_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade
);

alter table shops
    add constraint shops_owner_id_foreign
        foreign key (owner_id) references users_old (id);

create table store_notices
(
    id             bigint unsigned auto_increment
        primary key,
    priority       enum ('high', 'medium', 'low') default 'low'                        not null,
    notice         text                                                                not null,
    description    text                                                                null,
    effective_from datetime                       default '2024-03-13 06:50:27'        not null,
    expired_at     datetime                                                            not null,
    type           enum ('all_vendor', 'specific_vendor', 'all_shop', 'specific_shop') not null,
    created_by     bigint unsigned                                                     null,
    updated_by     bigint unsigned                                                     null,
    created_at     timestamp                                                           null,
    updated_at     timestamp                                                           null,
    deleted_at     timestamp                                                           null,
    constraint store_notices_created_by_foreign
        foreign key (created_by) references users_old (id),
    constraint store_notices_updated_by_foreign
        foreign key (updated_by) references users_old (id)
);

create table store_notice_read
(
    store_notice_id bigint unsigned      null,
    user_id         bigint unsigned      null,
    is_read         tinyint(1) default 0 not null,
    constraint store_notice_read_store_notice_id_foreign
        foreign key (store_notice_id) references store_notices (id)
            on delete cascade,
    constraint store_notice_read_user_id_foreign
        foreign key (user_id) references users_old (id)
            on delete cascade
);

create table store_notice_shop
(
    store_notice_id bigint unsigned null,
    shop_id         bigint unsigned null,
    constraint store_notice_shop_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade,
    constraint store_notice_shop_store_notice_id_foreign
        foreign key (store_notice_id) references store_notices (id)
            on delete cascade
);

create table store_notice_user
(
    store_notice_id bigint unsigned null,
    user_id         bigint unsigned null,
    constraint store_notice_user_store_notice_id_foreign
        foreign key (store_notice_id) references store_notices (id)
            on delete cascade,
    constraint store_notice_user_user_id_foreign
        foreign key (user_id) references users_old (id)
            on delete cascade
);

create table terms_and_conditions
(
    id          bigint unsigned auto_increment
        primary key,
    user_id     bigint unsigned      not null,
    shop_id     bigint unsigned      null,
    title       text                 not null,
    slug        varchar(191)         not null,
    description text                 not null,
    type        varchar(191)         null,
    issued_by   varchar(191)         null,
    is_approved tinyint(1) default 0 not null,
    language    varchar(191)         null,
    deleted_at  timestamp            null,
    created_at  timestamp            null,
    updated_at  timestamp            null,
    constraint terms_and_conditions_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade,
    constraint terms_and_conditions_user_id_foreign
        foreign key (user_id) references users_old (id)
            on delete cascade
);

create table user_profiles
(
    id            bigint unsigned auto_increment
        primary key,
    avatar        json            null,
    bio           text            null,
    socials       json            null,
    contact       varchar(191)    null,
    notifications json            null,
    customer_id   bigint unsigned not null,
    created_at    timestamp       null,
    updated_at    timestamp       null,
    constraint user_profiles_customer_id_foreign
        foreign key (customer_id) references users_old (id)
);

create table user_shop
(
    id      bigint unsigned auto_increment
        primary key,
    user_id bigint unsigned not null,
    shop_id bigint unsigned not null,
    constraint user_shop_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade,
    constraint user_shop_user_id_foreign
        foreign key (user_id) references users_old (id)
            on delete cascade
);

create table users_otp
(
    id         bigint auto_increment
        primary key,
    user_id    bigint unsigned                                                                                                                                                                                                                                                                                                     not null,
    otp        varchar(10)                                                                                                                                                                                                                                                                                                         not null,
    type       enum ('verify_register', 'verified_register', 'verify_send_token', 'verified_send_token', 'verify_forgot_pass', 'verified_forgot_pass', 'verify_confirm_forgot_pass', 'verified_confirm_forgot_pass', 'verify_update_email', 'verified_update_email', 'verify_change_pass', 'verified_change_pass', 'verify_order') null,
    created_at bigint unsigned                                                                                                                                                                                                                                                                                                     null,
    updated_at bigint unsigned                                                                                                                                                                                                                                                                                                     null,
    constraint users_otp_ibfk_1
        foreign key (user_id) references users (id)
)
    collate = utf8mb4_bin
    row_format = DYNAMIC;

create index user_otp_FK
    on users_otp (user_id);

create index user_otp_type
    on users_otp (type);

create table users_transaction
(
    id           bigint unsigned auto_increment
        primary key,
    hash         varchar(255)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              null,
    type         enum ('signup_bonus', 'signup_bonus_f1', 'signup_bonus_f2', 'buy_package', 'send_token', 'receive_token', 'com_f1', 'com_f2', 'com_f3', 'com_f4', 'com_f5', 'com_f6', 'com_f7', 'com_f8', 'com_f9', 'com_f10', 'passive_f1_lv1', 'passive_f1_lv2', 'change_ptomxu_tomxu', 'change_ptomxu_tomxu_redeem', 'revoke_ptomxu', 'user_refund_vault', 'vault_refund', 'vault_distribute', 'vault_distribute_redeem', 'daily_bonus', 'auto_change_ptomxu_tomxu', 'auto_change_ptomxu_tomxu_redeem', 'payment_order_tomxu', 'hieu') null,
    user_id      bigint unsigned                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           not null comment 'người thực hiện giao dịch',
    agency_id    bigint unsigned                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           null comment 'giao dịch đại lý',
    from_id      bigint unsigned                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           null,
    to_id        bigint unsigned                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           null,
    token_id     bigint unsigned                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           null,
    status       enum ('pending', 'executing', 'success', 'failed') default 'pending'                                                                                                                                                                                                                                                                                                                                                                                                                                                      null,
    message      varchar(500)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                              null,
    value        decimal(24, 6)                                     default 0.000000                                                                                                                                                                                                                                                                                                                                                                                                                                                       null,
    fee          decimal(24, 6)                                     default 0.000000                                                                                                                                                                                                                                                                                                                                                                                                                                                       null,
    pre_balance  decimal(24, 6)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            null,
    post_balance decimal(24, 6)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            null,
    created_at   bigint unsigned                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           null,
    updated_at   bigint unsigned                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           null,
    date         bigint                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    null,
    package_id   bigint unsigned                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           null,
    constraint user_transaction_user_id_FK
        foreign key (user_id) references users (id)
)
    row_format = DYNAMIC;

create index agency_id
    on users_transaction (agency_id);

create index package_id
    on users_transaction (package_id);

create index user_transaction_from_id
    on users_transaction (from_id);

create index user_transaction_normal_user_id_date_type
    on users_transaction (user_id, type, date);

create index user_transaction_to_id
    on users_transaction (to_id);

create index user_transaction_token_id_FK
    on users_transaction (token_id);

create index user_transaction_type
    on users_transaction (type);

create table variation_options
(
    id                   bigint unsigned auto_increment
        primary key,
    title                varchar(191)              not null,
    image                json                      null,
    price                varchar(191)              not null,
    sale_price           varchar(191)              null,
    language             varchar(191) default 'en' not null,
    quantity             bigint unsigned           not null,
    sold_quantity        int          default 0    not null,
    is_disable           tinyint(1)   default 0    not null,
    sku                  varchar(191)              null,
    options              json                      not null,
    product_id           bigint unsigned           null,
    digital_file_tracker varchar(191)              null,
    created_at           timestamp                 null,
    updated_at           timestamp                 null,
    is_digital           tinyint(1)   default 0    not null,
    constraint variation_options_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade
);

create table order_product
(
    id                  bigint unsigned auto_increment
        primary key,
    order_id            bigint unsigned not null,
    product_id          bigint unsigned not null,
    variation_option_id bigint unsigned null,
    order_quantity      varchar(191)    not null,
    unit_price          double          not null,
    subtotal            double          not null,
    deleted_at          timestamp       null,
    created_at          timestamp       null,
    updated_at          timestamp       null,
    tomxu               double          null,
    tomxu_subtotal      double          null,
    constraint order_product_order_id_foreign
        foreign key (order_id) references orders (id)
            on delete cascade,
    constraint order_product_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade,
    constraint order_product_variation_option_id_foreign
        foreign key (variation_option_id) references variation_options (id)
);

create table reviews
(
    id                  bigint unsigned auto_increment
        primary key,
    order_id            bigint unsigned not null,
    user_id             bigint unsigned not null,
    shop_id             bigint unsigned not null,
    product_id          bigint unsigned not null,
    variation_option_id bigint unsigned null,
    comment             longtext        not null,
    rating              double          null,
    photos              json            null,
    deleted_at          timestamp       null,
    created_at          timestamp       null,
    updated_at          timestamp       null,
    constraint reviews_order_id_foreign
        foreign key (order_id) references orders (id)
            on delete cascade,
    constraint reviews_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade,
    constraint reviews_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade,
    constraint reviews_user_id_foreign
        foreign key (user_id) references users_old (id)
            on delete cascade,
    constraint reviews_variation_option_id_foreign
        foreign key (variation_option_id) references variation_options (id)
            on delete cascade
);

create table wallets
(
    id               bigint unsigned auto_increment
        primary key,
    total_points     double default 0 not null,
    points_used      double default 0 not null,
    available_points double default 0 not null,
    customer_id      bigint unsigned  null,
    created_at       timestamp        null,
    updated_at       timestamp        null,
    constraint wallets_customer_id_foreign
        foreign key (customer_id) references users (id)
            on delete cascade
);

create index wallets_customer_id_foreign_idx
    on wallets (customer_id);

create table wishlists
(
    id                  bigint unsigned auto_increment
        primary key,
    user_id             bigint unsigned not null,
    product_id          bigint unsigned not null,
    variation_option_id bigint unsigned null,
    created_at          timestamp       null,
    updated_at          timestamp       null,
    constraint wishlists_product_id_foreign
        foreign key (product_id) references products (id)
            on delete cascade,
    constraint wishlists_user_id_foreign
        foreign key (user_id) references users_old (id)
            on delete cascade,
    constraint wishlists_variation_option_id_foreign
        foreign key (variation_option_id) references variation_options (id)
            on delete cascade
);

create table withdraws
(
    id             bigint unsigned auto_increment
        primary key,
    shop_id        bigint unsigned                                                                     not null,
    amount         double(8, 2)                                                                        not null,
    payment_method varchar(191)                                                                        null,
    status         enum ('approved', 'pending', 'on_hold', 'rejected', 'processing') default 'pending' not null,
    details        text                                                                                null,
    note           text                                                                                null,
    deleted_at     timestamp                                                                           null,
    created_at     timestamp                                                                           null,
    updated_at     timestamp                                                                           null,
    constraint withdraws_shop_id_foreign
        foreign key (shop_id) references shops (id)
            on delete cascade
);

