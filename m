Received: from eggs.gnu.org ([2001:4830:134:3::10]:40932)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eCruS-00038e-TE
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:50:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1eCruP-0008KI-PC
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:50:40 -0500
Received: from hera.aquilenet.fr ([141.255.128.1]:59297)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1eCruP-0008Jc-J2
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 13:50:37 -0500
Date: Thu, 9 Nov 2017 19:50:33 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20171109185033.p7ka62xswqol5v5b@var.youpi.perso.aquilenet.fr>
References: <20170508195404.j33kcmqncrb7fziv@var.youpi.perso.aquilenet.fr>
	<20171108225340.10194-1-lepton@google.com>
	<CAJ+F1CK53wNxwixP8M4JgbG4kKgpgu_EdJ6-RyNnevNGQsXmJw@mail.gmail.com>
	<CAOvqHj6Sw6_a90WRsLd3YgVu-rRL5k9cgRy1vbgEfCucf_7dXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOvqHj6Sw6_a90WRsLd3YgVu-rRL5k9cgRy1vbgEfCucf_7dXQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: don't zero ti_i since we access it
 later.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao =?utf-8?B?V3Uo5ZC05rabQEVuZyk=?= <lepton@google.com>
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>, QEMU <qemu-devel@nongnu.org>, maethor@subiron.org

Tao Wu(=E5=90=B4=E6=B6=9B@Eng), on jeu. 09 nov. 2017 10:48:27 -0800, wrot=
e:
> Thanks. Actually this is a follow up with my previous effort to fix thi=
s bug.
> I was busy on something else and then got lost in that old thread. Now =
I just
> checked some my local patch
> to see if they've merged to upstream and then found it out.
>=20
> This is old thread about this:
> [1]http://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg05544.htm=
l

I knew I had seen that proposal somewhere before :)

Thanks for the patch,
Samuel
