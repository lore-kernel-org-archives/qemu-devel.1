Received: from eggs.gnu.org ([2001:4830:134:3::10]:44230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4Bog-0004IE-By
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e4Boc-0008Sj-0t
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:16:50 -0400
Received: from mail-pg0-x22e.google.com ([2607:f8b0:400e:c05::22e]:43446)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e4Bob-0008SC-Qf
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:16:45 -0400
Received: by mail-pg0-x22e.google.com with SMTP id s75so6856448pgs.0
	for <qemu-devel@nongnu.org>; Mon, 16 Oct 2017 13:16:45 -0700 (PDT)
References: <20171013162438.32458-1-alex.bennee@linaro.org>
	<20171013162438.32458-14-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cffab041-0028-801d-c29b-2c18fe9853fb@linaro.org>
Date: Mon, 16 Oct 2017 13:16:42 -0700
MIME-Version: 1.0
In-Reply-To: <20171013162438.32458-14-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 13/30] target/arm/translate-a64.c:
 AdvSIMD scalar 3 Same FP16 initial decode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org

On 10/13/2017 09:24 AM, Alex Bennée wrote:
> This is the initial decode skeleton for the Advanced SIMD scalar
> three same instruction group. The fprintf is purely to aid debugging
> as the additional instructions are added. It will be removed once the
> group is complete.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/translate-a64.c | 76 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 76 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
