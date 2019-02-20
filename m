Received: from eggs.gnu.org ([209.51.188.92]:42121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwTjV-0007xn-IJ
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:24:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwTjG-0007PP-1m
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:24:15 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:46813)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwTjF-0007Ff-9m
	for qemu-devel@nongnu.org; Wed, 20 Feb 2019 10:24:09 -0500
Received: by mail-pl1-f193.google.com with SMTP id o6so12371683pls.13
	for <qemu-devel@nongnu.org>; Wed, 20 Feb 2019 07:23:54 -0800 (PST)
References: <20190220050451.10939-1-richard.henderson@linaro.org>
	<CABoDooNvVGXeh9rKDzzagkz0pUgx0A4rgWvr_kpLKAHL4dfTRQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7fd5995b-0e82-d52b-d7c4-4910d36520ca@linaro.org>
Date: Wed, 20 Feb 2019 07:18:49 -0800
MIME-Version: 1.0
In-Reply-To: <CABoDooNvVGXeh9rKDzzagkz0pUgx0A4rgWvr_kpLKAHL4dfTRQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/3] target/arm: Implement ARMv8.5-CondM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Desnogues <laurent.desnogues@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>

On 2/20/19 2:07 AM, Laurent Desnogues wrote:
> I tested xaflag/axflag (after setting the ID_AA64ISAR0 TS field to 2).

Whoops, at least that line is missing.  ;-)


r~
