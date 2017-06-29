Received: from eggs.gnu.org ([2001:4830:134:3::10]:36743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQaBI-0002eW-WA
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:12:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQaBF-0001Hj-QW
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:12:28 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:57851)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dQaBF-0001G2-GB
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:12:25 -0400
References: <20170620205121.26515-1-laurent@vivier.eu>
	<20170620205121.26515-7-laurent@vivier.eu>
	<e94af6f2-8869-b9e7-b2b8-b3f16713b345@vivier.eu>
	<20170629134601.GA9921@kos.to>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <65f1d63d-45b2-2b9c-b00e-0c3ac808e425@vivier.eu>
Date: Thu, 29 Jun 2017 16:11:56 +0200
MIME-Version: 1.0
In-Reply-To: <20170629134601.GA9921@kos.to>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 6/6] target-m68k,
 linux-user: manage FP registers in ucontext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Riku Voipio <riku.voipio@iki.fi>
Cc: qemu-devel@nongnu.org, Thomas Huth <huth@tuxfamily.org>, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <rth@twiddle.net>

Le 29/06/2017 à 15:46, Riku Voipio a écrit :
> On Wed, Jun 28, 2017 at 10:44:57PM +0200, Laurent Vivier wrote:
>> Riku,
>>
>> could you ACK this patch, so I will add it in my next pull request for m68k?
> 
> Whatabout Richard's comment about using cpu_m68k_set_fpcr ?

You're right. I've fixed it my tree and forgotten to send it.

I'm going to resend it.

Thanks,
Laurent
