Received: from eggs.gnu.org ([2001:4830:134:3::10]:55361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fDUKv-0002te-E4
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:24:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fDUKs-0001I2-9u
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:24:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37560 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1fDUKs-0001Hh-3x
	for qemu-devel@nongnu.org; Tue, 01 May 2018 08:24:46 -0400
Date: Tue, 1 May 2018 13:24:36 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180501122436.GA14803@stefanha-x1.localdomain>
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
In-Reply-To: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 27, 2018 at 04:51:03PM +0100, Peter Maydell wrote:
> (2) release timing:
>  * usual schedule would give us a next release mid-to-late August
>  * unless I can persuade Stefan to do the release management this
>    cycle we might need to wind that in by a couple of weeks so
>    it's definitely done by the middle of August, to avoid a clash
>    with a personal commitment

I will be offline mid-August to mid-September, sorry.  Someone else can
volunteer to do the release.

> (3) retrospective, lessons learned &c
>  * please remember that if every single submaintainer submits
>    a pull request on the morning of an RC, it is physically
>    not possible for me to process all those pulls in time to
>    tag the RC that day. We had several RCs which got delayed
>    by a day because of this; please try to submit earlier
>    rather than later...
>  * provide your opinions here ?

Paolo asked sub-maintainers to include changelogs in pull request
messages.  This will make it easy to collate the QEMU 3.0 changelog just
=66rom the merge commits.  I think it's a good idea.

Stefan

--LQksG6bCIzRHxTLp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa6FyDAAoJEJykq7OBq3PIj5gIAMf2Y4ytyK/loJ1kE+9+/nWW
L5WKpnG8iS5BoqgJItXWpKmRKGEbp2r9p1xz74hhG+tuKe3/s0GJ3QYoswyYhojg
21fqIp0sc1s19/deUBFCFwOoZf36nFJ4IZK8FNRjCBUhiyokB1+ysk8TzpZJKF5e
XLNbkt9hfda9ZLAqlUGINFePYfrEWAxEnvF0OnINrLOoe1HLil8skYdzE/O9XJEb
fPunq+exzOf44r1R1SfIZAA0LjGdzGvOdl2kaO0IXXici1WLqPF9ebHioBhxm3y5
5lYcxiJOi5g8N9apDSSwpvxO6IcaCtHa8Y4Jh5o+QliUrnehc5PYd7Ilm5BvpRQ=
=OD/b
-----END PGP SIGNATURE-----

--LQksG6bCIzRHxTLp--
