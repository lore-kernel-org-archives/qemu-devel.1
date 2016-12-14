Received: from eggs.gnu.org ([2001:4830:134:3::10]:57251)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cHBCB-0000DO-PL
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:10:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cHBCA-0003y7-Ne
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:10:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cHBCA-0003wo-IM
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 10:10:14 -0500
Date: Wed, 14 Dec 2016 23:10:10 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20161214151010.GA11881@lemon>
References: <20161214144713.11009-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161214144713.11009-1-stefanha@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.8] po: add missing translations in de, fr, it,
 zh
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Kevin Wolf <kwolf@redhat.com>, Pino Toscano <ptoscano@redhat.com>

On Wed, 12/14 14:47, Stefan Hajnoczi wrote:
> There are missing translations for the new "Copy" menu item.
>=20
> The following people provided them to me on IRC just in time for the
> QEMU 2.8 release:
>=20
>  * de_DE - Stefan Hajnoczi <stefanha@redhat.com>
>  * fr_FR - Laurent Vivier <laurent@vivier.eu>
>  * it    - Pino Toscano <ptoscano@redhat.com>
>  * zh_CN - Fam Zheng <famz@redhat.com>
>=20
> Reported-by: Kevin Wolf <kwolf@redhat.com>
> Cc: Fam Zheng <famz@redhat.com>
> Cc: Pino Toscano <ptoscano@redhat.com>
> Cc: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  po/de_DE.po | 2 +-
>  po/fr_FR.po | 2 +-
>  po/it.po    | 4 ++--
>  po/zh_CN.po | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/po/de_DE.po b/po/de_DE.po
> index 7dcd0dc..de27fcf 100644
> --- a/po/de_DE.po
> +++ b/po/de_DE.po
> @@ -46,7 +46,7 @@ msgstr "_Vollbild"
> =20
>  #: ui/gtk.c:2032
>  msgid "_Copy"
> -msgstr ""
> +msgstr "_Kopieren"
> =20
>  #: ui/gtk.c:2048
>  msgid "Zoom _In"
> diff --git a/po/fr_FR.po b/po/fr_FR.po
> index 358532b..94f4a94 100644
> --- a/po/fr_FR.po
> +++ b/po/fr_FR.po
> @@ -47,7 +47,7 @@ msgstr "Mode _plein =C3=A9cran"
> =20
>  #: ui/gtk.c:2032
>  msgid "_Copy"
> -msgstr ""
> +msgstr "_Copier"
> =20
>  #: ui/gtk.c:2048
>  msgid "Zoom _In"
> diff --git a/po/it.po b/po/it.po
> index 8eadf2f..bfae84e 100644
> --- a/po/it.po
> +++ b/po/it.po
> @@ -42,11 +42,11 @@ msgstr "_Esci"
> =20
>  #: ui/gtk.c:2029
>  msgid "_Fullscreen"
> -msgstr ""
> +msgstr "A t_utto schermo"
> =20
>  #: ui/gtk.c:2032
>  msgid "_Copy"
> -msgstr ""
> +msgstr "_Copia"
> =20
>  #: ui/gtk.c:2048
>  msgid "Zoom _In"
> diff --git a/po/zh_CN.po b/po/zh_CN.po
> index 9523cfb..3491bf2 100644
> --- a/po/zh_CN.po
> +++ b/po/zh_CN.po
> @@ -47,7 +47,7 @@ msgstr "=E5=85=A8=E5=B1=8F(_F)"
> =20
>  #: ui/gtk.c:2032
>  msgid "_Copy"
> -msgstr ""
> +msgstr "=E5=A4=8D=E5=88=B6 (_C)"

Other entries don't have the space before the open parenthesis, could you=
 drop
it when applying?

Fam

> =20
>  #: ui/gtk.c:2048
>  msgid "Zoom _In"
> --=20
> 2.9.3
>=20
