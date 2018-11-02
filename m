Received: from eggs.gnu.org ([2001:4830:134:3::10]:51565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIaa2-0000mW-OB
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:37:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIaZz-0003Zo-FK
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:37:46 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41503)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gIaZv-0003Mx-IF
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 10:37:41 -0400
Received: by mail-wr1-x443.google.com with SMTP id x12-v6so2205878wrw.8
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 07:37:22 -0700 (PDT)
References: <20181024113709.16599-1-richard.henderson@linaro.org>
	<20181024113709.16599-4-richard.henderson@linaro.org>
	<CAFEAcA8gf_qTB554MAzJf1nKv7UK_7_+vdbm=C+9erwyk9XOTQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a84204e5-ef96-e44e-4056-00170c6c044d@linaro.org>
Date: Fri, 2 Nov 2018 14:37:18 +0000
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8gf_qTB554MAzJf1nKv7UK_7_+vdbm=C+9erwyk9XOTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/5] target/arm: Introduce read_sys_reg32
 for kvm32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11/2/18 2:30 PM, Peter Maydell wrote:
> (Confusingly, ENCODE_CP_REG and ARM_CP15_REG32 take the
> op1/crn/crm/op2 arguments in different orders.)

As Shaggy said, "It wasn't me".  ;-)


r~
