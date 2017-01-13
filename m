Received: from eggs.gnu.org ([2001:4830:134:3::10]:60233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cS10C-00039d-I3
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:30:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cS108-0004UX-BT
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:30:40 -0500
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:38003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cS107-0004UI-VC
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 07:30:36 -0500
Received: by mail-wm0-x22b.google.com with SMTP id r144so68685227wme.1
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 04:30:35 -0800 (PST)
References: <20170112154731.1028-1-alex.bennee@linaro.org>
	<20170112154731.1028-4-alex.bennee@linaro.org>
	<87inpk2rkl.fsf@linaro.org>
	<aaaa75a1-7c42-6263-fee6-790cde5e8730@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <aaaa75a1-7c42-6263-fee6-790cde5e8730@twiddle.net>
Date: Fri, 13 Jan 2017 12:30:32 +0000
Message-ID: <87d1fr2lcn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 3/3] cputlb: drop flush_global flag from
 tlb_flush
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "open list:PowerPC" <qemu-ppc@nongnu.org>


Richard Henderson <rth@twiddle.net> writes:

> On 01/12/2017 08:03 AM, Alex Bennée wrote:
>> And I immediately realise I missed out:
>>
>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>> Reviewed-by: Richard Henderson <rth@twiddle.net>
>> [DG: ppc portions]
>> Acked-by: David Gibson <david@gibson.dropbear.id.au>
>>
>> Do you want me to re-post or can you apply when you take the patches?
>>
>
> I also don't mind if you send the pull request.

If Peter is OK with that?

In that case I now have a few more tags to add and I can roll a PULL REQ.

--
Alex Bennée
