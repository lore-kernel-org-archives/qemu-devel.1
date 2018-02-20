Received: from eggs.gnu.org ([2001:4830:134:3::10]:37835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eo5rx-0003HH-6z
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:13:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eo5rs-0004A8-HN
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:13:57 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38622 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eo5rs-0004A1-9x
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 06:13:52 -0500
References: <CAJSP0QUMA7v=-qX-CNCi30aoH-HzXC9i75EpLWP_TmFuDzpTQQ@mail.gmail.com>
	<CAKmqyKPk69_d-iYGekoS9WBM1fnzav1iFAQEXQq_jLOW9_Dt3w@mail.gmail.com>
	<CAJSP0QVd70uAiG3vyOjO-qOdt1YbEccYydJvz4igg7_bBiW+5A@mail.gmail.com>
	<CAKmqyKP2cQGXSmPvaGt3AwDz6zewJ6HH=vVTSnk6GVAQAhW5uA@mail.gmail.com>
	<20180115125933.GA11737@stefanha-x1.localdomain>
	<CAKmqyKMoqyyr2oBWyEarZhxxBS+F_=zCJARdVvpFkyPv+L3xJQ@mail.gmail.com>
	<20180220103643.GC19724@stefanha-x1.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <030fbb91-837b-9817-dc87-28dade530cf3@redhat.com>
Date: Tue, 20 Feb 2018 12:13:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180220103643.GC19724@stefanha-x1.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="rO0KyqOm3f9aAQ6IWdoZ2t2H6VkKgp73k"
Subject: Re: [Qemu-devel] Call for GSoC & Outreachy 2018 mentors & project
 ideas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, Jailhouse <jailhouse-dev@googlegroups.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philippe@mathieu-daude.net>, Alistair Francis <alistair23@gmail.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rO0KyqOm3f9aAQ6IWdoZ2t2H6VkKgp73k
From: Paolo Bonzini <pbonzini@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>,
 Jailhouse <jailhouse-dev@googlegroups.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philippe@mathieu-daude.net>,
 Alistair Francis <alistair23@gmail.com>
Message-ID: <030fbb91-837b-9817-dc87-28dade530cf3@redhat.com>
Subject: Re: [Qemu-devel] Call for GSoC & Outreachy 2018 mentors & project
 ideas
References: <CAJSP0QUMA7v=-qX-CNCi30aoH-HzXC9i75EpLWP_TmFuDzpTQQ@mail.gmail.com>
 <CAKmqyKPk69_d-iYGekoS9WBM1fnzav1iFAQEXQq_jLOW9_Dt3w@mail.gmail.com>
 <CAJSP0QVd70uAiG3vyOjO-qOdt1YbEccYydJvz4igg7_bBiW+5A@mail.gmail.com>
 <CAKmqyKP2cQGXSmPvaGt3AwDz6zewJ6HH=vVTSnk6GVAQAhW5uA@mail.gmail.com>
 <20180115125933.GA11737@stefanha-x1.localdomain>
 <CAKmqyKMoqyyr2oBWyEarZhxxBS+F_=zCJARdVvpFkyPv+L3xJQ@mail.gmail.com>
 <20180220103643.GC19724@stefanha-x1.localdomain>
In-Reply-To: <20180220103643.GC19724@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 20/02/2018 11:36, Stefan Hajnoczi wrote:
> =3D=3D=3D Multi-CPU cluster support for GDB server in QEMU =3D=3D=3D
>=20
> There are many examples in modern computing where multiple CPU
> clusters are grouped together in a single SoC. This is common in the
> ARM world especially. There are numerous examples such as ARM's
> big.LITTLE implementations and Xilinx's 4xA53s and 2xR5s on the ZynqMP
> SoC. The goal of this task is to add support to the GDB server to
> allow users to debug across these clusters.
>=20
> This is another step towards single binary QEMU as well.
>=20
>  Detailed description of the project.
>=20
> Xilinx has an out of tree implementation that can be used as a
> starting point. Work will need to be done on top of this to prepare it
> for upstream submission and to ensure the implementation is more
> generic.
>=20
> This will mostly involve extending GDB server to tell GDB about
> different architectures and then allow the user to swap between them.
>=20
> The Xilinx implementation can be seen here:
> https://github.com/Xilinx/qemu/blob/master/gdbstub.c
> There has been some steps in preparing the work to go upstream, which
> can be seen here:
> https://github.com/Xilinx/qemu/tree/mainline/alistair/gdb

I agree this is interesting.  Another related idea is to resume the
multi-arch work that Peter Crosthwaite was working on before he left Xili=
nx.

Paolo


--rO0KyqOm3f9aAQ6IWdoZ2t2H6VkKgp73k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEE8TM4V0tmI4mGbHaCv/vSX3jHroMFAlqMAugACgkQv/vSX3jH
roNifQf+NL6/Eo3XHG3OHHhuyIA96k2GpxU0To9mAAmczPGhxycJnbDgEm+KpOUN
QwkT42YRO14ZNvpSvBQFzX0yE2s9wDsi9SzhPA8zgsn9YLPts11XqoMaLTkZyouX
6AI/V/NrTwjAIM7dXsJ96l2935xdOQkzXG1ai2zhzhnyhXX9TCV/Bn3iLCbRfAYf
k2hTBKTJRRya8hoI3ZBrcsn5GFN0yXHqG6FZmHQSei0o1VAe7Ul8RELr2fBBxH+V
yRYFFrJ5AsykcW5nqmEaZTrhgqeeW5bcddxNlZQPCYagY6wGAStK3ei0kaZK7tN1
NPqqNDhuK99TNaIE0LEZDweOIZ0+HA==
=Mr/5
-----END PGP SIGNATURE-----

--rO0KyqOm3f9aAQ6IWdoZ2t2H6VkKgp73k--
