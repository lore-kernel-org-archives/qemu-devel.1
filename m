Received: from eggs.gnu.org ([2001:4830:134:3::10]:50644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5ykZ-0006ed-El
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 14:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5ykV-0003TJ-Ia
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 14:43:59 -0400
Received: from mail-pf0-x234.google.com ([2607:f8b0:400e:c00::234]:49591)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5ykV-0003Rm-A5
	for qemu-devel@nongnu.org; Sat, 21 Oct 2017 14:43:55 -0400
Received: by mail-pf0-x234.google.com with SMTP id i5so14310657pfe.6
	for <qemu-devel@nongnu.org>; Sat, 21 Oct 2017 11:43:53 -0700 (PDT)
References: <150854545099.470.5659261777172716355@b58463cdfd5f>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f6947e93-4e98-49c7-0d3b-edf302f0bf49@linaro.org>
Date: Sat, 21 Oct 2017 11:43:48 -0700
MIME-Version: 1.0
In-Reply-To: <150854545099.470.5659261777172716355@b58463cdfd5f>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v7 00/52] tcg queued patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: patchew-devel@freelists.org
Cc: qemu-devel <qemu-devel@nongnu.org>

On 10/20/2017 05:24 PM, no-reply@patchew.org wrote:
> This series failed build test on s390x host. Please find the details below.
...
> /var/tmp/patchew-tester-tmp-yebrjc4i/src/accel/tcg/cputlb.c:1105:0: fatal error: error writing to /tmp/ccuQ6F0N.s: No space left on device

Please fix this or disable the test to quench the noise.


r~
