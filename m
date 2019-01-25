Received: from eggs.gnu.org ([209.51.188.92]:35899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gn37K-0003Ng-7M
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:10:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gn2zI-0001aW-51
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 10:01:45 -0500
References: <20181221234750.23577-1-mreitz@redhat.com>
	<20181221234750.23577-4-mreitz@redhat.com>
	<b064fb74-520f-3551-3d0c-603889e0cee6@redhat.com>
	<04d2a9e7-9cb8-74cf-0c0e-0c9d19940020@redhat.com>
	<8204d711-5769-c2f7-7baf-0d26eaf8fa54@redhat.com>
	<57f12e0d-0fef-43f6-ab18-86624ed4d152@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c6b7307d-8394-c415-bd97-72f7542e0c36@redhat.com>
Date: Fri, 25 Jan 2019 16:01:26 +0100
MIME-Version: 1.0
In-Reply-To: <57f12e0d-0fef-43f6-ab18-86624ed4d152@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GLcm7hXKfXjvTI0LPUZMLB20BBQvkSPtn"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/3] iotests: Allow 147 to be
 run concurrently
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GLcm7hXKfXjvTI0LPUZMLB20BBQvkSPtn
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <c6b7307d-8394-c415-bd97-72f7542e0c36@redhat.com>
Subject: Re: [Qemu-block] [PATCH 3/3] iotests: Allow 147 to be run
 concurrently
References: <20181221234750.23577-1-mreitz@redhat.com>
 <20181221234750.23577-4-mreitz@redhat.com>
 <b064fb74-520f-3551-3d0c-603889e0cee6@redhat.com>
 <04d2a9e7-9cb8-74cf-0c0e-0c9d19940020@redhat.com>
 <8204d711-5769-c2f7-7baf-0d26eaf8fa54@redhat.com>
 <57f12e0d-0fef-43f6-ab18-86624ed4d152@redhat.com>
In-Reply-To: <57f12e0d-0fef-43f6-ab18-86624ed4d152@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.19 18:47, John Snow wrote:
>=20
>=20
> On 1/23/19 12:34 PM, Max Reitz wrote:
>> On 23.01.19 14:05, Max Reitz wrote:
>>> On 21.01.19 21:50, John Snow wrote:
>>
>> [...]
>>
>>>> I guess my only other observation is that we have a lot of "while Tr=
ue"
>>>> loops now, is it worth creating some kind of helper that does the di=
rty
>>>> work of finding a serviceable port or nah?
>>>
>>> Seems reasonable, I'll see how it looks.
>>
>> If I do that, the diff stat looks to be 40+, 33-.  Is that worth it?
>>
>> Max
>>
>=20
> Instead of:
>  1 file changed, 68 insertions(+), 30 deletions(-)
>=20
> Or in addition to?

In addition to.

> Use your own judg[e?]ment on it, I guess it's local to this one iotest
> for now anyway, so if it's not an obvious win just skip it.

OK.  I guess I'll skip it then, but let it be noted that your criticism
was listened to. :-)

Max


--GLcm7hXKfXjvTI0LPUZMLB20BBQvkSPtn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlxLJMcACgkQ9AfbAGHV
z0D41gf/SbGOjZ/F+vjYMthidgrfr6byF1yRkqR8EOyevzof5FQ2IuG+vJuQDrFL
n4cCfRLjRBMtthshT55XRM+6f1ZmOd9XPRYG3Eknttdbz/mQAl6a0AG9EugUXjXK
1a39hD+ZcEJC9e1bS/6RBs4wtmi4LqDRd4CSapfxJOYQFse58fH3BSiz5L3U+Ken
yPh/HMbHnr3dgNlAb5DE6zaDcdK+pFR6kIPrNrNUvBA6iZagVs++0ch9FOMBa6cy
taYtAAPCFq0YCOkzw84MmFE6BPAvcoSIoSZJp6jqW+eDFj03jhMA3KPYKdTElVjo
aV+yDJM928TKQ19oZdUk9ZlUajMsjA==
=iwAU
-----END PGP SIGNATURE-----

--GLcm7hXKfXjvTI0LPUZMLB20BBQvkSPtn--
