Received: from eggs.gnu.org ([2001:4830:134:3::10]:53901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csxCN-00059K-V8
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:54:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1csxCN-0001bY-7f
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:54:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1csxCM-0001bB-VV
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 15:54:35 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E3A969F73F
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 19:54:33 +0000 (UTC)
References: <1490708752-26902-1-git-send-email-armbru@redhat.com>
	<1490708752-26902-2-git-send-email-armbru@redhat.com>
	<f3b944ed-303c-31fa-7379-78f5076086cf@redhat.com>
	<87zig5s0ck.fsf@dusky.pond.sub.org>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b1fa7bd5-0b78-b15a-46ce-6efc871e583f@redhat.com>
Date: Tue, 28 Mar 2017 21:54:30 +0200
MIME-Version: 1.0
In-Reply-To: <87zig5s0ck.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3B1HIc0vxIu7cvCEDsA8Ir6LqcDXI9glp"
Subject: Re: [Qemu-devel] [PULL for-2.9] block: Declare blockdev-add and
 blockdev-del supported
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3B1HIc0vxIu7cvCEDsA8Ir6LqcDXI9glp
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <b1fa7bd5-0b78-b15a-46ce-6efc871e583f@redhat.com>
Subject: Re: [Qemu-devel] [PULL for-2.9] block: Declare blockdev-add and
 blockdev-del supported
References: <1490708752-26902-1-git-send-email-armbru@redhat.com>
 <1490708752-26902-2-git-send-email-armbru@redhat.com>
 <f3b944ed-303c-31fa-7379-78f5076086cf@redhat.com>
 <87zig5s0ck.fsf@dusky.pond.sub.org>
In-Reply-To: <87zig5s0ck.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 28.03.2017 20:49, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
>=20
>> On 28/03/2017 15:45, Markus Armbruster wrote:
>>> It's been a long journey, but here we are.
>>>
>>> The supported blockdev-add is not compatible to its experimental
>>> predecessors; bump all Since: tags to 2.9.
>>
>> Can you document the differences in the 2.9 changelog?
>=20
> Not sure I can before I drop off for a week of vacation.  Kevin, Max,
> can you chip in?

Just document the changes we have done to blockdev-add since it was
originally introduced? Sure, I'll have a shot.

Max


--3B1HIc0vxIu7cvCEDsA8Ir6LqcDXI9glp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljav3YSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AKBYH+wXahdpyGvOEB5/weNgvAieXKU/RBsru
wDTD7mLp/2/4cbG/B5/PJ5wXWGwtvGwcdnaYKxPNPVWF4mSGm+7Xqj+9/N+niaTd
Tn/J2qabKGopXwWehPTpz5VTnJqsVj+U3WeJFyGNj1A56X3bIZuFssB+Pt8g7X3j
93ZBwJUtRy//V69CO7xYmh2NyTOrpQNw2IBtlUphdEPJNXBPOVvuYni9uuNzVPQc
iMZp4/8kytUm0W5w9gTxV2d/tbcQoakXEnPSJrYRGM73gy1IBcc8jMqI6EaNnjxJ
7d/BAoQuEu1xpF+OpqI2UxEDfA30njpxo0/Wl7MT3n910o3P14HyDLY=
=6pdl
-----END PGP SIGNATURE-----

--3B1HIc0vxIu7cvCEDsA8Ir6LqcDXI9glp--
