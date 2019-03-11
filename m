Received: from eggs.gnu.org ([209.51.188.92]:36325)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h3Aeh-0003LG-34
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 22:27:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1h3Aeg-00071R-4W
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 22:27:07 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:33288)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1h3Aef-0006yp-Ph
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 22:27:06 -0400
Date: Mon, 11 Mar 2019 03:26:57 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <d5191334-6fdf-c160-203f-a6bee5f0384a@redhat.com>
Message-ID: <alpine.BSF.2.21.9999.1903110323200.87103@zero.eik.bme.hu>
References: <cover.1552152100.git.balaton@eik.bme.hu>
	<da6370b22e0352ee803d25d68a62ff32eebf06e2.1552152100.git.balaton@eik.bme.hu>
	<d5191334-6fdf-c160-203f-a6bee5f0384a@redhat.com>
MIME-Version: 1.0
Content-ID: <alpine.BSF.2.21.9999.1903110324520.87103@zero.eik.bme.hu>
Content-Type: text/plain; CHARSET=ISO-8859-15; FORMAT=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 2/2] mips_fulong2e: Add on-board
 graphics chip
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Aleksandar Markovic <amarkovic@wavecomp.com>

On Mon, 11 Mar 2019, Philippe Mathieu-Daud=E9 wrote:
> On 3/9/19 6:21 PM, BALATON Zoltan wrote:
>> Add (partial) emulation of the on-board GPU of the machine. This
>> allows the PMON2000 firmware to run and should also work with Linux
>> console but probably not with X yet.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>
> Mojibaked again :(
>
> I guess this is the last respin and this series will be applied,
> so to the maintainer: Can you fix using:

Don't worry, Gerd said before it came out OK as he also uses UTF8 so=20
maybe it only shows up wrong in your email client.

> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>
> Zoltan if you have to respin, please simply use:

I've tried adding some headers to specify encoding which I'll use next bu=
t=20
I did not bother for this resend as it worked before.

Regards,
BALATON Zoltan
