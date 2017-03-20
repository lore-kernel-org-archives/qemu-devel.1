Received: from eggs.gnu.org ([2001:4830:134:3::10]:53258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cpxIn-0003M1-A7
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cpxIi-00073L-AC
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:24:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cpxIi-000737-4g
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 09:24:44 -0400
Date: Mon, 20 Mar 2017 09:24:42 -0400 (EDT)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <476095945.9831617.1490016282082.JavaMail.zimbra@redhat.com>
In-Reply-To: <1490015515-25851-4-git-send-email-armbru@redhat.com>
References: <1490015515-25851-1-git-send-email-armbru@redhat.com>
	<1490015515-25851-4-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 3/6] qapi: Drop unused QAPIDoc
 member optional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre lureau <marcandre.lureau@redhat.com>, eblake@redhat.com, mdroth@linux.vnet.ibm.com



----- Original Message -----
> Unused since commit aa964b7 "qapi2texi: Convert to QAPISchemaVisitor"
>=20
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>  scripts/qapi.py | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/scripts/qapi.py b/scripts/qapi.py
> index e88c047..6c4d554 100644
> --- a/scripts/qapi.py
> +++ b/scripts/qapi.py
> @@ -106,7 +106,6 @@ class QAPIDoc(object):
>              self.name =3D name
>              # the list of lines for this section
>              self.content =3D []
> -            self.optional =3D False
> =20
>          def append(self, line):
>              self.content.append(line)
> --
> 2.7.4
>=20
>=20
