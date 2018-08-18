Received: from eggs.gnu.org ([2001:4830:134:3::10]:41040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqyAf-0007o6-Gd
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 06:09:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fqyAe-0004BM-Qw
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 06:09:25 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:45871)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fqyAe-0004AT-L7
	for qemu-devel@nongnu.org; Sat, 18 Aug 2018 06:09:24 -0400
Received: by mail-oi0-x244.google.com with SMTP id q11-v6so18136290oic.12
	for <qemu-devel@nongnu.org>; Sat, 18 Aug 2018 03:09:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CADS1RdSn1rVnXbWxB6+DmMOEgEsCLA-ZX3tZBA9FXWoAFsegPg@mail.gmail.com>
References: <1534507843-4251-1-git-send-email-hans-erik.floryd@rt-labs.com>
	<CAFEAcA_Ki4Sqke3qExAihjx+x9XpX2e6DJG0ua-VEvdes_gKBw@mail.gmail.com>
	<CADS1RdSn1rVnXbWxB6+DmMOEgEsCLA-ZX3tZBA9FXWoAFsegPg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 18 Aug 2018 11:09:03 +0100
Message-ID: <CAFEAcA-XQ7U2yqLHMr9-ZbdaiLEspRmo37QT2UQVTTKwW_v5tg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3] sdhci: add i.MX SD Stable Clock bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hans-Erik Floryd <hans-erik.floryd@rt-labs.com>
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

On 17 August 2018 at 18:56, Hans-Erik Floryd
<hans-erik.floryd@rt-labs.com> wrote:
>
>
> Den fre 17 aug 2018 19:51Peter Maydell <peter.maydell@linaro.org> skrev
>>
>> (Your indentation was off-by-one -- we use 4-space indent -- but I fixed
>> that.)
>>
>> -- PMM
>
>
> Thanks! I think i fixed that in a new patch so please ignore v3.

You don't need to resend, I've already taken this version with a fixup.

-- PMM
