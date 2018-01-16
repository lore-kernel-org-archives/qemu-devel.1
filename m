Received: from eggs.gnu.org ([2001:4830:134:3::10]:33617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSbx-0006q8-BK
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:53:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSbw-0006g2-BS
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:53:13 -0500
Received: from mail-ot0-x233.google.com ([2607:f8b0:4003:c0f::233]:34154)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebSbw-0006fh-5d
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:53:12 -0500
Received: by mail-ot0-x233.google.com with SMTP id p16so13826471otf.1
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:53:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180116013709.13830-15-andrew.smirnov@gmail.com>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
	<20180116013709.13830-15-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 14:52:51 +0000
Message-ID: <CAFEAcA8O7G-Psw55tOUUv3h6WWJNWxSmmBcz_HHQ7Ui2DqBs0Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 14/14] Implement support for i.MX7 Sabre
 board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On 16 January 2018 at 01:37, Andrey Smirnov <andrew.smirnov@gmail.com> wrot=
e:
> Implement code needed to set up emulation of MCIMX7SABRE board from
> NXP. For more info about the HW see:
>
> https://www.nxp.com/support/developer-resources/hardware-development-tool=
s/sabre-development-system/sabre-board-for-smart-devices-based-on-the-i.mx-=
7dual-applications-processors:MCIMX7SABRE
>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Cc: qemu-devel@nongnu.org
> Cc: qemu-arm@nongnu.org
> Cc: yurovsky@gmail.com
> Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM
