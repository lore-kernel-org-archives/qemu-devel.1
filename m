Received: from eggs.gnu.org ([2001:4830:134:3::10]:60968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cQvyH-0001TW-Ai
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:56:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cQvyD-00056z-7I
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:56:13 -0500
Received: from mx6-phx2.redhat.com ([209.132.183.39]:50005)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cQvyC-00056q-VS
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 07:56:09 -0500
Date: Tue, 10 Jan 2017 07:56:08 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <981159428.621501.1484052968435.JavaMail.zimbra@redhat.com>
In-Reply-To: <871swbruax.fsf@dusky.pond.sub.org>
References: <20170109143437.30554-1-marcandre.lureau@redhat.com>
	<20170109143437.30554-9-marcandre.lureau@redhat.com>
	<871swbruax.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 08/21] qapi: move experimental note down
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
> > Use a better 'Note:' section, move it below parameters following
> > guidelines.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> Again, I don't mind moving stuff around if it helps getting this series
> wrapped, and doesn't make things less readable.  My only nit is the
> commit message's claim about the guidelines.  Let's sidestep it:
>=20
>     Move these notes down and prefix with "Note:", to please the doc
>     generator we're going to add.
>=20
> Okay?
>=20

ok, thanks
