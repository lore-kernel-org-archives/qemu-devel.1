Received: from eggs.gnu.org ([2001:4830:134:3::10]:58241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebtfD-0003F4-WF
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 14:46:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ebtfD-0008G8-4i
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 14:46:24 -0500
References: <20180117193757.73471-1-borntraeger@de.ibm.com>
	<20180117193757.73471-2-borntraeger@de.ibm.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c309fedd-29c0-e627-11e4-64fcbb7f09f5@redhat.com>
Date: Wed, 17 Jan 2018 13:46:04 -0600
MIME-Version: 1.0
In-Reply-To: <20180117193757.73471-2-borntraeger@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="jw6BMPTsYK41mbUFIsMCEEDqUEmtUhc28"
Subject: Re: [Qemu-devel] [PATCH v2 1/3] header sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jw6BMPTsYK41mbUFIsMCEEDqUEmtUhc28
From: Eric Blake <eblake@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: Janosch Frank <frankja@linux.vnet.ibm.com>, Thomas Huth
 <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>,
 qemu-s390x <qemu-s390x@nongnu.org>, Halil Pasic <pasic@linux.vnet.ibm.com>,
 Richard Henderson <rth@twiddle.net>
Message-ID: <c309fedd-29c0-e627-11e4-64fcbb7f09f5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 1/3] header sync
References: <20180117193757.73471-1-borntraeger@de.ibm.com>
 <20180117193757.73471-2-borntraeger@de.ibm.com>
In-Reply-To: <20180117193757.73471-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/17/2018 01:37 PM, Christian Borntraeger wrote:
> replace with proper header sync
>=20
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  linux-headers/asm-s390/kvm.h | 9 ++++-----
>  linux-headers/linux/kvm.h    | 5 +++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
>=20
> diff --git a/linux-headers/asm-s390/kvm.h b/linux-headers/asm-s390/kvm.=
h
> index 32d372e..11def14 100644
> --- a/linux-headers/asm-s390/kvm.h
> +++ b/linux-headers/asm-s390/kvm.h
> @@ -6,10 +6,6 @@
>   *
>   * Copyright IBM Corp. 2008
>   *
> - * This program is free software; you can redistribute it and/or modif=
y
> - * it under the terms of the GNU General Public License (version 2 onl=
y)
> - * as published by the Free Software Foundation.
> - *

Is dropping a license clause intentional?  If so, the commit message may
want to go into more details why it is okay.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--jw6BMPTsYK41mbUFIsMCEEDqUEmtUhc28
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpfp/wACgkQp6FrSiUn
Q2qxwAf6AvUplrAPdnN5HrrKkrn8p1nPQj+leVOaFQEKyKFNY4JGjBfuawZNQ9g4
C3zDYdFM8ib51GwsQ1QEyQ3bWc80KWYsCylWCa3NfTO+lbbLZAh6flZlvpFOo6Re
VwUrfxIemduhl87brBX7je2W2bmKpaQuVShCXC49OoT9y2j1ffWN2NL3MBh14MOb
S6GFhytNToqkLDJ7nOW1pMKJE2F2zmJHLpnQPRGmUknrYJHb+u7UPZvo1iey44Re
vkWnlVS6ONB0Qz8W2e2sMdhuE9ujY+YJmLH6XPWTUOQq6PnPUec1BP4Q6fu0mDFF
kWO0SdavNc+z2AvvmFTlMuulyrvEtw==
=YRnN
-----END PGP SIGNATURE-----

--jw6BMPTsYK41mbUFIsMCEEDqUEmtUhc28--
