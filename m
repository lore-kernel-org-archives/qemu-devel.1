Received: from eggs.gnu.org ([2001:4830:134:3::10]:50245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQXT7-0003cz-3V
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQXT3-0008R0-SP
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:46:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:13842)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cQXT3-0008QY-Mo
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 05:46:21 -0500
Date: Mon, 9 Jan 2017 10:41:43 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170109104143.GB30228@stefanha-x1.localdomain>
References: <a6803686-9435-0276-0118-10961dc97e04@redhat.com>
	<20170103155347.GF14707@stefanha-x1.localdomain>
	<68e906ee-5604-644c-78cd-d39f0d164406@redhat.com>
	<20170104145133.GD8194@stefanha-x1.localdomain>
	<CAFEAcA_+33bEyPab4pzAF8pR8W+XixyaUrM+1dyWH4hyDUWuqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <CAFEAcA_+33bEyPab4pzAF8pR8W+XixyaUrM+1dyWH4hyDUWuqw@mail.gmail.com>
Subject: Re: [Qemu-devel] Proposal for 2.9 release schedule
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2017 at 03:12:28PM +0000, Peter Maydell wrote:
> On 4 January 2017 at 14:51, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > On Tue, Jan 03, 2017 at 05:06:13PM +0100, Paolo Bonzini wrote:
> >> On 03/01/2017 16:53, Stefan Hajnoczi wrote:
> >> > On Fri, Dec 23, 2016 at 03:15:58PM +0100, Paolo Bonzini wrote:
> >> >> Considering that Easter is on April 16th, we'd probably want to hav=
e the
> >> >> release before that date even in case of a slip.
> >> >>
> >> >> On the other hand, the Christmas / New Year break here means that w=
e'll
> >> >> have to make the development time 1-2 week shorter in practice.
> >> >>
> >> >> 2016-02-21     2.9 soft freeze
> >> >> 2016-03-07     hard freeze / rc0
> >> >> 2016-03-28     rc3 (+3 weeks)
> >> >> 2016-04-04     rc4 or release
> >> >> 2016-04-11     release (if rc4)
> >> >>
> >> >> One possibility is to make soft freeze happen a few days later.
> >> >> Peter/Stefan, how did the experiment go with the new rules for soft
> >> >> freeze?  Is it worth repeating it for 2.9 and would it make sense to
> >> >> shorten soft freeze given the new rules?
> >> >
> >> > I would shorten the soft freeze by 1 week.
> >> >
> >> > Overall the 2.8 release went smoothly.  We got unlucky right at the =
end
> >> > with a release blocker but otherwise it was fine.
> >>
> >> Then what about soft freeze on 2016-02-28?
> >
> > Sounds good to me.  Peter?
>=20
> Are we retaining the "make sure you have your pull requests on the list
> by the softfreeze date" rule this time around?

I hope so.  It helps keep the freeze time bounded.

Stefan

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYc2jnAAoJEJykq7OBq3PIwr0H/iLqqDsfp9JJd5WwgIggInRz
3P7N2VVfELCDxBI010N17HcEAS1ZU+iqfiiHaV1u/J57jGAjrr/ReLr3e3YBH9e4
6W976sPEMdijkGtIiSyiAfFut054/yZwkV60EiBUNOgrvyBFR2o1H4wnBMVcL+z7
ZPtV9nFXU/Wa7r5LzfDK6ru4zobcCLR9krh1eY1JmKXUuQXzbbCHVJisT0zs11xq
chzW7m3HfFccSkyny24J7boV1tYM4MpPbytOtSnZ9dK6zqz9lnzO+UfyMJRUoHG6
csFDP1teOQdHZ6rtZ63jXRrqb0RD7wZIYCW2s6AfoJdxS+TODJgxOtjaGVkwMW0=
=nnJR
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
