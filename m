Received: from eggs.gnu.org ([2001:4830:134:3::10]:41348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1ctd-0004kh-W8
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1e1ctd-00065Y-10
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:35:22 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:56046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1e1ctc-00063y-OS
	for qemu-devel@nongnu.org; Mon, 09 Oct 2017 14:35:20 -0400
Received: by mail-wm0-x229.google.com with SMTP id u138so26041254wmu.4
	for <qemu-devel@nongnu.org>; Mon, 09 Oct 2017 11:35:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1507506331.5452.145.camel@aj.id.au>
References: <20170920064915.30027-1-clg@kaod.org>
	<1507506331.5452.145.camel@aj.id.au>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Oct 2017 19:34:59 +0100
Message-ID: <CAFEAcA_r0HJ8FHCzO7o8BeitM5GqqBMm7pA-M=ntTGGG3q8FYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] watchdog/aspeed: fix variable type to
 store reload value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jeffery <andrew@aj.id.au>
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, "Anton D . Kachalov" <mouse@yandex-team.ru>

On 9 October 2017 at 00:45, Andrew Jeffery <andrew@aj.id.au> wrote:
> On Wed, 2017-09-20 at 08:49 +0200, C=C3=A9dric Le Goater wrote:
>> Initially from Anton D. Kachalov" <mouse@yandex-team.ru> but the SoB was
>> missing.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> [clg: change commit log and subject
>>       replace UL suffix by ULL ]
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>
> Acked-by: Andrew Jeffery <andrew@aj.id.au>



Applied to target-arm.next, thanks.

-- PMM
