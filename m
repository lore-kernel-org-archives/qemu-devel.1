Received: from eggs.gnu.org ([2001:4830:134:3::10]:52088)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqo4Q-0006hz-E3
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:50:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eqo4L-00047X-Qb
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:50:02 -0500
Received: from mail-pf0-x244.google.com ([2607:f8b0:400e:c00::244]:33648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eqo4L-00047A-Iz
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 17:49:57 -0500
Received: by mail-pf0-x244.google.com with SMTP id q13so199044pff.0
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 14:49:57 -0800 (PST)
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-19-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <847f6200-5d9d-98fe-bf20-54295dcdab26@linaro.org>
Date: Tue, 27 Feb 2018 14:49:52 -0800
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 18/19] hw/arm/iotkit: Model Arm IOT Kit
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

On 02/20/2018 10:03 AM, Peter Maydell wrote:
> Model the Arm IoT Kit documented in
> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.ecm0601256/index.html
> 
> The Arm IoT Kit is a subsystem which includes a CPU and some devices,
> and is intended be extended by adding extra devices to form a
> complete system.  It is used in the MPS2 board's AN505 image for the
> Cortex-M33.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~
