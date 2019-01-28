Received: from eggs.gnu.org ([209.51.188.92]:43805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9lC-0002VX-7k
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1go9lB-0001jr-Fj
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:27:46 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:40428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1go9lB-0001YB-9w
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:27:45 -0500
Received: by mail-pl1-x642.google.com with SMTP id u18so7953421plq.7
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 08:27:35 -0800 (PST)
References: <20190121185118.18550-1-peter.maydell@linaro.org>
	<20190121185118.18550-21-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ac1c5f45-17eb-32cb-a94f-8bc4988b23bd@linaro.org>
Date: Mon, 28 Jan 2019 08:27:31 -0800
MIME-Version: 1.0
In-Reply-To: <20190121185118.18550-21-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 20/23] hw/arm/armsse: Add CPU_IDENTITY
 block to SSE-200
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
> Instantiate a copy of the CPU_IDENTITY register block for each CPU
> in an SSE-200.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/armsse.h |  3 +++
>  hw/arm/armsse.c         | 28 ++++++++++++++++++++++++++++
>  2 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
