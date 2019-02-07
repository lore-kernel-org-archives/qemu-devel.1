Received: from eggs.gnu.org ([209.51.188.92]:60943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griQF-0007sf-9i
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:04:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1griQ9-0008Md-Ms
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:04:49 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37655)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1griPv-0008C0-3Z
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 07:04:37 -0500
Received: by mail-wm1-x341.google.com with SMTP id g67so6392839wmd.2
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 04:04:29 -0800 (PST)
References: <CAFyWVaZ5tQq4eGaZiPBq7172PB_x3JCqV6c2xo=wSJdgbJakKQ@mail.gmail.com>
	<20190130025708.12811-1-jimw@sifive.com>
	<CAKmqyKMrCVqudmyJUPta9q6TJtDkeLV=FseAqQ7YhYMu3ak_NQ@mail.gmail.com>
	<CAFyWVaaS_4RY9YKXcgJ1F4Ep1TDWkExtBTEigJedZQCcXG+44Q@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9b4e0b04-e941-a433-0175-33ba9f79945b@linaro.org>
Date: Thu, 7 Feb 2019 12:04:20 +0000
MIME-Version: 1.0
In-Reply-To: <CAFyWVaaS_4RY9YKXcgJ1F4Ep1TDWkExtBTEigJedZQCcXG+44Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 5/5 v3] RISC-V: Add hooks to use the gdb
 xml files.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jim Wilson <jimw@sifive.com>, Alistair Francis <alistair23@gmail.com>
Cc: qemu-riscv@nongnu.org, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On 2/7/19 2:05 AM, Jim Wilson wrote:
> Maybe qemu doesn't care about unused arguments/parameters?

We do not.


r~
