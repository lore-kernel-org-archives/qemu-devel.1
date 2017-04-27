Received: from eggs.gnu.org ([2001:4830:134:3::10]:37050)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3qzd-0000gB-J5
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1d3qzY-0001kO-VI
	for qemu-devel@nongnu.org; Thu, 27 Apr 2017 17:30:29 -0400
References: <20170427205100.9505-1-jsnow@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c8128e40-50f0-ac35-8f83-1c0853cf059d@redhat.com>
Date: Thu, 27 Apr 2017 16:30:18 -0500
MIME-Version: 1.0
In-Reply-To: <20170427205100.9505-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lIM04rk9QijfsHmFdnB83atsfpV0j1CPS"
Subject: Re: [Qemu-devel] [PATCH 0/2] iotests: trivial fixups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, kwolf@redhat.com, mreitz@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lIM04rk9QijfsHmFdnB83atsfpV0j1CPS
From: Eric Blake <eblake@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, kwolf@redhat.com, mreitz@redhat.com
Message-ID: <c8128e40-50f0-ac35-8f83-1c0853cf059d@redhat.com>
Subject: Re: [PATCH 0/2] iotests: trivial fixups
References: <20170427205100.9505-1-jsnow@redhat.com>
In-Reply-To: <20170427205100.9505-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/27/2017 03:50 PM, John Snow wrote:
> Excised from an old patchset from 2015, just a couple of touchups.
>=20
> John Snow (2):
>   iotests: clarify help text
>   iotests: fix exclusion option

Reviewed-by: Eric Blake <eblake@redhat.com>

[eww - we were really using 'ls' instead of 'echo' to expand a glob?
Your patch to switch to 'awk' is indeed nicer]

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--lIM04rk9QijfsHmFdnB83atsfpV0j1CPS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZAmLqAAoJEKeha0olJ0NqezsH/iy7UVtUP/gWAXGBCkgD4box
SAmuJxbeyK3rse0tX7wP7Yz5r86iWGX9XFeT+TSrT11eXfBO8EItQTa6NuP7t0ZE
HyCerSnoTyRkKlCAb9EqkhN9ZXHdRcjdCe9c2WJHItLCKcvSR9c/opwcSYuZVdta
DCERRtFZrOs3t19q6lE79FJB1zX4jPUmcg69Amo50lULoWRqqDccnU71FrT6pVYt
eNefAB13L663PcUsdNBNAVyiSsfNJZhnNIcLTZUyBycdFgAKE7aWjPEBhg4AS4cr
owNYmrQEYg3cvZtPkyeCbak9jSgHre4KN1gACON9Ruzz8wEURLYwOL6pPcF2FY0=
=f9pz
-----END PGP SIGNATURE-----

--lIM04rk9QijfsHmFdnB83atsfpV0j1CPS--
