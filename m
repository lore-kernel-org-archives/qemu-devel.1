Received: from eggs.gnu.org ([2001:4830:134:3::10]:60865)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvmfj-0001eV-B6
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:16:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cvmfd-000193-Ga
	for qemu-devel@nongnu.org; Wed, 05 Apr 2017 11:16:35 -0400
References: <20170118161653.19296-1-eblake@redhat.com>
	<20170118161653.19296-3-eblake@redhat.com>
	<87lgu7flkc.fsf@dusky.pond.sub.org>
	<9e16eb02-dc8b-b25f-0aba-d4a9ff3b5a02@redhat.com>
	<274218e6-5539-9eef-56bc-c2de4d11a593@redhat.com>
	<20170405081835.GB30620@redhat.com>
	<alpine.DEB.2.20.1704051020170.3005@hadrien>
	<20170405082443.GD30620@redhat.com>
	<alpine.DEB.2.20.1704051037490.3005@hadrien>
	<20170405090151.GK30620@redhat.com>
	<1af948cb-4fbd-8ae4-8690-8a3f9e439987@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b7bab154-b87d-19e9-1108-4b1e68470eb8@redhat.com>
Date: Wed, 5 Apr 2017 10:16:01 -0500
MIME-Version: 1.0
In-Reply-To: <1af948cb-4fbd-8ae4-8690-8a3f9e439987@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G4n5HORm51WdufPits8VfwX2lV6mMQVrR"
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qdict: Add convenience helpers for
 wrapped puts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Richard W.M. Jones" <rjones@redhat.com>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Markus Armbruster <armbru@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Gerd Hoffmann <kraxel@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Alberto Garcia <berto@igalia.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, Fam Zheng <famz@redhat.com>, Chrysostomos Nanakos <chris@include.gr>, Stefan Weil <sw@weilnetz.de>, Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, "open list:X86" <xen-devel@lists.xensource.com>, Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G4n5HORm51WdufPits8VfwX2lV6mMQVrR
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>, Julia Lawall <julia.lawall@lip6.fr>
Cc: Markus Armbruster <armbru@redhat.com>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>, Jeff Cody <jcody@redhat.com>,
 qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Alberto Garcia <berto@igalia.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Anthony Perard <anthony.perard@citrix.com>, Fam Zheng <famz@redhat.com>,
 Chrysostomos Nanakos <chris@include.gr>, Stefan Weil <sw@weilnetz.de>,
 Peter Lieven <pl@kamp.de>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 "open list:X86" <xen-devel@lists.xensource.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>
Message-ID: <b7bab154-b87d-19e9-1108-4b1e68470eb8@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/6] qdict: Add convenience helpers for
 wrapped puts
References: <20170118161653.19296-1-eblake@redhat.com>
 <20170118161653.19296-3-eblake@redhat.com>
 <87lgu7flkc.fsf@dusky.pond.sub.org>
 <9e16eb02-dc8b-b25f-0aba-d4a9ff3b5a02@redhat.com>
 <274218e6-5539-9eef-56bc-c2de4d11a593@redhat.com>
 <20170405081835.GB30620@redhat.com>
 <alpine.DEB.2.20.1704051020170.3005@hadrien>
 <20170405082443.GD30620@redhat.com>
 <alpine.DEB.2.20.1704051037490.3005@hadrien>
 <20170405090151.GK30620@redhat.com>
 <1af948cb-4fbd-8ae4-8690-8a3f9e439987@redhat.com>
In-Reply-To: <1af948cb-4fbd-8ae4-8690-8a3f9e439987@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/05/2017 06:54 AM, Paolo Bonzini wrote:
>=20
>=20
> On 05/04/2017 11:01, Richard W.M. Jones wrote:
>> On Wed, Apr 05, 2017 at 10:38:37AM +0200, Julia Lawall wrote:
>>> OK, there is nothing special about g_assert_cmpint, but Coccinelle ex=
pects
>>> expressions or types in function argument lists, so it gives a parse =
error
>>> on finding an =3D=3D.
>>
>> I should have checked the coccinelle mailing list before asking you,
>> because I see that Eric already asked this question and you answered
>> it.  For reference, that is here:
>>
>>   https://systeme.lip6.fr/pipermail/cocci/2017-April/004107.html
>>
>> Thanks again,
>=20
> Eric, are you using the scripts/cocci-macro-file.h?
>=20
>     commit 6ad978e9f40d3edfd9f4a86b4a60e3523eff08fe
>     Author: Paolo Bonzini <pbonzini@redhat.com>
>     Date:   Wed May 18 11:11:55 2016 +0200
>=20
>     coccinelle: add g_assert_cmp* to macro file
>=20
>     This helps applying semantic patches to unit tests.
>=20
>     Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Didn't even realize it existed. I've updated my spatch command line
accordingly.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--G4n5HORm51WdufPits8VfwX2lV6mMQVrR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY5QozAAoJEKeha0olJ0NqZyIH/RSZS/jQOwKXKsvIFR5k0ouu
jjw+X8+DRTJHxheNmb0/Tem37BZNpx1WHZ2HDkfCccYFwSc3mIXp7W73aZ8EC51F
fP9yebnT/nK3ipcSTGCi/CfLE9qOQFJzhx1capNCAeOW1cPkjSRXD7A8HKAjsqwX
A7tDHVr0nXbIOCbNTsw6swwOIgYYLNeLKfyUZCBGYjVM1db+rncFIQHL0sDX7HNz
OWk0jh5Wd3AZsyIAKVqsfhxr43hBQ2REYXb87xbvceVLXxLSNVBxVMpwbFx/z6Y2
bLKXi/0Ko9MjZmYoON5ADzFjLpTlkYTFLY9reUeFu5KkpmttA9ko9+oC+KF3VYc=
=YUAs
-----END PGP SIGNATURE-----

--G4n5HORm51WdufPits8VfwX2lV6mMQVrR--
