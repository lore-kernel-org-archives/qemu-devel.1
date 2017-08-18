Received: from eggs.gnu.org ([2001:4830:134:3::10]:55701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <revol@free.fr>) id 1dioG1-0006Cm-Mg
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 16:52:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <revol@free.fr>) id 1dioFw-0003kX-RI
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 16:52:41 -0400
References: <cover.1502643878.git.balaton@eik.bme.hu>
	<0362ffdbfb08b46edef0e2180387078299a9b721.1502643878.git.balaton@eik.bme.hu>
	<AM5P194MB0132F81D398EB4EB8EB13E22C8800@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
	<alpine.BSF.2.21.1708181418010.19483@zero.eik.bme.hu>
	<AM5P194MB01328DE5DCCC5E8CDD9C3C44C8800@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
From: =?UTF-8?Q?Fran=c3=a7ois_Revol?= <revol@free.fr>
Message-ID: <5ae57bdb-283b-5019-6702-211fba051ff0@free.fr>
Date: Fri, 18 Aug 2017 22:52:22 +0200
MIME-Version: 1.0
In-Reply-To: <AM5P194MB01328DE5DCCC5E8CDD9C3C44C8800@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH 09/12] ppc440: Add emulation
 of plb-pcix controller found in some 440 SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luigi burdo <intermediadc@hotmail.com>, BALATON Zoltan <balaton@eik.bme.hu>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

Le 18/08/2017 =C3=A0 21:43, luigi burdo a =C3=A9crit :
> can i ask you something ? why you dont try to integrate in qemu the
> pegasos 2 or the efika machine. i have the feeling that probably it
> can be more simple because more old machine and components.
>=20

Except they are antique, and the Pegasos at least has an horribly buggy
OpenFirmware implementation.

I'd rather work on BeBox support ;-)

Fran=C3=A7ois.
