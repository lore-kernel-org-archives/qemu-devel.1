Received: from eggs.gnu.org ([2001:4830:134:3::10]:42408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejpOR-0000G8-Ct
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:49:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1ejpOQ-0004Sf-K6
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 11:49:51 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8Hjsb+KW4A0ks696+zXOeDErndeQDFvOqshyONpyaSSg@mail.gmail.com>
References: <20180207042438.15422-1-andrew.smirnov@gmail.com>
	<20180207042438.15422-13-andrew.smirnov@gmail.com>
	<CAFEAcA8Hjsb+KW4A0ks696+zXOeDErndeQDFvOqshyONpyaSSg@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Thu, 8 Feb 2018 08:49:46 -0800
Message-ID: <CAHQ1cqGQaWiqY1Hg514frugOE4-kUAxXFgFvX4-Gs5tDRgcsMQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 12/14] i.MX: Add i.MX7 SOC
 implementation.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Marcel Apfelbaum <marcel.apfelbaum@zoho.com>, "Michael S . Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Thu, Feb 8, 2018 at 5:26 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 7 February 2018 at 04:24, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>> The following interfaces are partially or fully emulated:
>
> Hi Andrey. I was just going through this series to apply to
> target-arm.next, and I noticed that fsl-imx7.c is GPL-2-or-later,
> but fsl-imx7.h is GPL-2-only. Is that intentional?
>
> If this is just an accidental error, and you send an email to
> say you meant 2-or-later, then I can fix this in my target-arm
> tree by copying the license paragraphs from fsl-imx7.c to fsl-imx7.h.
>

This is just a mistake on my part. Feel free to change to whatever
makes most sense.

Thanks,
Andrey Smrinov
