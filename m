Received: from eggs.gnu.org ([2001:4830:134:3::10]:45166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5K2X-0002ta-C9
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 19:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e5K2U-0001g0-61
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 19:15:49 -0400
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:53505)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e5K2U-0001ff-0X
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 19:15:46 -0400
Received: by mail-pf0-x244.google.com with SMTP id t188so8206548pfd.10
	for <qemu-devel@nongnu.org>; Thu, 19 Oct 2017 16:15:45 -0700 (PDT)
References: <20171017225025.25451-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <fb6141dd-d31e-5a8e-6d0d-a00c1ff9aa34@linaro.org>
Date: Thu, 19 Oct 2017 16:15:42 -0700
MIME-Version: 1.0
In-Reply-To: <20171017225025.25451-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/alpha/typhoon: simplify using the
 "unimplemented" sysbus device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 10/17/2017 03:50 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/alpha/alpha_sys.h |  1 -
>  hw/alpha/pci.c       | 26 --------------------------
>  hw/alpha/typhoon.c   |  6 ++----
>  3 files changed, 2 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
