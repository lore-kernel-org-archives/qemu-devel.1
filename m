Received: from eggs.gnu.org ([2001:4830:134:3::10]:38323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df4um-00064a-2G
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:51:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1df4uh-0006OU-1W
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:51:20 -0400
References: <20170803163353.19558-1-eblake@redhat.com>
	<3fdaf7c5-591e-4702-126d-b6013a12a690@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <70c58145-ab14-a9b5-69d4-4bf39cc180af@redhat.com>
Date: Tue, 8 Aug 2017 08:50:55 -0500
MIME-Version: 1.0
In-Reply-To: <3fdaf7c5-591e-4702-126d-b6013a12a690@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="wb32metNqmGpw5SBBHMkQJttKdW8hVi67"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 for-2.10 0/4] improved
 --version/--help tweaks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, berrange@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wb32metNqmGpw5SBBHMkQJttKdW8hVi67
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, berrange@redhat.com,
 qemu-block@nongnu.org, mreitz@redhat.com, pbonzini@redhat.com,
 Jeff Cody <jcody@redhat.com>
Message-ID: <70c58145-ab14-a9b5-69d4-4bf39cc180af@redhat.com>
Subject: Re: [Qemu-block] [PATCH v3 for-2.10 0/4] improved --version/--help
 tweaks
References: <20170803163353.19558-1-eblake@redhat.com>
 <3fdaf7c5-591e-4702-126d-b6013a12a690@redhat.com>
In-Reply-To: <3fdaf7c5-591e-4702-126d-b6013a12a690@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/07/2017 07:08 PM, John Snow wrote:
>=20
>=20
> On 08/03/2017 12:33 PM, Eric Blake wrote:
>> Not sure if this should go through Kevin's block tree, Paolo's
>> miscellaneous patches, or if I should just do a pull request
>> myself (since patch 4 includes a change to qemu-nbd)
>>

>=20
> Nothing to keep the commands from going out of order again, it looks
> like -- can this be added as a comment or otherwise scripted as a
> ./hey_it_looks_like_you_are_about_to_release_qemu.sh script that makes
> sure we've dotted the 'i's and crossed the 't's?

We don't add subcommands to qemu-img all that frequently; I think a
comment is okay without having to figure out where to script things.

>=20
> Lastly, Didn't we fix the certificate issue? (I thought Jeff had) -- an=
d
> even if not, it's still the correct address to send people to IMO. Let
> people report to us if the SSL certificate appears to be broken.

That can be a followup-patch.

>=20
> Eh, regardless of shed coloring:
>=20
> Reviewed-by: John Snow <jsnow@redhat.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--wb32metNqmGpw5SBBHMkQJttKdW8hVi67
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmJwb8ACgkQp6FrSiUn
Q2rMvAf7Bru1HRAnGWdQg5dbWC4B0D3oSymnMErlN9fRXktYN5EsWVHDdy+IQy52
KVbq3+1BfiKZE6716P6DoMBjOpocA2LMM2NUOyZsBHByqkwQc7MMDECYd6cPAJXg
axo1F613dYINg16ygPDS+HeGJTQmmXraYeBrDBH83s+j3cEAFTo3DCg17nlncr0r
Y/5XFMfsFFWkmciT8jCRMdCzlr18o7S9f3lSI7fczKoHTETHjsKinMLQiwMjyokF
8JGjYLBKiWTseYi+ya9uQCjVY9oAv9wmbo3CbjSPDvmJp109x+dl76T6GrmRyKWW
TVlRm5a0mmkW1bzE+A5438o++H3P5w==
=qYQm
-----END PGP SIGNATURE-----

--wb32metNqmGpw5SBBHMkQJttKdW8hVi67--
