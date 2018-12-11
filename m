Received: from eggs.gnu.org ([2001:4830:134:3::10]:43783)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWmRD-0001WW-2P
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:07:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gWmR7-0000Sk-PT
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:07:18 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33327)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gWmR7-0000S2-7b
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 13:07:13 -0500
Received: by mail-oi1-x244.google.com with SMTP id c206so12799327oib.0
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 10:07:12 -0800 (PST)
References: <20181207103631.28193-1-richard.henderson@linaro.org>
	<20181207103631.28193-2-richard.henderson@linaro.org>
	<CAFEAcA9yJu-1OmSPW9G=3C80zdZc49xF+ws6pTxA=otR0-TPNQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <f1abf75a-d248-348b-6737-22b910724f2a@linaro.org>
Date: Tue, 11 Dec 2018 12:07:09 -0600
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9yJu-1OmSPW9G=3C80zdZc49xF+ws6pTxA=otR0-TPNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/26] target/arm: Add state for the
 ARMv8.3-PAuth extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Ramana Radhakrishnan <ramana.radhakrishnan@arm.com>

On 12/11/18 8:50 AM, Peter Maydell wrote:
> What's the rationale for migrating these "by hand" rather
> than relying on the usual sysreg migration code ?

Um... perhaps fluff where brain should be.
Definitely no good reason.


r~
