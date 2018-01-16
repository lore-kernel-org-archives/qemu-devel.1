Received: from eggs.gnu.org ([2001:4830:134:3::10]:39456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSrX-0004QN-Ve
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebSrX-0000eJ-8K
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:09:19 -0500
Received: from mail-ot0-x232.google.com ([2607:f8b0:4003:c0f::232]:36316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebSrX-0000dv-3o
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 10:09:19 -0500
Received: by mail-ot0-x232.google.com with SMTP id f100so1292816otf.3
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 07:09:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180116013709.13830-1-andrew.smirnov@gmail.com>
References: <20180116013709.13830-1-andrew.smirnov@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 15:08:58 +0000
Message-ID: <CAFEAcA8uJpwwVSAMWY+rFm1+3YFdtuShAyz6PB4yNto_YOVCbg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 00/14] Initial i.MX7 support
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

On 16 January 2018 at 01:36, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
> Hi everyone,
>
> This v4 of the patch series containing the work that I've done in
> order to enable support for i.MX7 emulation in QEMU.
>
> *NOTE*: Patches 1 and 2 are provided for the sake of completness and
>         are going to have to be adapted once Philippe's SD changes
>         land in master. As such, they are NOT ready to be
>         accepted/merged.

I've just pushed a pullreq including Philippe's SD changes to master,
so you should be able to do the final versions of these i.MX SD patches
now. I've also I think now reviewed everything except the pci patch,
which is a bit out of my competence area.

thanks
-- PMM
