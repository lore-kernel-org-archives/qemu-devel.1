Received: from eggs.gnu.org ([2001:4830:134:3::10]:41904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dnsiD-00045Y-VN
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:38:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dnsiA-0000PV-UM
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:38:46 -0400
Received: from mail-pg0-x229.google.com ([2607:f8b0:400e:c05::229]:33347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dnsiA-0000Oj-Oc
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 16:38:42 -0400
Received: by mail-pg0-x229.google.com with SMTP id t3so3540574pgt.0
	for <qemu-devel@nongnu.org>; Fri, 01 Sep 2017 13:38:42 -0700 (PDT)
References: <20170817230114.3655-1-richard.henderson@linaro.org>
	<20170817230114.3655-2-richard.henderson@linaro.org>
	<c53d1c21-c913-a60d-cdfa-524431c2cf28@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d85197cf-d3c7-a42c-5a8b-98b5f486f191@linaro.org>
Date: Fri, 1 Sep 2017 13:38:38 -0700
MIME-Version: 1.0
In-Reply-To: <c53d1c21-c913-a60d-cdfa-524431c2cf28@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/8] tcg: Add generic vector infrastructure
 and ops for add/sub/logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org

On 08/29/2017 06:31 PM, Philippe Mathieu-Daudé wrote:
> Hi Richard,
> 
> I can't find anything to say about this patch... Hardcore stuff.
> Some part could be more a bit more verbose but after a while focusing it makes
> sens.
> I wonder how long it took you to write this :) "roughly 2h"

Not quite that quickly.  ;-)
You're absolutely right that it needs lots more documentation.
I'll improve that when it comes to round 2.


r~
