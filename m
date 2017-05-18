Received: from eggs.gnu.org ([2001:4830:134:3::10]:46721)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dBLdi-0005pY-2E
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:38:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dBLdd-0001aT-3r
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:38:50 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:36699)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dBLdc-0001aJ-TL
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:38:45 -0400
Received: by mail-pg0-x244.google.com with SMTP id h64so6040916pge.3
	for <qemu-devel@nongnu.org>; Thu, 18 May 2017 06:38:44 -0700 (PDT)
References: <20170510083259.3900-1-xiaoguangrong@tencent.com>
	<9626326d-977f-bf26-851a-59d420f27993@redhat.com>
	<0900def5-6049-4338-1eb0-8a0404c6c839@gmail.com>
	<1120538601.8977419.1495093937424.JavaMail.zimbra@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <a5bb9edc-700f-76ec-2e6e-8422f6beadeb@gmail.com>
Date: Thu, 18 May 2017 21:38:48 +0800
MIME-Version: 1.0
In-Reply-To: <1120538601.8977419.1495093937424.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/5] mc146818rtc: fix Windows VM clock
 faster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, yunfangtai@tencent.com, qemu-devel@nongnu.org, kvm@vger.kernel.org



On 05/18/2017 03:52 PM, Paolo Bonzini wrote:
> 
>>> Looks great.  Thanks for following up quickly on the reviews.
>>
>> Paolo, if it is okay to you, could you please consider to merge this
>> patchset? ;)
> 
> Yes, I've already queued it, but I don't have many patches so I am
> delaying the pull request a bit (until at least I have time to test
> vhost-user-scsi...).
> 

Very glad to know it. I should check your git tree before raise this
kind of request next time. :)

> In the meanwhile, it would be great if you prepared a qtest for the
> problem of too many interrupts when the periodic timer is reprogrammed
> continuously.
> 

Sure, will do it, thanks for your suggestion.
