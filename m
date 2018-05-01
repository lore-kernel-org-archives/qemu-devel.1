Received: from eggs.gnu.org ([2001:4830:134:3::10]:37633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDa7V-0008Kg-Vg
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fDa7S-0007gV-NG
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:35:21 -0400
Received: from mail-pf0-x229.google.com ([2607:f8b0:400e:c00::229]:40236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fDa7S-0007fK-AR
	for qemu-devel@nongnu.org; Tue, 01 May 2018 14:35:18 -0400
Received: by mail-pf0-x229.google.com with SMTP id f189so9678779pfa.7
	for <qemu-devel@nongnu.org>; Tue, 01 May 2018 11:35:17 -0700 (PDT)
References: <20180425012300.14698-1-richard.henderson@linaro.org>
	<87d0yf9y4j.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <60b1a0ff-3126-1607-c38a-866beaead798@linaro.org>
Date: Tue, 1 May 2018 11:35:12 -0700
MIME-Version: 1.0
In-Reply-To: <87d0yf9y4j.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/9] target/arm: Fixups for
 ARM_FEATURE_V8_FP16
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org

On 05/01/2018 08:47 AM, Alex Bennée wrote:
> I've also pushed the fix to sqrt_f16 (passing cpu_env rather than fpst).

Oops.

> Are you happy rolling my fixes into your v2?

Yes, I can do that.


r~
