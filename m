Received: from eggs.gnu.org ([2001:4830:134:3::10]:59784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2fKv-00020v-Vu
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:23:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e2fKs-0000T7-FZ
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:23:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e2fKs-0000Rd-7G
	for qemu-devel@nongnu.org; Thu, 12 Oct 2017 11:23:46 -0400
References: <1507655662-28101-1-git-send-email-peter.maydell@linaro.org>
	<d56cf809-5f37-2fff-bcb1-80296cf5f33a@linaro.org>
	<2d38fb05-c496-1cc3-9253-cc01b2ba8a1b@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <e1d53fc9-10fc-84a5-e796-1c801a07614e@redhat.com>
Date: Thu, 12 Oct 2017 10:23:42 -0500
MIME-Version: 1.0
In-Reply-To: <2d38fb05-c496-1cc3-9253-cc01b2ba8a1b@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MSxtjV7AVT6DSXL2xph1bGaEMvGqsUnug"
Subject: Re: [Qemu-devel] [PATCH v3] docs/devel/loads-stores.rst: Document
 our various load and store APIs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MSxtjV7AVT6DSXL2xph1bGaEMvGqsUnug
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: patches@linaro.org, Richard Henderson <rth@twiddle.net>
Message-ID: <e1d53fc9-10fc-84a5-e796-1c801a07614e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3] docs/devel/loads-stores.rst: Document our
 various load and store APIs
References: <1507655662-28101-1-git-send-email-peter.maydell@linaro.org>
 <d56cf809-5f37-2fff-bcb1-80296cf5f33a@linaro.org>
 <2d38fb05-c496-1cc3-9253-cc01b2ba8a1b@redhat.com>
In-Reply-To: <2d38fb05-c496-1cc3-9253-cc01b2ba8a1b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/12/2017 10:13 AM, Paolo Bonzini wrote:
> On 12/10/2017 17:10, Richard Henderson wrote:
>> On 10/10/2017 10:14 AM, Peter Maydell wrote:
>>> QEMU has a wide selection of different functions for doing
>>> loads and stores; provide some overview documentation of
>>> what they do and how to pick which one to use.
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

>> Modulo the 2 typos that Eric found,
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> What path should this patch take in?
>=20
> I can take it.

Be sure to take v4, though :)

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--MSxtjV7AVT6DSXL2xph1bGaEMvGqsUnug
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnfiP4ACgkQp6FrSiUn
Q2r6EQf+PTiujk13DVXpE22WfGZOsImWiNlcgkXH+Qb/iPJ4NUWMfDjcCWDCW4X1
Iiq/JAjWjXM3jhFiWZWcNiLRTvd5W0EgK9r8Udb5yx2ytnqNN/Yn5V5MXt1E7PB3
W5zFaBH+mNOrvqe3of4WTsZxDYewmVOmfQ7HGXi2DUtngS+pdqTjADyg6p+egyR4
vLAh/LDhYCWVeojz2ulShSJ0a5TvyaIHqpDZrZlQ4SkX75AViN06q+ZZGRfsTG+r
uXzSi8pFmS3woVJ38NRNzRs4D6a+OddrM5Nzz48IoBKOQtXDIRpZNQWiV76UC60f
DBET6hhnmkLLozUXQUYSCdJrpzmqNA==
=nkAp
-----END PGP SIGNATURE-----

--MSxtjV7AVT6DSXL2xph1bGaEMvGqsUnug--
