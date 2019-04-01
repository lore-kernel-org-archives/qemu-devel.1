Received: from eggs.gnu.org ([209.51.188.92]:57883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAwTQ-0004xK-SK
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:55:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hAwTP-0001rp-Rl
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:55:36 -0400
References: <20190401092612.9658-1-aruna.15@cse.mrt.ac.lk>
From: Eric Blake <eblake@redhat.com>
Message-ID: <623ecf54-40ad-c811-8b60-41d82f99c778@redhat.com>
Date: Mon, 1 Apr 2019 07:55:32 -0500
MIME-Version: 1.0
In-Reply-To: <20190401092612.9658-1-aruna.15@cse.mrt.ac.lk>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="33gRJ94J5JxcBH1l7HonZ3wGLemhUspsy"
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Header cleanups for functions
 declared in utils/ files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--33gRJ94J5JxcBH1l7HonZ3wGLemhUspsy
From: Eric Blake <eblake@redhat.com>
To: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
Message-ID: <623ecf54-40ad-c811-8b60-41d82f99c778@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/2] Header cleanups for functions
 declared in utils/ files
References: <20190401092612.9658-1-aruna.15@cse.mrt.ac.lk>
In-Reply-To: <20190401092612.9658-1-aruna.15@cse.mrt.ac.lk>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/1/19 4:26 AM, Aruna Jayasena wrote:
> Declarations were moved out of qemu-common.h for functions declared in =
utils/ files.
> This task was under https://wiki.qemu.org/Contribute/BiteSizedTasks
>=20
> Signed-off-by: Aruna Jayasena <aruna.15@cse.mrt.ac.lk>
>=20
> ---

Thanks for working on this! Some hints for better reviews:

- you sent a series, but did not include a 0/2 cover letter; our
automated CI tools do best when there is a cover letter

- you did not describe how v2 differs from v1; here after the --- is a
good spot to mention it, to help reviewers double-check your changes from=
 v1

More patch submission hints can be found at
https://wiki.qemu.org/Contribute/SubmitAPatch

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--33gRJ94J5JxcBH1l7HonZ3wGLemhUspsy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlyiCkUACgkQp6FrSiUn
Q2ruEAf7BKIiIiVOGwrDOSEyELyz7WgZozajZ28TQib5aDPU/1T3t3G0kA3Ik0eF
TalsnUSXTKIgcSCEOMA14qLlmnZoe1KuNVKJtwWGn65/f6aSHO0eDkgDA9WeJRvb
2zDyMLSD6lC/S9f5trIAvBqmbQOQJP21uU2RcICnw6APzydXXm/er+7KHq5V+vVv
ZWTkIDYtJ4MrV7p49mIU6iwzmGizFritL0jhMTm9filc24OzW+oUpEJRCMDhxRaD
oEr55vS71gubKganF4RByAtaz/LUP6LjDzGuaxkg5QPeBz8u02B9yo1xP8DlxPvO
dwBJVBfjUZ6HR2lxAz4cntMWACvibA==
=r4IL
-----END PGP SIGNATURE-----

--33gRJ94J5JxcBH1l7HonZ3wGLemhUspsy--
