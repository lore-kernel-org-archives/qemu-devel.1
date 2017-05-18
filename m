Received: from eggs.gnu.org ([2001:4830:134:3::10]:39673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBOJW-0003RW-78
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dBOJT-0002ig-3D
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:30:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48986)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dBOJS-0002fp-Re
	for qemu-devel@nongnu.org; Thu, 18 May 2017 12:30:07 -0400
References: <1495134895-7814-1-git-send-email-yang.zhong@intel.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ed34d543-9f7a-61aa-4cce-f9d5369be5cf@redhat.com>
Date: Thu, 18 May 2017 11:30:00 -0500
MIME-Version: 1.0
In-Reply-To: <1495134895-7814-1-git-send-email-yang.zhong@intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="W5NFNc96aIElsrUs3M8l0Gp9JLs0VTnDt"
Subject: Re: [Qemu-devel] [PATCH 1/4] split the tcg accelerator from accel.c
 file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yang Zhong <yang.zhong@intel.com>, pbonzini@redhat.com
Cc: anthony.xu@intel.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--W5NFNc96aIElsrUs3M8l0Gp9JLs0VTnDt
From: Eric Blake <eblake@redhat.com>
To: Yang Zhong <yang.zhong@intel.com>, pbonzini@redhat.com
Cc: anthony.xu@intel.com, qemu-devel@nongnu.org
Message-ID: <ed34d543-9f7a-61aa-4cce-f9d5369be5cf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/4] split the tcg accelerator from accel.c
 file
References: <1495134895-7814-1-git-send-email-yang.zhong@intel.com>
In-Reply-To: <1495134895-7814-1-git-send-email-yang.zhong@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 05/18/2017 02:14 PM, Yang Zhong wrote:

Your system clock is way off.  From the headers:

> Received: from yangzhon-virtual.bj.intel.com ([10.238.145.52])
> 	by fmsmga002.fm.intel.com with ESMTP; 18 May 2017 04:17:51 -0700
> Date: Fri, 19 May 2017 03:14:52 +0800

Your computer claimed to mail this at 19:14 UTC Thursday, but the next
hop received it at 11:17 UTC (8 hours earlier).  Please fix this, as it
messes with mail clients that like to sort by threads with the most
recent activity.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--W5NFNc96aIElsrUs3M8l0Gp9JLs0VTnDt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZHcwJAAoJEKeha0olJ0NqFxYH/1sCEsymkerklkMray3Som7j
5SP2DiCNLUGRRVYTrkwgengO0WsDJYsZGU+x+XXPwwmXnYIpS72awSpricQ3PFrd
c8r7LshX3pp/3/vnrOapmR0hpiThabfCD/+RFMNeiR/lRL7uzxruxfHhPa2VA8I0
DtNT8g8aJUOudZGjbD08dwBNGWxqkLeasTq9m8bVo0GYSVh9bK1W3BXuiqfcW8jZ
Mn1uPscRxm16Emz2R+ZQcNF4UDcFOA5yCuDfJgyv4JAX79jTh/xfiCFu/Pmmb5aY
sjWMoKpi9oFcZR46U4Bzt/fX5kIFyrmbOZfr1+wPQLYUuYpmxDqvyIsAmqP1u8k=
=D8Td
-----END PGP SIGNATURE-----

--W5NFNc96aIElsrUs3M8l0Gp9JLs0VTnDt--
