Received: from eggs.gnu.org ([2001:4830:134:3::10]:38761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cORPN-0003ey-Ia
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:53:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cORPK-00069s-HK
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:53:53 -0500
Received: from mail-wj0-x243.google.com ([2a00:1450:400c:c01::243]:32867)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cORPK-00069l-B5
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 10:53:50 -0500
Received: by mail-wj0-x243.google.com with SMTP id kp2so72326436wjc.0
	for <qemu-devel@nongnu.org>; Tue, 03 Jan 2017 07:53:50 -0800 (PST)
Date: Tue, 3 Jan 2017 15:53:47 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170103155347.GF14707@stefanha-x1.localdomain>
References: <a6803686-9435-0276-0118-10961dc97e04@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VuQYccsttdhdIfIP"
Content-Disposition: inline
In-Reply-To: <a6803686-9435-0276-0118-10961dc97e04@redhat.com>
Subject: Re: [Qemu-devel] Proposal for 2.9 release schedule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>


--VuQYccsttdhdIfIP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 23, 2016 at 03:15:58PM +0100, Paolo Bonzini wrote:
> Considering that Easter is on April 16th, we'd probably want to have the
> release before that date even in case of a slip.
>=20
> On the other hand, the Christmas / New Year break here means that we'll
> have to make the development time 1-2 week shorter in practice.
>=20
> 2016-02-21     2.9 soft freeze
> 2016-03-07     hard freeze / rc0
> 2016-03-28     rc3 (+3 weeks)
> 2016-04-04     rc4 or release
> 2016-04-11     release (if rc4)
>=20
> One possibility is to make soft freeze happen a few days later.
> Peter/Stefan, how did the experiment go with the new rules for soft
> freeze?  Is it worth repeating it for 2.9 and would it make sense to
> shorten soft freeze given the new rules?

I would shorten the soft freeze by 1 week.

Overall the 2.8 release went smoothly.  We got unlucky right at the end
with a release blocker but otherwise it was fine.

Stefan

--VuQYccsttdhdIfIP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYa8kLAAoJEJykq7OBq3PI9YkIAJ98x1OCNeJTwHKTiCtNTdJO
kOMfxsMrpGu7g0k1e+KfPVTQ8q910iAdibA7pWiYe4yy2D6S+N4pQE5Dgg3U7rBw
mym339MWc8Y8yaqxGcox1hl2w0ddECJYuj9MJMofWwcQ1ibJoPZYP3156bhS8Gq+
wqFHcnkokZf40BVBJP8m9NC3fq01ziylT1gocajzAaB0itiApFTWBYlzlJi6rie3
gtxkneUxV0E0vqneuDGKSj5Xt1TJyPkWmm0+mNjduTccQIU8VtfWJkafjrLFQkeE
hAP3f39m/nPhr4Gxm7YjjsT7nqME/fVVW0CGoEzkSI/8qWZmFgGFwLTibRFa9rs=
=Pt3T
-----END PGP SIGNATURE-----

--VuQYccsttdhdIfIP--
