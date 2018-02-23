Received: from eggs.gnu.org ([2001:4830:134:3::10]:33496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epA5c-0006XA-GQ
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 04:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1epA5b-0006i3-Ro
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 04:56:28 -0500
Received: from mail-pf0-x243.google.com ([2607:f8b0:400e:c00::243]:39424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1epA5b-0006h0-MD
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 04:56:27 -0500
Received: by mail-pf0-x243.google.com with SMTP id c143so3319505pfb.6
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 01:56:27 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <739b0a8d-eea3-c934-8f38-6fe609056c07@linaro.org>
References: <20180217182323.25885-1-richard.henderson@linaro.org>
	<20180217182323.25885-8-richard.henderson@linaro.org>
	<CAFEAcA-PzKt-gZe2FjvqZuJqFmgoziNKaDLyen9o+hToMboQWw@mail.gmail.com>
	<739b0a8d-eea3-c934-8f38-6fe609056c07@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Feb 2018 09:56:06 +0000
Message-ID: <CAFEAcA9zRC1tRPhywOKBC3GAgFgV7aFr6OE_xCJQePo_a4Fgzw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 07/67] target/arm: Implement
 SVE Predicate Logical Operations Group
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 22 February 2018 at 19:37, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 02/22/2018 10:55 AM, Peter Maydell wrote:
>>> +# Three prediate operand, with governing predicate, flag setting
>>
>> Three what?
>
> Feh, typo for predicate.

Oh, right -- I'd thought it might be some mashup/typo of something-immediate.

-- PMM
