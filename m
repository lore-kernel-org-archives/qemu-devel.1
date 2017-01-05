Received: from eggs.gnu.org ([2001:4830:134:3::10]:45717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cPCdt-0002uo-T0
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 13:20:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cPCdq-0000k0-QB
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 13:20:01 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:33142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cPCdq-0000jq-IJ
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 13:19:58 -0500
Date: Thu, 5 Jan 2017 13:19:58 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <679529165.2474667.1483640398141.JavaMail.zimbra@redhat.com>
In-Reply-To: <871swzr753.fsf@dusky.pond.sub.org>
References: <20161206141343.28044-1-marcandre.lureau@redhat.com>
	<20161206141343.28044-18-marcandre.lureau@redhat.com>
	<871swzr753.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v6 17/17] build-sys: add qapi doc
 generation targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org

Hi

----- Original Message -----
> Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com> writes:
>=20
> > Generate and install the man, txt and html versions of QAPI
> > documentation (generate and install qemu-doc.txt too).
>=20
> Sure you don't install qemu-doc.txt in the previous patch already?
>=20

qemu-doc.txt is not qapi doc :)
