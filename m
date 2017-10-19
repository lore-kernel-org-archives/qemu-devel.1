Received: from eggs.gnu.org ([2001:4830:134:3::10]:38220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5Asc-00031m-NN
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5AsZ-0004xc-Gp
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 09:28:58 -0400
References: <1508336428-20511-1-git-send-email-thuth@redhat.com>
	<9d7d4163-1752-64a1-e5e1-d0b45bd3eb46@redhat.com>
	<20171019114331.44a29bec.cohuck@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <09614aaf-cf6d-1fa4-50d4-f481f1fde401@redhat.com>
Date: Thu, 19 Oct 2017 08:28:44 -0500
MIME-Version: 1.0
In-Reply-To: <20171019114331.44a29bec.cohuck@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="TqkUvtiSta65upec34dRIudg7xH5716t7"
Subject: Re: [Qemu-devel] [PATCH 0/2] Enable the simple virtio tests on
 s390x, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Michael S Tsirkin <mst@redhat.com>, Amit Shah <amit@kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--TqkUvtiSta65upec34dRIudg7xH5716t7
From: Eric Blake <eblake@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Michael S Tsirkin <mst@redhat.com>,
 Amit Shah <amit@kernel.org>
Message-ID: <09614aaf-cf6d-1fa4-50d4-f481f1fde401@redhat.com>
Subject: Re: [PATCH 0/2] Enable the simple virtio tests on s390x, too
References: <1508336428-20511-1-git-send-email-thuth@redhat.com>
 <9d7d4163-1752-64a1-e5e1-d0b45bd3eb46@redhat.com>
 <20171019114331.44a29bec.cohuck@redhat.com>
In-Reply-To: <20171019114331.44a29bec.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/19/2017 04:43 AM, Cornelia Huck wrote:
> On Wed, 18 Oct 2017 10:01:57 -0500
> Eric Blake <eblake@redhat.com> wrote:
>=20
>> On 10/18/2017 09:20 AM, Thomas Huth wrote:
>>> First patch introduces the qtest_startf() function that can be used
>>> to start tests with a printf-like string. This patch was originally
>>> part of Eric's bigger qtest refactoring series, and I originally want=
ed
>>> to wait 'til it's included in the master branch. But since this did
>>> not happen yet and QEMU soft-freeze is approaching soon, I decided
>>> to rather included a slightly simplified version of that patch here
>>> instead. =20
>>
>> Fair enough.  I'm also trying to focus on getting features in before
>> soft freeze, hence my lack of rebasing the qtest refactoring series in=

>> the meantime.  Arguably (although it is a bit weak) we can claim
>> testsuite fixes as material that is still relevant after soft freeze a=
s
>> it does not affect the final installed binaries, as long as they still=

>> go in before hard freeze, but it's hard to say at this point if any of=

>> my qtest refactoring will make 2.11.
>>
>=20
> Hi Eric,
>=20
> does Thomas' port of your patch look sane? If yes, I'll queue both
> patches on s390-next for 2.11.

Yes, it's fine with me.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--TqkUvtiSta65upec34dRIudg7xH5716t7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnoqIwACgkQp6FrSiUn
Q2oMKAf/TEjq5vhC0dZJp6FrhKfUYQKMtaihtpViyMDO93YfN1C+7UluLmR/mfHE
0Wr824JYX6JSpZ/XCiQ9fnph0VspzRsE4TS0B+q6JYic44EzrXPipgWgM0I4PFO5
8x9AeuJC43/iXn9vIb2L+Y69DQJU+N/pfo2rPYK526cCPa1qAraQaVlwSBDQbIAc
kco5ULpfhbdRm3NrN2RxkbpIU+AoDoqVOuccwOlnKpcfraXY+boWORzL0kl+IGw7
ELw2KBqts9MVWKIQM40xLsm54pT0Zpo4qjnHSv690L0DBQbt++3Hk57LZDXhP2Zb
BB82T0AlpcYokPNosE1ND5Jr8q0MXw==
=HEmS
-----END PGP SIGNATURE-----

--TqkUvtiSta65upec34dRIudg7xH5716t7--
