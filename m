Received: from eggs.gnu.org ([209.51.188.92]:33125)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gjTT3-0003LZ-7w
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gjTT2-0007Cy-Al
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:29:41 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:28089)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gjTT2-00076U-2s
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:29:40 -0500
Date: Tue, 15 Jan 2019 19:29:26 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <alpine.BSF.2.21.9999.1811292101280.5887@zero.eik.bme.hu>
Message-ID: <alpine.BSF.2.21.9999.1901151926320.72972@zero.eik.bme.hu>
References: <alpine.BSF.2.21.9999.1811292101280.5887@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Booting Raspbian on RPi emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>

On Thu, 29 Nov 2018, BALATON Zoltan wrote:
> Then I've tried the same with the pll patches posted by Philippe=20
> Mathieu-Daud=E9 here:
>
> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg00191.html
>
> on top of v3.1.0-rc3 which helped to get rid of the cprman warnings

Will these patches be merged eventually? These seem to at least get rid o=
f=20
some annoying warnings in Linux boot dmesg.

Regards,
BALATON Zoltan
