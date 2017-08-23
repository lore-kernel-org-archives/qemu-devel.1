Received: from eggs.gnu.org ([2001:4830:134:3::10]:50488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1dkVmu-000054-Dq
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:33:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <intermediadc@hotmail.com>) id 1dkVmo-0005JL-RA
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 09:33:40 -0400
From: luigi burdo <intermediadc@hotmail.com>
Date: Wed, 23 Aug 2017 13:33:14 +0000
Message-ID: <AM5P194MB0132C6FDB93803CDD7DB634DC8850@AM5P194MB0132.EURP194.PROD.OUTLOOK.COM>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<ab632ef70b02efb2257d9e2f08b45b097ebacb3a.1503249785.git.balaton@eik.bme.hu>
	<20170823041644.GP5379@umbus.fritz.box>
	<alpine.BSF.2.21.1708231217070.76247@zero.eik.bme.hu>
	<8fe81d01-0a39-02cc-c7d8-59437c4f94ac@free.fr>,
	<alpine.BSF.2.21.1708231422390.35800@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.1708231422390.35800@zero.eik.bme.hu>
Content-Language: it-IT
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 15/15] ppc: Add aCube Sam460ex
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, =?iso-8859-1?Q?Fran=E7ois_Revol?= <revol@free.fr>
Cc: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>

Hi Zoltan,

>So I chose to

>use the sii3112 by default.
right chooice because internal sata on sam460 had issue and wont boot os4,m=
orphos... only the cdrom was booting if i remember  good from internal sata=
 0.
personally when i had a Sam460ex i was using a sii3114 or internal micro sd=
 for boot... the sii was perfect compatible with sam uboot.

Thanks
Luigi
