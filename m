Received: from eggs.gnu.org ([2001:4830:134:3::10]:39621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQaGo-0007bB-A7
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1dQaGi-0005m9-Fs
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:18:10 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:57572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1dQaGi-0005kV-4k
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 10:18:04 -0400
From: Laurent Vivier <laurent@vivier.eu>
References: <20170620205121.26515-1-laurent@vivier.eu>
	<20170620205121.26515-7-laurent@vivier.eu>
	<e94af6f2-8869-b9e7-b2b8-b3f16713b345@vivier.eu>
	<20170629134601.GA9921@kos.to>
	<65f1d63d-45b2-2b9c-b00e-0c3ac808e425@vivier.eu>
Message-ID: <32916024-a8e9-987a-59ad-df09f7d8ef71@vivier.eu>
Date: Thu, 29 Jun 2017 16:17:32 +0200
MIME-Version: 1.0
In-Reply-To: <65f1d63d-45b2-2b9c-b00e-0c3ac808e425@vivier.eu>
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
Cc: Thomas Huth <huth@tuxfamily.org>, Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Le 29/06/2017 à 16:11, Laurent Vivier a écrit :
> Le 29/06/2017 à 15:46, Riku Voipio a écrit :
>> On Wed, Jun 28, 2017 at 10:44:57PM +0200, Laurent Vivier wrote:
>>> Riku,
>>>
>>> could you ACK this patch, so I will add it in my next pull request for m68k?
>>
>> Whatabout Richard's comment about using cpu_m68k_set_fpcr ?
> 
> You're right. I've fixed it my tree and forgotten to send it.
> 
> I'm going to resend it.


In fact the patch has been re-sent out of the series:

https://lists.gnu.org/archive/html/qemu-devel/2017-06/msg04911.html

Thanks,
Laurent
