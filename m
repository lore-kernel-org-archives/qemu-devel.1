Received: from eggs.gnu.org ([2001:4830:134:3::10]:43309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1e4fts-00028V-K2
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:24:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1e4ftr-0002RZ-RS
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 00:24:12 -0400
Sender: Richard Henderson <rth7680@gmail.com>
References: <20171018000053.27348-1-f4bug@amsat.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <eec60d48-c410-6201-2d67-81e29d6c6c33@twiddle.net>
Date: Tue, 17 Oct 2017 21:24:02 -0700
MIME-Version: 1.0
In-Reply-To: <20171018000053.27348-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2] hw/alpha/typhoon: simplify using the
 "unimplemented" sysbus device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On 10/17/2017 05:00 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v2: add spaces for checkpatch...
> 
> ERROR: spaces required around that '*' (ctx:VxV)
> #82: FILE: hw/alpha/typhoon.c:880:
> +    create_unimplemented_device("pci0-io", 0x801fc000000ULL, 32*MB);
>                                                                 ^
> total: 1 errors, 0 warnings, 57 lines checked

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
