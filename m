Received: from eggs.gnu.org ([2001:4830:134:3::10]:57655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRiuw-00013p-8U
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:12:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cRiur-0005rv-Jr
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:12:02 -0500
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170112154731.1028-1-alex.bennee@linaro.org>
	<20170112154731.1028-4-alex.bennee@linaro.org>
	<87inpk2rkl.fsf@linaro.org>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <aaaa75a1-7c42-6263-fee6-790cde5e8730@twiddle.net>
Date: Thu, 12 Jan 2017 09:11:37 -0800
MIME-Version: 1.0
In-Reply-To: <87inpk2rkl.fsf@linaro.org>
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, "open list:PowerPC" <qemu-ppc@nongnu.org>

On 01/12/2017 08:03 AM, Alex Bennée wrote:
> And I immediately realise I missed out:
> 
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>> Reviewed-by: Richard Henderson <rth@twiddle.net>
> [DG: ppc portions]
> Acked-by: David Gibson <david@gibson.dropbear.id.au>
> 
> Do you want me to re-post or can you apply when you take the patches?
> 

I also don't mind if you send the pull request.


r~
