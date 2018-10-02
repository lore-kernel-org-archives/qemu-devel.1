Received: from eggs.gnu.org ([2001:4830:134:3::10]:40103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7MfN-0004wi-Ng
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:32:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1g7MfH-0003La-Oa
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:32:53 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1g7MfB-0003I5-VS
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 11:32:43 -0400
Received: by mail-ot1-x343.google.com with SMTP id j9-v6so2321451otl.2
	for <qemu-devel@nongnu.org>; Tue, 02 Oct 2018 08:32:41 -0700 (PDT)
References: <20180927211322.16118-1-richard.henderson@linaro.org>
	<CAFEAcA8zsd21+5va-ApormhvSrnZ18Ygs4w=eH9rkRr7nf5inQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8310da35-ed9e-e3ff-d00d-00cd56d4fcd4@linaro.org>
Date: Tue, 2 Oct 2018 10:32:35 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8zsd21+5va-ApormhvSrnZ18Ygs4w=eH9rkRr7nf5inQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/9] target/arm: Rely on id regs instead
 of features
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

On 10/2/18 7:30 AM, Peter Maydell wrote:
> On 27 September 2018 at 22:13, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>> There are more feature bits that could be converted, but I thought
>> I should show the work to this point to get feedback.
>>
>> This is the "v2" as compared to
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-09/msg01849.html
> 
> So having written the code both ways round, which do you think
> works out nicer? (or at least least-worst :-))

My preference is for v2.


r~
