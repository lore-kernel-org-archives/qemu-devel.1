Received: from eggs.gnu.org ([2001:4830:134:3::10]:48203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAdXD-0005re-11
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dAdX5-0003l0-2X
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:33:07 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dAdX4-0003k5-Su
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:33:03 -0400
Received: by mail-wm0-x243.google.com with SMTP id y10so38876747wmh.0
	for <qemu-devel@nongnu.org>; Tue, 16 May 2017 07:33:02 -0700 (PDT)
Date: Tue, 16 May 2017 15:32:59 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170516143259.GA18270@stefanha-x1.localdomain>
References: <20170513022143.2838-1-n54@gmx.com>
	<20170515141348.GN1201@stefanha-x1.localdomain>
	<b299b025-720c-f2c0-1d63-8baf9b96d8b5@gmx.com>
	<296a3be1-ded2-2fd9-5ea2-86b1e786d5b7@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZGiS0Q5IWpPtfppv"
Content-Disposition: inline
In-Reply-To: <296a3be1-ded2-2fd9-5ea2-86b1e786d5b7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] maintainers: Add myself as a NetBSD
 reviewer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Kamil Rytarowski <n54@gmx.com>, peter.maydell@linaro.org, qemu-devel@nongnu.org


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 15, 2017 at 04:43:41PM +0200, Paolo Bonzini wrote:
>=20
>=20
> On 15/05/2017 16:22, Kamil Rytarowski wrote:
> > On 15.05.2017 16:13, Stefan Hajnoczi wrote:
> >> On Sat, May 13, 2017 at 04:21:43AM +0200, Kamil Rytarowski wrote:
> >>> I volunteer to review NetBSD patches.
> >>> Adding myself will help to not miss some of them.
> >>>
> >>> Restore NetBSD as a maintained host.
> >>>
> >>> All patches to make qemu/pkgsrc building have been emitted to review.
> >>>
> >>> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> >>> ---
> >>>  MAINTAINERS | 6 ++++++
> >>>  configure   | 1 +
> >>>  2 files changed, 7 insertions(+)
> >>
> >> Will you maintain a patch queue (git repo) so you can send pull
> >> requests?  If yes, please add a T: field.
> >>
> >=20
> > I don't think that there is a need for an additional patch queue, at
> > least in the maintained mode as a volunteer in spare time.
> >=20
> > If there would be more BSD people, we could share a dedicated queue of
> > patches.
>=20
> How would patches be sent to the committer then?

After discussing on IRC it seems likely that NetBSD patches will go via
subsystem maintainers.  Therefore Kamil does not plan to send pull
requests directly.

Stefan

--ZGiS0Q5IWpPtfppv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZGw2bAAoJEJykq7OBq3PIvCoIAJXXICmgNR6rEOtNvSmdnHwF
uzMsH4+lSrnbavQ2qjDbkamIeYDhHSwic1qyYiUP43m+p1vdBDB84nvWxW9qRCeP
wjM1jKoB3cwsoLSrtg1SfZbMozihwCoW3pBFdkiedbpZjYe4Bng7Sj8lqNhGwnNc
r4+zuJ22irGjWrigJ5J/d2bV64My10V4aEXir71juXdSeL+r8hkYbnDaEguGMp47
TdjrXyUdS94pXMfVU/vOW+xzmUJBNDopHMTe+U7nmwltd+lCubCkqZh5BSeFCfpz
klj//I4ApNCj3zEz1AabsslDcXkVBwbKjCu7TqCP/fWzt/62kr55nrA6ygfeyQE=
=BcxY
-----END PGP SIGNATURE-----

--ZGiS0Q5IWpPtfppv--
