Received: from eggs.gnu.org ([2001:4830:134:3::10]:47067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWTYQ-0004OF-BY
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWTYM-0000vN-Fj
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:52:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53560)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eWTYM-0000uV-6B
	for qemu-devel@nongnu.org; Tue, 02 Jan 2018 15:52:54 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 537BD8046F
	for <qemu-devel@nongnu.org>; Tue,  2 Jan 2018 20:52:53 +0000 (UTC)
References: <20171201125813.1437-1-quintela@redhat.com>
	<4c899960-36f2-0f0f-bc21-08693f472ba2@redhat.com>
	<34b2798c-9e32-1ae6-943e-afaa621c39c8@redhat.com>
	<c1ae6595-4947-bcf5-1b60-81573400a77a@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2d5d32b2-15a5-1b0d-89b0-d1de416fb86e@redhat.com>
Date: Tue, 2 Jan 2018 14:52:49 -0600
MIME-Version: 1.0
In-Reply-To: <c1ae6595-4947-bcf5-1b60-81573400a77a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nR65ZzWEeqIjoAZ52A5GkS4St4J53wxKp"
Subject: Re: [Qemu-devel] [PATCH v3 0/6] Add make check tests for Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nR65ZzWEeqIjoAZ52A5GkS4St4J53wxKp
From: Eric Blake <eblake@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>,
 qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peterx@redhat.com
Message-ID: <2d5d32b2-15a5-1b0d-89b0-d1de416fb86e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/6] Add make check tests for Migration
References: <20171201125813.1437-1-quintela@redhat.com>
 <4c899960-36f2-0f0f-bc21-08693f472ba2@redhat.com>
 <34b2798c-9e32-1ae6-943e-afaa621c39c8@redhat.com>
 <c1ae6595-4947-bcf5-1b60-81573400a77a@redhat.com>
In-Reply-To: <c1ae6595-4947-bcf5-1b60-81573400a77a@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/01/2017 12:44 PM, Eric Blake wrote:
> On 12/01/2017 12:38 PM, Laurent Vivier wrote:
>> On 01/12/2017 19:30, Eric Blake wrote:
>>> On 12/01/2017 06:58 AM, Juan Quintela wrote:
>>>> Hi
>>>>
>>>> This is on top of my info_migrate series.
>>>
>>> Let patchew know about it:
>>>
>>> Based-on: <20171201125750.1372-1-quintela@redhat.com>
>>> ([PATCH v3 0/2] Improve info migrate output on destination)
>>
>> Is this tag documented somewhere?
>>
>=20
> https://lists.gnu.org/archive/html/qemu-devel/2017-08/msg01288.html
>=20
> But yes, it should also be documented in the wiki and/or other places
> where we document patch submission guidelines.
>=20
> Volunteers?

I've updated https://wiki.qemu.org/Contribute/SubmitAPatch to mention
patchew and the Based-on tag line, but there may still be other places
worth updating.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--nR65ZzWEeqIjoAZ52A5GkS4St4J53wxKp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpL8SEACgkQp6FrSiUn
Q2pXEQf+J1u2vKivKBiCDMsQN3Uc1Xaj5Hffdq+7MiPpU0aMHosF01/qQtiVMstk
PvX+aBSGm8qgBFQjKWei9/BwHWmxPeiY+olNWo9E0xxG/j1q3JPThRqZXVKnxUSU
oLxiAk/QHusXHj7bhCPw2gyBq1t4Z49qZyzY/GOhRM95TIinSup5WN781HVuFKpO
mPqqYb8Zr/osP40EgwGcV84dUB7T/4R4eV+FcPUIhh+5v+0ZtA0qepO4K10XkiHz
lX/ZqMfAPf2QEUoDykrPzuEQ0eY7gDaiB37U36/TyBVnlfa4+Qp7JfVPaYQMOO7L
WcJ3TjnJxlO219cm/476Ji3p05EVtg==
=xTVV
-----END PGP SIGNATURE-----

--nR65ZzWEeqIjoAZ52A5GkS4St4J53wxKp--
