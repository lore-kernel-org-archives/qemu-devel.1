Received: from eggs.gnu.org ([2001:4830:134:3::10]:36543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFkvF-0002Rp-Jp
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 12:59:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eFkvE-0004Dj-Rn
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 12:59:25 -0500
References: <20171116173810.16457-1-crosa@redhat.com>
	<20171116173810.16457-7-crosa@redhat.com>
	<ab332f27-f2ab-c321-b2a2-2132b2acf366@redhat.com>
	<e50344ef-cdef-2733-210b-9fc3631f6cea@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <36a42ee2-b292-a86a-dde2-76ad45c63b7e@redhat.com>
Date: Fri, 17 Nov 2017 11:59:16 -0600
MIME-Version: 1.0
In-Reply-To: <e50344ef-cdef-2733-210b-9fc3631f6cea@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="WDL16T6DgKnOU20LHdoplQmh6HDV5Vh4A"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 06/10] qemu-iotests: turn
 owner variable into a comment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WDL16T6DgKnOU20LHdoplQmh6HDV5Vh4A
From: Eric Blake <eblake@redhat.com>
To: Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Message-ID: <36a42ee2-b292-a86a-dde2-76ad45c63b7e@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 06/10] qemu-iotests: turn owner
 variable into a comment
References: <20171116173810.16457-1-crosa@redhat.com>
 <20171116173810.16457-7-crosa@redhat.com>
 <ab332f27-f2ab-c321-b2a2-2132b2acf366@redhat.com>
 <e50344ef-cdef-2733-210b-9fc3631f6cea@redhat.com>
In-Reply-To: <e50344ef-cdef-2733-210b-9fc3631f6cea@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/17/2017 07:18 AM, Cleber Rosa wrote:
>=20
>=20
> On 11/17/2017 02:19 AM, Paolo Bonzini wrote:
>> On 16/11/2017 18:38, Cleber Rosa wrote:
>>> This variables has no real use.  To avoid pretending it does, while
>>> still keeping the information, let's turn it into a comment.
>>>
>>> The format chosen is the one already being used on tests 149 and 194.=

>>
>> I would just delete it...
>>
>> Paolo
>>
>=20
> I'm fine with both, but I feel this is like putting info on ChangeLogs
> in the days of GIT.  Unless other people object, I'll remove them in v2=
=2E

I'm also in the 'please delete it; git history is good enough' camp.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--WDL16T6DgKnOU20LHdoplQmh6HDV5Vh4A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAloPI3QACgkQp6FrSiUn
Q2pzOwf/fRkR0G5xWh0J+IspNdywlgsX/EQUEUYl5SGHab+BUAxvYJ3/CaxWNxCl
xOi2uw3cLfm5J6oTkyyyF+EgVHPtcUKrXd0ZL1SmpRSYqevWELkrQdbSTjl6/sSS
goU7bHVo+Em+eWHIqW9GPQHW/x8ct+T/2BKEwa3oa7pRnStEZq0QHyV2DU62sDBV
khdGXEfHBmnFgHaG41h/haKfzSBCsE0Sh1i+65H5wwvC78Cw7QSqEcheTBRnWta0
eiHR22O5EVurfs8mKjYRh647Pg6ywYGhtgekAD+ICBaIzU6EITF3zEfI7SOs63kw
bJ5ZhCxuI+jty0vlhIf+t4eoG2SqrQ==
=r5w+
-----END PGP SIGNATURE-----

--WDL16T6DgKnOU20LHdoplQmh6HDV5Vh4A--
