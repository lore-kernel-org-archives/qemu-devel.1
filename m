Received: from eggs.gnu.org ([2001:4830:134:3::10]:52434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTEi5-0003f5-7R
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:21:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cTEi2-0004ac-2a
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:21:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cTEi1-0004aT-Pi
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 16:20:57 -0500
References: <cover.1484593565.git.ben@skyportsystems.com>
	<d8737523bcb760c29d8d5ca9bd86800fca9cb3c1.1484594095.git.ben@skyportsystems.com>
	<a4fa1114-56b0-e996-2756-d9f2e96ca7c7@redhat.com>
	<EE421B2A-48D8-40AE-B6A2-0261F4B1524E@skyportsystems.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <10cf4cb6-b775-54d0-12db-4d2336b6fbaa@redhat.com>
Date: Mon, 16 Jan 2017 15:20:55 -0600
MIME-Version: 1.0
In-Reply-To: <EE421B2A-48D8-40AE-B6A2-0261F4B1524E@skyportsystems.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oT0DfDJjIpqmWuolEJErFrkJ223MU9mX6"
Subject: Re: [Qemu-devel] [PATCH v2 1/6] docs: vm generation id device's
 description
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ben Warren <ben@skyportsystems.com>
Cc: qemu-devel@nongnu.org, Gal Hammer <ghammer@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oT0DfDJjIpqmWuolEJErFrkJ223MU9mX6
From: Eric Blake <eblake@redhat.com>
To: Ben Warren <ben@skyportsystems.com>
Cc: qemu-devel@nongnu.org, Gal Hammer <ghammer@redhat.com>
Message-ID: <10cf4cb6-b775-54d0-12db-4d2336b6fbaa@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/6] docs: vm generation id device's
 description
References: <cover.1484593565.git.ben@skyportsystems.com>
 <d8737523bcb760c29d8d5ca9bd86800fca9cb3c1.1484594095.git.ben@skyportsystems.com>
 <a4fa1114-56b0-e996-2756-d9f2e96ca7c7@redhat.com>
 <EE421B2A-48D8-40AE-B6A2-0261F4B1524E@skyportsystems.com>
In-Reply-To: <EE421B2A-48D8-40AE-B6A2-0261F4B1524E@skyportsystems.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/16/2017 02:08 PM, Ben Warren wrote:

>>>
>>> Signed-off-by: Ben Warren <ben@skyportsystems.com <mailto:ben@skyport=
systems.com>>
>>> Cc: Gal Hammer <ghammer@redhat.com <mailto:ghammer@redhat.com>>
>>
>> If you are basing this patch off of earlier work (for example, you
>> mentioned Igor's work), you may need additional S-o-b lines for work y=
ou
>> copied from the earlier versions.
>>
> yes, I used a previous patch set as a baseline and want to make sure cr=
edit goes to whoever did the real work.  In this case, Gal Hammer was the=
 original author, so I CC=E2=80=99d Him (or her) hoping to get an SOB.  S=
hould that be handled out-of-band?

If Gal already had S-o-b on the version you started with, then the most
common two approaches are:

1) Use Gal's commit message verbatim, including his S-o-b, then add
another paragraph about your changes, with your S-o-b.

2) Rewrite the commit message, but state that you are basing on Gal's
work, then list S-o-b for both content contributors next to one another.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--oT0DfDJjIpqmWuolEJErFrkJ223MU9mX6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYfTk3AAoJEKeha0olJ0NqEWQH/1cWqJ1TV24iPW+69UU4eKD1
Lo+lirMhgqw9SQngXx0PqIu4C48j1KtPabxBynLVj4PmMHl9SBr4MFqABqGh0tBV
jbOzb8WiCsL8xHFznnJtQ/k+sIE+m4amBbvPw4eMsEbGBQ0uL2jD73I3/yOtDiLY
yryYWO6UPkbTEEblAn/vR4MAcl9Fu+7JSPXOeLjzbmmjxbk31ySgUa8LLNr/CwsZ
dZeBNZOvb/gGD+E7qRKswyw41eiHvMYn8wC92u2mIQ0zqwvGu1q+0QdGdkTdZCTb
yRo3DsuvcS3qtTW1ix9szC3WEM6E3ayrsP29HBDGXX6qojq1kVuRwnzjcbA5Mwk=
=Pvfi
-----END PGP SIGNATURE-----

--oT0DfDJjIpqmWuolEJErFrkJ223MU9mX6--
