Received: from eggs.gnu.org ([2001:4830:134:3::10]:37454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fEM9P-00073O-2q
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:52:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fEM9L-0004XB-Nn
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:52:31 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:59585)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fEM9L-0004V7-Bv
	for qemu-devel@nongnu.org; Thu, 03 May 2018 17:52:27 -0400
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
	<20180501122436.GA14803@stefanha-x1.localdomain>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bdccdec2-b4dd-6a7f-282e-91885c5749c8@vivier.eu>
Date: Thu, 3 May 2018 23:52:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180501122436.GA14803@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Wl1zQ6eSq93BHPMnnluuEpiVsqiRwcl8q"
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
To: Stefan Hajnoczi <stefanha@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Wl1zQ6eSq93BHPMnnluuEpiVsqiRwcl8q
From: Laurent Vivier <laurent@vivier.eu>
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>
Message-ID: <bdccdec2-b4dd-6a7f-282e-91885c5749c8@vivier.eu>
Subject: Re: [Qemu-devel] release retrospective, next release timing,
 numbering
References: <CAFEAcA-hha7jMSfPTdNEVKhuJr4nwAx4wKmEk5E9+j-JS4U14w@mail.gmail.com>
 <20180501122436.GA14803@stefanha-x1.localdomain>
In-Reply-To: <20180501122436.GA14803@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Le 01/05/2018 =C3=A0 14:24, Stefan Hajnoczi a =C3=A9crit=C2=A0:
> On Fri, Apr 27, 2018 at 04:51:03PM +0100, Peter Maydell wrote:
>> (2) release timing:
>>  * usual schedule would give us a next release mid-to-late August
>>  * unless I can persuade Stefan to do the release management this
>>    cycle we might need to wind that in by a couple of weeks so
>>    it's definitely done by the middle of August, to avoid a clash
>>    with a personal commitment
>=20
> I will be offline mid-August to mid-September, sorry.  Someone else can=

> volunteer to do the release.
>=20
>> (3) retrospective, lessons learned &c
>>  * please remember that if every single submaintainer submits
>>    a pull request on the morning of an RC, it is physically
>>    not possible for me to process all those pulls in time to
>>    tag the RC that day. We had several RCs which got delayed
>>    by a day because of this; please try to submit earlier
>>    rather than later...
>>  * provide your opinions here ?
>=20
> Paolo asked sub-maintainers to include changelogs in pull request
> messages.  This will make it easy to collate the QEMU 3.0 changelog jus=
t
> from the merge commits.  I think it's a good idea.

BTW, is there a way to have "git publish --pull-request" opens
automatically an editor with the cover letter?

I've just forgot to fill the entry in my last pull request...

Thanks,
Laurent


--Wl1zQ6eSq93BHPMnnluuEpiVsqiRwcl8q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEzS913cjjpNwuT1Fz8ww4vT8vvjwFAlrrhJQACgkQ8ww4vT8v
vjy9Lw/+JIonFPFbh6els+bda9nC1/52MD+9nMxe2TcXiVM+CuF8dZnadzwElZr4
wOKer9/BAPgiXFvH8JJba4Uowb/rH1sP1Tq9vWIMBVO91IrIP1EDEgpkPS7+SFnt
K/PFkjToT8hiXWLiTZNv4DpQrjQ9d/s+DzBo2bK5D7Wz+03ahQlhDjXi5RFEYjm0
iVrXS6VdeC3OXmwrWbBgOKjG1KHKjdTV6wGg144g0a8/cY7/23Ciw7z2n28uHARz
sOOWUQg3LqNoCh5J+Kdvy8gQorsiO0cFS6WawxtxuokG7uEON12M5NeDvMfA/TXp
5EFU/BEOCjEA5NcE4vn86MQ7PTvuf34d8rX44t4rrXN26esCGPRoCkyuRf5ZOF24
a2JY5DLJrYsv3krB3RV7o3NZsmbwnAswaEW1gdXfmt0WeRRoQEKC6N93fwWYBKXz
gqRo9mOq9RbJpcZjMe6Ew3dfCgstSbQAloiHmkOO20D78gDsIue8yTOwlNZUm3I0
Tmx/G3arYbjcnNn4Dzf8eUEKNCOfY1g42QMDp7YQpWLAtZL4bn2QGVw2k9llpUW9
KU4tD5ClGkJ7GRv1HLP/O2CLvT/yN/kQ14VuALhtWYptMnY+J8KnjrS28D0cg4tm
Q+YftWwrJl0/pNNTwE10CwNx5rSlPQBoz+cCnHsvfw5OQMpL/QI=
=FLBH
-----END PGP SIGNATURE-----

--Wl1zQ6eSq93BHPMnnluuEpiVsqiRwcl8q--
