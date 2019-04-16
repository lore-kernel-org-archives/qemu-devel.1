Received: from eggs.gnu.org ([209.51.188.92]:44120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hGKAA-0004R7-OU
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:13:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <frederic.konrad@adacore.com>) id 1hGKA9-0004VW-5i
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:13:58 -0400
Received: from mel.act-europe.fr ([194.98.77.210]:46437
	helo=smtp.eu.adacore.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <frederic.konrad@adacore.com>)
	id 1hGKA8-0004Tt-PF
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 05:13:57 -0400
References: <87d0mwatbu.fsf@dusky.pond.sub.org>
From: KONRAD Frederic <frederic.konrad@adacore.com>
Message-ID: <6ac64f2d-58d5-695b-8111-8b68cb3916c1@adacore.com>
Date: Tue, 16 Apr 2019 11:13:46 +0200
MIME-Version: 1.0
In-Reply-To: <87d0mwatbu.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Maintainers,
 please tell us how to boot your machines!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: Paul Burton <pburton@wavecomp.com>, Cornelia Huck <cohuck@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, "Michael S. Tsirkin" <mst@redhat.com>, Anthony Green <green@moxielogic.com>, Palmer Dabbelt <palmer@sifive.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Peter Chubb <peter.chubb@nicta.com.au>, Marek Vasut <marex@denx.de>, Rob Herring <robh@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>, Jia Liu <proljc@gmail.com>, Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>, David Hildenbrand <david@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Antony Pavlov <antonynpavlov@gmail.com>, Anthony Perard <anthony.perard@citrix.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, Joel Stanley <joel@jms.id.au>, Eduardo Habkost <ehabkost@redhat.com>, Alistair Francis <alistair@alistair23.me>, Fabien Chouteau <chouteau@adacore.com>, Beniamino Galvani <b.galvani@gmail.com>, Paul Durrant <paul.durrant@citrix.com>, Jan Kiszka <jan.kiszka@web.de>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, Stafford Horne <shorne@gmail.com>, Subbaraya Sundeep <sundeep.lkml@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Andrew Jeffery <andrew@aj.id.au>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Chris Wulff <crwulff@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, Jean-Christophe Dubois <jcd@tribudubois.net>, Andrey Smirnov <andrew.smirnov@gmail.com>, Michael Walle <michael@walle.cc>, Thomas Huth <huth@tuxfamily.org>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>


Le 3/12/19 =C3=A0 6:36 PM, Markus Armbruster a =C3=A9crit=C2=A0:
> Dear board code maintainers,

Hi Markus,

>=20
> This is a (rather late) follow-up to the last QEMU summit.  Minutes[*]:
>=20

[...]

>=20
>      =3D hw/sparc/leon3.c =3D
>      Fabien Chouteau <chouteau@adacore.com> (maintainer:Leon3)
>      Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> (maintainer:SPARC=
)
>      Artyom Tarasenko <atar4qemu@gmail.com> (maintainer:SPARC)

We are still using with this board. I'll try to create a working linux im=
age for
it and get back to you.

Cheers,
Fred
