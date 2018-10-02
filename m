Received: from eggs.gnu.org ([2001:4830:134:3::10]:51073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7KWP-0003xO-ME
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:15:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1g7KWM-0003Yi-L4
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:15:29 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:39504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1g7KWM-0003YO-GM
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 09:15:26 -0400
Received: by mail-oi1-x244.google.com with SMTP id y81-v6so1440944oia.6
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 06:15:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181001220942.2382-8-f4bug@amsat.org>
References: <20181001220942.2382-1-f4bug@amsat.org>
	<20181001220942.2382-8-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Oct 2018 14:15:04 +0100
Message-ID: <CAFEAcA97wzFUqhU075cPF8-jmwV7LvV3iqBpX671XnMfg3x2aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 07/15] hw/mips/gt64xxx_pci: Convert
 gt64120_reset() function into Device reset method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>

On 1 October 2018 at 23:09, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> w=
rote:
> Convert the gt64120_reset() function into a proper Device reset method.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/mips/gt64xxx_pci.c | 17 +++--------------
>  1 file changed, 3 insertions(+), 14 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
