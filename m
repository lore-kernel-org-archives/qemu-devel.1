Received: from eggs.gnu.org ([2001:4830:134:3::10]:34403)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1fqeig-0005pz-P7
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:23:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <psusi@ubuntu.com>) id 1fqeic-0004WL-O7
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:23:14 -0400
Received: from ec2-34-202-238-73.compute-1.amazonaws.com
	([34.202.238.73]:47212 helo=vps.thesusis.net)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <psusi@ubuntu.com>) id 1fqeic-0004Vu-Ii
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 09:23:10 -0400
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
	<20180816172722.GK23515@redhat.com>
	<83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
	<20180817085656.GA11124@redhat.com>
	<a115c4d1-0a78-efa1-0364-f41a06aca124@ubuntu.com>
	<20180817125808.GO11124@redhat.com>
	<b4872310-41f3-d2bc-22b2-0f41e8848a55@ubuntu.com>
	<20180817131226.GP11124@redhat.com>
From: Phillip Susi <psusi@ubuntu.com>
Message-ID: <438249b4-e35e-4946-6234-7d3e8a24d48b@ubuntu.com>
Date: Fri, 17 Aug 2018 09:23:05 -0400
MIME-Version: 1.0
In-Reply-To: <20180817131226.GP11124@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Tq5dPTI2JkCmJEZn4uoOr1R0Wds23edmP"
Subject: Re: [Qemu-devel] Pipe key broken on US keyboards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Tq5dPTI2JkCmJEZn4uoOr1R0Wds23edmP
From: Phillip Susi <psusi@ubuntu.com>
To: =?UTF-8?Q?Daniel_P._Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <438249b4-e35e-4946-6234-7d3e8a24d48b@ubuntu.com>
Subject: Re: Pipe key broken on US keyboards
References: <bf97cfed-ca7f-8670-0aad-da1b847eb609@ubuntu.com>
 <20180816172722.GK23515@redhat.com>
 <83320617-5d60-fe71-3ef5-8ac7c384a3b1@ubuntu.com>
 <20180817085656.GA11124@redhat.com>
 <a115c4d1-0a78-efa1-0364-f41a06aca124@ubuntu.com>
 <20180817125808.GO11124@redhat.com>
 <b4872310-41f3-d2bc-22b2-0f41e8848a55@ubuntu.com>
 <20180817131226.GP11124@redhat.com>
In-Reply-To: <20180817131226.GP11124@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 8/17/2018 9:12 AM, Daniel P. Berrang=C3=A9 wrote:
> It depends on what the VNC client asks for too. With no '-k' arg, if th=
e
> VNC client asks for raw scancodes it'll get that, otherwise QEMU will
> fallback to en-US.    GTK-VNC based clients (remote-viewer, virt-viewer=
,
> vinagre, virt-manager, GNOME boxes) use the raw scancodes. Most other
> clients do not.

I'm using "tightvnc" from my Windows computer at work and it says it is
using keyboard layout 00000409 ( whatever that means ), so it sounds
like it is sending a keycode and qemu is translating it into the wrong
scancode.



--Tq5dPTI2JkCmJEZn4uoOr1R0Wds23edmP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJbdsw9AAoJENsuw7lhAP6EsXAH/2svAPbJAw+eyiVkaZtLXEcx
/2/ybLaW7hb5/Z5QTc3rt710yzhTWSYdzexfJ6MVDxUBkoYf34BoT5zvOUYtHtzu
M32+IS1gTDOJnnJ/5nd53OoaPKaVPQCny5V6nIUtqiCfBgcswwVXp8Ioo1ZNj7MR
H1/zjnB4wK8LflYZftur5Gq14ZgC/rDYsuRL7GkEk9D/ppWaKvtSFnz7MqMHGocI
b+axrj5UwH9XN+mEOaZpsa5ygRi0AC9RfaL2e90BUxAY5Z1doPZxDdXvWZn3uBDa
5IA5E2yToDDEnlZzJHVMcc444Xm4t12xccyFAYBdRqsjlYKcwloczo2t8AuArGw=
=TkAB
-----END PGP SIGNATURE-----

--Tq5dPTI2JkCmJEZn4uoOr1R0Wds23edmP--
