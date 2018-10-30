Received: from eggs.gnu.org ([2001:4830:134:3::10]:59730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHPCg-0004ts-Bi
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:16:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gHPCd-0001be-0V
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:16:46 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gHPCa-0001Xu-Im
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 04:16:41 -0400
Received: by mail-wm1-x343.google.com with SMTP id 143-v6so10687847wmf.1
	for <qemu-devel@nongnu.org>; Tue, 30 Oct 2018 01:16:35 -0700 (PDT)
References: <20181029232100.8454-1-philmd@redhat.com>
	<20181029232100.8454-2-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6adbca95-631e-685f-11ab-b9a464c0add3@linaro.org>
Date: Tue, 30 Oct 2018 08:16:31 +0000
MIME-Version: 1.0
In-Reply-To: <20181029232100.8454-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/arm/xilinx_zynq: Use the ARRAY_SIZE
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <linux@roeck-us.net>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org

On 10/29/18 11:20 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/arm/xilinx_zynq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
