Received: from eggs.gnu.org ([2001:4830:134:3::10]:46914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUX54-0005yB-VS
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:42:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dUX54-0007ed-1H
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 07:42:23 -0400
References: <20170707182151.29872-1-eblake@redhat.com>
	<20170710101604.GA19707@lemon.lan>
From: Eric Blake <eblake@redhat.com>
Message-ID: <94f33acf-57b4-62b7-7121-4e1e27048224@redhat.com>
Date: Mon, 10 Jul 2017 06:42:13 -0500
MIME-Version: 1.0
In-Reply-To: <20170710101604.GA19707@lemon.lan>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="whkVu9iV0i4A0uVP2rHmObXrWqQwaDLLc"
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Promote NBD to supported,
 with new maintainer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--whkVu9iV0i4A0uVP2rHmObXrWqQwaDLLc
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, qemu-block@nongnu.org
Message-ID: <94f33acf-57b4-62b7-7121-4e1e27048224@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Promote NBD to supported, with
 new maintainer
References: <20170707182151.29872-1-eblake@redhat.com>
 <20170710101604.GA19707@lemon.lan>
In-Reply-To: <20170710101604.GA19707@lemon.lan>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/10/2017 05:16 AM, Fam Zheng wrote:
> On Fri, 07/07 13:21, Eric Blake wrote:
>> We are promising more than just odd fixes, and Paolo is hoping
>> to offload the pull requests to me.  Also, enough of NBD is related
>> to the block layer that it is worth including qemu-block on patches.
>=20
> Cool!
>=20

>> +Network Block Device (NBD)
>> +M: Eric Blake <eblake@redhat.com>
>> +M: Paolo Bonzini <pbonzini@redhat.com>
>> +L: qemu-block@nongnu.org
>> +S: Maintained
>> +F: block/nbd*
>> +F: nbd/
>> +F: include/block/nbd*
>> +F: qemu-nbd.c
>=20
> While we are at it, add qemu-nbd.texi when you send pull request, if yo=
u don't
> respin?

Will do.

>=20
>> +T: git git://repo.or.cz/qemu/ericb.git nbd
>=20
> Out of curiosity: Paolo is still in "M:", but his "T:" is gone.  Intend=
ed?

Hmm, I didn't realize you could list two T: entries, but a quick check
shows that is the case for several co-maintained areas.  Paolo, any
preference?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--whkVu9iV0i4A0uVP2rHmObXrWqQwaDLLc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZY2gVAAoJEKeha0olJ0Nqh/sH+weF3UQkH4XcUQeD9NIV6IVf
d7ACo+erMRqMq176CEGzYXqRZO44h/LYohA2PPf+/Pzq2vNc2jasP8cTE2kKV8AW
/pLRfH5jc/zrzeTKHzoSR7kpkSg5is4z8xlYdsksTJwrkqUX4JI62SfnlFQ5cI5C
R70ZJZfJcb3gscbEyGTSwjrWps5lZcSy/CI7B9SXooQSd1VUmC8wc6jJtGoW9OSf
9TNAamCM7NXIiJgYBo4khN1QTIMc+xn67WSL7hoO2wlUAl69oumMsLRT8znQSDjK
NMinRIfd/JyqakEBCatL6xDK8i++oSXk/1SDwH0CPw8k2/5J1c6wvDpaZP004tI=
=xGCZ
-----END PGP SIGNATURE-----

--whkVu9iV0i4A0uVP2rHmObXrWqQwaDLLc--
