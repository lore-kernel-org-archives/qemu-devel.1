Received: from eggs.gnu.org ([2001:4830:134:3::10]:47449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDtrk-00005J-1j
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dDtre-00012g-6j
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:35:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dDtrd-00012W-Tl
	for qemu-devel@nongnu.org; Thu, 25 May 2017 10:35:46 -0400
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
	<a3f2cae3-5d3d-f620-4a8d-bb11470c0b08@redhat.com>
	<591AA65F.8080608@intel.com>
	<d6eb1d73-c791-b8d3-7ef3-a7653aef00d6@redhat.com>
	<7e1b48d5-83e6-a0ae-5d91-696d8db09d7c@redhat.com>
	<591D0EF5.9000807@intel.com>
	<d7df5484-7e08-4e1c-9e35-69d73858c736@redhat.com>
	<20170519153329.GA30573@stefanha-x1.localdomain>
	<ec3c391c-6f0a-b316-e7d9-8f5e431b5e45@redhat.com>
	<286AC319A985734F985F78AFA26841F7392351DD@shsmsx102.ccr.corp.intel.com>
	<7ff05785-6bca-a886-0eb0-aeeb0f8d8e1a@redhat.com>
	<5923CCF2.2000001@intel.com>
	<3d9e8375-fbaa-c011-8242-b37cd971069b@redhat.com>
	<5924136A.4090004@intel.com>
	<7636d3d0-a0de-f9a6-47f8-2d09a448b978@redhat.com>
	<592544D9.5010100@intel.com>
	<23dac05e-ba3d-df6d-4831-feab9be1c6d2@redhat.com>
	<5926C7AC.4080603@intel.com>
	<6a6ecbcd-e9ae-1cf0-ccd9-14294cd0cf86@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <aa5366b4-d67f-ffb3-b1f1-7d7799d51dea@redhat.com>
Date: Thu, 25 May 2017 09:35:39 -0500
MIME-Version: 1.0
In-Reply-To: <6a6ecbcd-e9ae-1cf0-ccd9-14294cd0cf86@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PfEX0343HC8Gu2B5WCAPlX2uaSL6BcD3x"
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [PATCH v2 00/16]
 Vhost-pci for inter-VM communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@gmail.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PfEX0343HC8Gu2B5WCAPlX2uaSL6BcD3x
From: Eric Blake <eblake@redhat.com>
To: Jason Wang <jasowang@redhat.com>, Wei Wang <wei.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@gmail.com>
Cc: "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "mst@redhat.com" <mst@redhat.com>
Message-ID: <aa5366b4-d67f-ffb3-b1f1-7d7799d51dea@redhat.com>
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [PATCH v2 00/16]
 Vhost-pci for inter-VM communication
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
 <a3f2cae3-5d3d-f620-4a8d-bb11470c0b08@redhat.com>
 <591AA65F.8080608@intel.com>
 <d6eb1d73-c791-b8d3-7ef3-a7653aef00d6@redhat.com>
 <7e1b48d5-83e6-a0ae-5d91-696d8db09d7c@redhat.com>
 <591D0EF5.9000807@intel.com>
 <d7df5484-7e08-4e1c-9e35-69d73858c736@redhat.com>
 <20170519153329.GA30573@stefanha-x1.localdomain>
 <ec3c391c-6f0a-b316-e7d9-8f5e431b5e45@redhat.com>
 <286AC319A985734F985F78AFA26841F7392351DD@shsmsx102.ccr.corp.intel.com>
 <7ff05785-6bca-a886-0eb0-aeeb0f8d8e1a@redhat.com>
 <5923CCF2.2000001@intel.com>
 <3d9e8375-fbaa-c011-8242-b37cd971069b@redhat.com>
 <5924136A.4090004@intel.com>
 <7636d3d0-a0de-f9a6-47f8-2d09a448b978@redhat.com>
 <592544D9.5010100@intel.com>
 <23dac05e-ba3d-df6d-4831-feab9be1c6d2@redhat.com>
 <5926C7AC.4080603@intel.com>
 <6a6ecbcd-e9ae-1cf0-ccd9-14294cd0cf86@redhat.com>
In-Reply-To: <6a6ecbcd-e9ae-1cf0-ccd9-14294cd0cf86@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

[meta-comment]

On 05/25/2017 07:22 AM, Jason Wang wrote:
>=20

[snip]

>>>>>>>>>>>>>>>> On 2017=E5=B9=B405=E6=9C=8816=E6=97=A5 15:12, Wei Wang w=
rote:
>>>>>>>>>>>>>>>>>> Hi:

17 levels of '>' when I add my reply.  Wow.

>> I think that's another direction or future extension.
>> We already have the vhost-pci to virtio-net model on the way, so I
>> think it would be better to start from here.
>>
>=20
> If vhost-pci to vhost-pci is obvious superior, why not try this conside=
r
> we're at rather early stage for vhost-pci?
>=20

I have to scroll a couple of screens past heavily-quoted material before
getting to the start of the additions to the thread.  It's not only
okay, but recommended, to trim your replies down to relevant context so
that it is easier to get to your additions (3 or 4 levels of quoted
material can still be relevant, but 17 levels is usually a sign that you
are including too much).  Readers coming in mid-thread can still refer
to the public archives if they want more context.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--PfEX0343HC8Gu2B5WCAPlX2uaSL6BcD3x
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJZJuu7AAoJEKeha0olJ0NqPt8H/AkQcWPs4h5Mht7qvgTcx6bq
DHuovt4cWRkBv+ALcb9/Ws1YMncFjbqu906BdtfHFUJ8exLzmWXFU/Wo5h7UjCkh
9hcEZTSawF4rbMpZxd1I8odhMk7rUuG0bbi+RpW2QKPKX7XzC94IzqAIjaYU+J/F
s8oGOeuexps48GDDi+oADABLzMz5M6+OIFKK9yoQM5nqllhJARm4s552L5wnNV5t
kXrF62AM2dmbN7mVLasyuF62LVbb4Lhgzvn9VfKnSLMixvkHRznlilyAmq0vfS2a
u3fMKY9l8tbqTLefuGGeBtSZgX+PTXNjt0TTBzAzyPZiLlLqNgio5ZlbP5K5JGU=
=vYmS
-----END PGP SIGNATURE-----

--PfEX0343HC8Gu2B5WCAPlX2uaSL6BcD3x--
