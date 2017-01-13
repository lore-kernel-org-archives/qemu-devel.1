Received: from eggs.gnu.org ([2001:4830:134:3::10]:44089)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cS4gd-00076m-0R
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1cS4gY-0002bP-4e
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:26:43 -0500
Received: from mx4-phx2.redhat.com ([209.132.183.25]:43888)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1cS4gX-0002bA-RB
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 11:26:38 -0500
Date: Fri, 13 Jan 2017 11:26:37 -0500 (EST)
From: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <mlureau@redhat.com>
Message-ID: <871234022.2428064.1484324797286.JavaMail.zimbra@redhat.com>
In-Reply-To: <87pojrhr7d.fsf@dusky.pond.sub.org>
References: <20170113144135.5150-1-marcandre.lureau@redhat.com>
	<20170113144135.5150-13-marcandre.lureau@redhat.com>
	<87pojrhr7d.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 12/21] qapi.py: fix line break before
 binary operator pep8
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
> > Python code style accepts both form, but pep8 complains. Better to clea=
n
> > up the single warning for now, so new errors stand out more easily.
> >
> > Fix scripts/qapi.py:1539:21: W503 line break before binary operator
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>=20
> I'm dropping this patch, as per review of v7.

Sorry, I thought I dropped it. I think I screwed up with my two branches (m=
aintaining both split/squash series was quite a pain, I am relieved we are =
nearing the end)
