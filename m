Received: from eggs.gnu.org ([2001:4830:134:3::10]:45486)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOmz2-0007ta-2z
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:56:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cOmyy-0005nc-Tu
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:56:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39582)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cOmyy-0005nM-Np
	for qemu-devel@nongnu.org; Wed, 04 Jan 2017 09:56:04 -0500
Date: Wed, 4 Jan 2017 14:51:33 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170104145133.GD8194@stefanha-x1.localdomain>
References: <a6803686-9435-0276-0118-10961dc97e04@redhat.com>
	<20170103155347.GF14707@stefanha-x1.localdomain>
	<68e906ee-5604-644c-78cd-d39f0d164406@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OaZoDhBhXzo6bW1J"
Content-Disposition: inline
In-Reply-To: <68e906ee-5604-644c-78cd-d39f0d164406@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel <qemu-devel@nongnu.org>


--OaZoDhBhXzo6bW1J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 03, 2017 at 05:06:13PM +0100, Paolo Bonzini wrote:
> On 03/01/2017 16:53, Stefan Hajnoczi wrote:
> > On Fri, Dec 23, 2016 at 03:15:58PM +0100, Paolo Bonzini wrote:
> >> Considering that Easter is on April 16th, we'd probably want to have t=
he
> >> release before that date even in case of a slip.
> >>
> >> On the other hand, the Christmas / New Year break here means that we'll
> >> have to make the development time 1-2 week shorter in practice.
> >>
> >> 2016-02-21     2.9 soft freeze
> >> 2016-03-07     hard freeze / rc0
> >> 2016-03-28     rc3 (+3 weeks)
> >> 2016-04-04     rc4 or release
> >> 2016-04-11     release (if rc4)
> >>
> >> One possibility is to make soft freeze happen a few days later.
> >> Peter/Stefan, how did the experiment go with the new rules for soft
> >> freeze?  Is it worth repeating it for 2.9 and would it make sense to
> >> shorten soft freeze given the new rules?
> >=20
> > I would shorten the soft freeze by 1 week.
> >=20
> > Overall the 2.8 release went smoothly.  We got unlucky right at the end
> > with a release blocker but otherwise it was fine.
>=20
> Then what about soft freeze on 2016-02-28?

Sounds good to me.  Peter?

Stefan

--OaZoDhBhXzo6bW1J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYbQv1AAoJEJykq7OBq3PIu6YIAKt8A0TduToGP/FrLIbxho0g
/8p+LXqbSWbOUZ6OgtXkHnu/gn7FesvhyYxMHztQ27+GSx8krx0R7MKOAUIPQNe6
Mi4fF9S9e1eSaoK7Kj8/0tWEqTWjjtUs5h4tE0YPBEHutgpjVv/CzLi8Go24toR6
58lyKycZakwA9h6GglYx8XxVvuoghC/parsS7TOKZnUMES6lgg58UdgthjDqy9yv
/tRAra/wGhsp0RWWnJbkKSvt1vukgrFKe6iKdsuoblc7O3hJn0gRrX7XcWtlzfve
DCUa72RrL7PlrlZv9c0Ov4hAck0TKkTlSoNx0158gu9gKW/V44KuQW2sRX/vLf0=
=4ePI
-----END PGP SIGNATURE-----

--OaZoDhBhXzo6bW1J--
