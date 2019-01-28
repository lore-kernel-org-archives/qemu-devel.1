Received: from eggs.gnu.org ([209.51.188.92]:39853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9bV-0002TR-Lg
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:17:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9bU-0001U2-7Z
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:17:45 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:38681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9bT-0001OA-Ou
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:17:44 -0500
Received: by mail-pl1-x643.google.com with SMTP id e5so7947482plb.5
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 08:17:33 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-17-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b1286c90-6cb6-7ec2-4c9a-336f4817548b@linaro.org>
Date: Mon, 28 Jan 2019 08:17:29 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-17-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 16/23] hw/arm/armsse: Add
 unimplemented-device stubs for PPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 1/21/19 10:51 AM, Peter Maydell wrote:
> Add unimplemented-device stubs for the various Power Policy Unit
> devices that the SSE-200 has.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armsse.h | 11 ++++++++
>  hw/arm/armsse.c         | 58 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 69 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
