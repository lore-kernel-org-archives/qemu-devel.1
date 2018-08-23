Received: from eggs.gnu.org ([2001:4830:134:3::10]:57341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsqJF-0004Im-Px
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:10:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fsqJA-0007u0-BM
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:10:01 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:42602)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fsqJA-0007tn-32
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 10:09:56 -0400
Received: by mail-pl0-x241.google.com with SMTP id g23-v6so2462337plq.9
	for <qemu-devel@nongnu.org>; Thu, 23 Aug 2018 07:09:56 -0700 (PDT)
References: <20180820141116.9118-1-peter.maydell@linaro.org>
	<20180820141116.9118-5-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <13e5b093-88b4-3c7d-9353-eb29f54db259@linaro.org>
Date: Thu, 23 Aug 2018 07:09:52 -0700
MIME-Version: 1.0
In-Reply-To: <20180820141116.9118-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 04/22] hw/arm/iotkit: Wire up the dualtimer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, patches@linaro.org

On 08/20/2018 07:10 AM, Peter Maydell wrote:
> Now we have a model of the CMSDK dual timer, we can wire it
> up in the IoTKit.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  include/hw/arm/iotkit.h | 3 ++-
>  hw/arm/iotkit.c         | 8 +++++---
>  2 files changed, 7 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
