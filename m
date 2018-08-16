Received: from eggs.gnu.org ([2001:4830:134:3::10]:46494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqKfZ-0006SR-PM
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:58:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fqKfU-00019T-Ni
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:58:41 -0400
Received: from mail-pl0-x22e.google.com ([2607:f8b0:400e:c01::22e]:45126)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fqKfQ-00016Y-RO
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:58:34 -0400
Received: by mail-pl0-x22e.google.com with SMTP id j8-v6so2287207pll.12
	for <qemu-devel@nongnu.org>; Thu, 16 Aug 2018 08:58:28 -0700 (PDT)
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
	<1534431497-1385-16-git-send-email-aleksandar.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <08f5df8c-418d-648f-d133-883c2729e178@linaro.org>
Date: Thu, 16 Aug 2018 08:58:24 -0700
MIME-Version: 1.0
In-Reply-To: <1534431497-1385-16-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v9 15/84] qemu-doc: Amend MIPS-related items
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 08/16/2018 07:57 AM, Aleksandar Markovic wrote:
> +@command{qemu-mips64} executes 64-bit big endian MIPS binaries (MIPS O64 ABI).
> +
> +@command{qemu-mips64el} executes 64-bit little endian MIPS binaries (MIPS O64 ABI).

These use N64.  We don't have an O64 configuration.


r~
