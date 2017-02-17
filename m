Received: from eggs.gnu.org ([2001:4830:134:3::10]:43505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ceklb-0003Wy-Q0
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:48:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cekla-0001EW-M1
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 10:48:15 -0500
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-26-git-send-email-vsementsov@virtuozzo.com>
	<20170216142144.GG4869@noname.redhat.com>
	<e572baaf-f726-ee89-ae33-b8e2d99125e5@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <86274ce0-34df-1f60-0f9d-41327153bdc8@redhat.com>
Date: Fri, 17 Feb 2017 09:48:05 -0600
MIME-Version: 1.0
In-Reply-To: <e572baaf-f726-ee89-ae33-b8e2d99125e5@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="UaWmVvGrfs278wqI8Wf0V4U6WtPJexOq9"
Subject: Re: [Qemu-devel] [PATCH v15 25/25] qcow2-bitmap: improve
 check_constraints_on_bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UaWmVvGrfs278wqI8Wf0V4U6WtPJexOq9
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 armbru@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org,
 stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <86274ce0-34df-1f60-0f9d-41327153bdc8@redhat.com>
Subject: Re: [PATCH v15 25/25] qcow2-bitmap: improve
 check_constraints_on_bitmap
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
 <1487153430-17260-26-git-send-email-vsementsov@virtuozzo.com>
 <20170216142144.GG4869@noname.redhat.com>
 <e572baaf-f726-ee89-ae33-b8e2d99125e5@virtuozzo.com>
In-Reply-To: <e572baaf-f726-ee89-ae33-b8e2d99125e5@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/17/2017 04:18 AM, Vladimir Sementsov-Ogievskiy wrote:
> 16.02.2017 17:21, Kevin Wolf wrote:
>> Am 15.02.2017 um 11:10 hat Vladimir Sementsov-Ogievskiy geschrieben:
>>> Add detailed error messages.
>>>
>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com=
>
>> Why not merge this patch into the one that originally introduced the
>> function?
>=20
> Just to not create extra work for reviewers

It's extra work for reviewers if you don't rebase obvious fixes where
they belong - a new reviewer may flag the issue in the earlier patch
only to find out later in the series that you've already fixed it.
Avoiding needless code churn is part of what rebasing is all about - you
want each step of the series to be self-contained and as correct as
possible, by adding in the fixes at the point where they make sense,
rather than at the end of the series.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--UaWmVvGrfs278wqI8Wf0V4U6WtPJexOq9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYpxs1AAoJEKeha0olJ0Nq62kH/AmdDGW994YpRhQATPhmSXwp
klk5Me4t345pHbuXA5BFM+wFbCzsP2Gom9dui7Z7U5XBjH02bspHJc+jnIB/vA4v
C5GfFa1Z0VDhuAPQAwThHHQHN90U4L09ydEVLS/xB0gcfjb6m/174ZSrqqUvqE9D
I6Zwwwyl5ljuFMHqNXjx7eb88BLCNXocgybiWYXCLo6AdJ0DrMvxKar1KWcQdjTP
X8MGNm4eUDXX2iFffcILsKusYuwZqZROi6RpLMaAlFEm/8LRULfa392DxczzvF8x
juWLjb8HO/hZxjGN8oiwCZuDdC7VztCXgRqetD+gzoSdlBPVnmbzvjtVDKwZl7Y=
=zHvc
-----END PGP SIGNATURE-----

--UaWmVvGrfs278wqI8Wf0V4U6WtPJexOq9--
