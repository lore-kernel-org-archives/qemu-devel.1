Received: from eggs.gnu.org ([209.51.188.92]:49045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjTrE-0005Cf-8y
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:54:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gjTrC-0005GG-7j
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:54:40 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37371)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gjTr7-0005D1-4y
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 13:54:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id g67so4353655wmd.2
	for <qemu-devel@nongnu.org>; Tue, 15 Jan 2019 10:54:32 -0800 (PST)
References: <alpine.BSF.2.21.9999.1811292101280.5887@zero.eik.bme.hu>
	<alpine.BSF.2.21.9999.1901151926320.72972@zero.eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e72fd744-3440-a684-38c4-75d6d604cddb@redhat.com>
Date: Tue, 15 Jan 2019 19:54:29 +0100
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.9999.1901151926320.72972@zero.eik.bme.hu>
Content-Type: text/plain; charset=iso-8859-15
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] Booting Raspbian on RPi emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org

On 1/15/19 7:29 PM, BALATON Zoltan wrote:
> On Thu, 29 Nov 2018, BALATON Zoltan wrote:
>> Then I've tried the same with the pll patches posted by Philippe
>> Mathieu-Daudé here:
>>
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg00191.html
>>
>> on top of v3.1.0-rc3 which helped to get rid of the cprman warnings
> 
> Will these patches be merged eventually? These seem to at least get rid
> of some annoying warnings in Linux boot dmesg.

I'll respin this series addressing Peter's comments.

Thanks for reminding me ;)

Phil.
