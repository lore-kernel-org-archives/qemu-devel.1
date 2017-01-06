Received: from eggs.gnu.org ([2001:4830:134:3::10]:53816)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPbLf-0003Co-9c
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 15:42:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPbLc-0007rS-6K
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 15:42:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47868)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPbLb-0007qx-Tk
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 15:42:48 -0500
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
	<148192392306.37.10111381964118487672@790289a7ca88>
	<CAFEAcA97bb-LBoPVvm_wqS6GVyYoFhwR6qBRJDPVRLG8sOGqsA@mail.gmail.com>
	<20170106215615-mutt-send-email-mst@kernel.org>
	<3240188c-69b7-bbc9-6121-a75d093f5289@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1ecc350d-289f-c6f8-6ca3-327d65cfe9d0@redhat.com>
Date: Fri, 6 Jan 2017 14:42:45 -0600
MIME-Version: 1.0
In-Reply-To: <3240188c-69b7-bbc9-6121-a75d093f5289@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="EPpKJ1deGpA22v3cwMsNJINbLVEv4rN4r"
Subject: Re: [Qemu-devel] [PULL for-2.9 0/9] virtio, vhost, pc: fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: mlureau@redhat.com, Fam Zheng <famz@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--EPpKJ1deGpA22v3cwMsNJINbLVEv4rN4r
From: Eric Blake <eblake@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: mlureau@redhat.com, Fam Zheng <famz@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <1ecc350d-289f-c6f8-6ca3-327d65cfe9d0@redhat.com>
Subject: Re: [Qemu-devel] [PULL for-2.9 0/9] virtio, vhost, pc: fixes
References: <1481922841-4324-1-git-send-email-mst@redhat.com>
 <148192392306.37.10111381964118487672@790289a7ca88>
 <CAFEAcA97bb-LBoPVvm_wqS6GVyYoFhwR6qBRJDPVRLG8sOGqsA@mail.gmail.com>
 <20170106215615-mutt-send-email-mst@kernel.org>
 <3240188c-69b7-bbc9-6121-a75d093f5289@redhat.com>
In-Reply-To: <3240188c-69b7-bbc9-6121-a75d093f5289@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/06/2017 02:38 PM, Eric Blake wrote:
>=20
> But how to force git to send mail in UTF-8 is not something I've had to=

> figure out (I'm relying on my distro's defaults) - you'll have to poke
> around your .git/config (or ~/.gitconfig) and see if you have some
> really old settings from an earlier time, or ask around on freenode's
> #git channel for better ideas.

The git config settings for i18n.commitEncoding and
i18n.logOutputEncoding may be relevant, as may
sendemail.transferEncoding and sendemail.assume8bitEncoding.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--EPpKJ1deGpA22v3cwMsNJINbLVEv4rN4r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYcAFFAAoJEKeha0olJ0NqOwkH/AqQKIjnQI+b77yFsauQGFED
AAfLoSdw0QNUr66QjjTf/Fbkgo3+uVwLpfEea7avuAS6AytCFNAtPT19k44y9Ky3
x24ySfedxzlCq7KneOrxrdJJevL0UtOL50lrZmZ7+NlXxJn+t90XH8QRNQp5OOG7
yl5+3eSsFgU4wE1Jn8jo/fbPYphIOR7osNJESLYT9JHlKlfphIT62tDASVJSNdKV
jGKD/Aw3N+QUApaUOqnSpswMV5xWSD0MR4guNZHC7ZLWvq5qverBVSRmek/4Wa0i
eZGWxQY9i0Y8eylwY00YssWgscRu8nHQphBGBHbCD5Y+r7jpRRQF1K2CE+nKZYs=
=Gvc8
-----END PGP SIGNATURE-----

--EPpKJ1deGpA22v3cwMsNJINbLVEv4rN4r--
