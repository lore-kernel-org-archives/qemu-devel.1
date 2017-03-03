Received: from eggs.gnu.org ([2001:4830:134:3::10]:36840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjs0y-0006nW-Du
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:33:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cjs0x-0007Gw-BP
	for qemu-devel@nongnu.org; Fri, 03 Mar 2017 13:33:16 -0500
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
	<1488491046-2549-14-git-send-email-armbru@redhat.com>
	<90d9033f-49b2-6f00-d984-dbfd4f21f1da@redhat.com>
	<87zih2mgsr.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <0f03a9a8-6361-b5ec-a829-1dcb3677fa25@redhat.com>
Date: Fri, 3 Mar 2017 12:33:02 -0600
MIME-Version: 1.0
In-Reply-To: <87zih2mgsr.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ebG5IAGnxmNjJ3pnfs3LlwKu6uptUxpIc"
Subject: Re: [Qemu-devel] [PATCH 13/15] qapi-schema: Rename GlusterServer to
 SocketAddressFlat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp, jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ebG5IAGnxmNjJ3pnfs3LlwKu6uptUxpIc
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mitake.hitoshi@lab.ntt.co.jp,
 jcody@redhat.com, qemu-block@nongnu.org, namei.unix@gmail.com
Message-ID: <0f03a9a8-6361-b5ec-a829-1dcb3677fa25@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 13/15] qapi-schema: Rename GlusterServer to
 SocketAddressFlat
References: <1488491046-2549-1-git-send-email-armbru@redhat.com>
 <1488491046-2549-14-git-send-email-armbru@redhat.com>
 <90d9033f-49b2-6f00-d984-dbfd4f21f1da@redhat.com>
 <87zih2mgsr.fsf@dusky.pond.sub.org>
In-Reply-To: <87zih2mgsr.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/03/2017 11:05 AM, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
>=20

>>> +# @SocketAddressFlatType:
>>> +#
>>> +# Available SocketAddressFlat types
>>> +#
>>> +# @tcp:   Internet address
>>> +#
>>> +# @unix:  Unix domain socket
>>> +#
>>> +# Since: 2.9
>>
>> I probably would have listed 'since: 2.7', since the type is unchanged=

>> from its pre-move location...
>=20
> I'd have to bump it right in the next patch :)

Too true (now that I've read the next patch)!  No need to tweak it, then.=


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--ebG5IAGnxmNjJ3pnfs3LlwKu6uptUxpIc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYubbeAAoJEKeha0olJ0NqpGUIAI4guwyewIiviCsEqZRRBIBg
wIx0ywv8WgtHwUmohDCioTueqci7/rOTGa0wP0Sk0r6VEn4eqsVOa+ESQmVdVzfu
sC/UeNQOHYGs/2sb5Rc96f5Y56Zua5HNnql4pX+bEIS4HFiqONu9+6y1pd+H8Tkv
9/ii5dN0tShM7xQiWpEZGJPLzLhr6CGRFNafQFkT+jQttLwwQvm4od5wQBSR3XFq
EYgVs7EMdxUmTXsArNzDD/ezKiv071wVylgfOxpxJ2tRZuNr32R1goTH9WyLbQSi
e/e1Pa+hnpTVXl3j31zVWg4Ur9UE8hEFjWYtKFGIrVVfYYT3OMi6sLxXKMpH7MY=
=DWx6
-----END PGP SIGNATURE-----

--ebG5IAGnxmNjJ3pnfs3LlwKu6uptUxpIc--
