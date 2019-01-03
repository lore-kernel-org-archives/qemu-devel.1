Received: from eggs.gnu.org ([208.118.235.92]:40163)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gfB8f-00006Z-24
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 17:06:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gfB8b-0002PK-Qk
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 17:06:53 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44276)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gfB8b-0002Oz-Cu
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 17:06:49 -0500
Received: by mail-oi1-x243.google.com with SMTP id m6so28899730oig.11
	for <qemu-devel@nongnu.org>; Thu, 03 Jan 2019 14:06:49 -0800 (PST)
References: <20181218164348.7127-1-richard.henderson@linaro.org>
	<CAFEAcA_RGHe6rD-hHA-H5-4pN8Oau7v8pmPa+9bcW8KqkWLFYA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <92e24a08-d9c4-c9f9-3973-4e4a240c819f@linaro.org>
Date: Fri, 4 Jan 2019 08:06:39 +1000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_RGHe6rD-hHA-H5-4pN8Oau7v8pmPa+9bcW8KqkWLFYA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Convert ARM_TBFLAG_* to
 FIELDs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 1/3/19 11:21 PM, Peter Maydell wrote:
> Otherwise the patch looks good, so if you agree I'll apply
> it to target-arm.next with the flag renamed back to BE_DATA.

No good reason, I just thought it was shorter.
Renaming it back is fine.


r~
