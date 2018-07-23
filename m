Received: from eggs.gnu.org ([2001:4830:134:3::10]:57627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fheHE-000813-VM
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:05:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fheHE-0007Yk-7x
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:05:40 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46640)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fheHD-0007Ya-WF
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 13:05:40 -0400
Received: by mail-pf1-x443.google.com with SMTP id u24-v6so209909pfn.13
	for <qemu-devel@nongnu.org>; Mon, 23 Jul 2018 10:05:39 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-41-git-send-email-stefan.markovic@rt-rk.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fee331fe-f708-78cf-db91-1331f221c49d@linaro.org>
Date: Mon, 23 Jul 2018 10:05:35 -0700
MIME-Version: 1.0
In-Reply-To: <1532004912-13899-41-git-send-email-stefan.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 40/40] target/mips: Add definition of
 nanoMIPS I7200 CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Markovic <stefan.markovic@rt-rk.com>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

On 07/19/2018 05:55 AM, Stefan Markovic wrote:
> +        .insn_flags = CPU_NANOMIPS32 | ASE_MICROMIPS | ASE_DSP | ASE_DSPR2 |
> +                      ASE_MT,

See my comments for 27/40.


r~
