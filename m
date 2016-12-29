Received: from eggs.gnu.org ([2001:4830:134:3::10]:55443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <realrichardsharpe@gmail.com>) id 1cMfny-0004T5-UE
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 13:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <realrichardsharpe@gmail.com>) id 1cMfny-0004FD-13
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 13:51:59 -0500
Received: from mail-yw0-x22b.google.com ([2607:f8b0:4002:c05::22b]:35518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <realrichardsharpe@gmail.com>)
	id 1cMfnx-0004Ek-T2
	for qemu-devel@nongnu.org; Thu, 29 Dec 2016 13:51:57 -0500
Received: by mail-yw0-x22b.google.com with SMTP id v81so110297102ywb.2
	for <qemu-devel@nongnu.org>; Thu, 29 Dec 2016 10:51:56 -0800 (PST)
MIME-Version: 1.0
From: Richard Sharpe <realrichardsharpe@gmail.com>
Date: Thu, 29 Dec 2016 10:51:55 -0800
Message-ID: <CACyXjPxZePbjS-zm1CeCLpzEuYkXSmVZ6w8vJpw8zO2iRyoZoA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Did anything ever come of the Wireshark dissector
 generator that was being worked on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi folks,

I saw on this page
http://wiki.qemu.org/Features/LibvirtWiresharkDissector that someone
was planning on writing a dissector generator for XDR.

I wish I had known about it when I started the following effort, which
is now at a Version 1 level:

https://gitlab.com/realrichardsharpe/wireshark_rpcgen

As far as I am aware it handles all of XDR and is able to handle
protocols that are specified across multiple XDR files (as that is
what I needed.)

However, I would be interested in following up with the athor of the
libvirt version.

--=20
Regards,
Richard Sharpe
(=E4=BD=95=E4=BB=A5=E8=A7=A3=E6=86=82=EF=BC=9F=E5=94=AF=E6=9C=89=E6=9D=9C=
=E5=BA=B7=E3=80=82--=E6=9B=B9=E6=93=8D)
