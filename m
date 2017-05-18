Received: from eggs.gnu.org ([2001:4830:134:3::10]:50137)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBLqc-0007xE-5m
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:52:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dBLqX-0006Ah-85
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:52:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dBLqX-0006Ab-1a
	for qemu-devel@nongnu.org; Thu, 18 May 2017 09:52:05 -0400
References: <20170510083259.3900-1-xiaoguangrong@tencent.com>
	<9626326d-977f-bf26-851a-59d420f27993@redhat.com>
	<0900def5-6049-4338-1eb0-8a0404c6c839@gmail.com>
	<1120538601.8977419.1495093937424.JavaMail.zimbra@redhat.com>
	<a5bb9edc-700f-76ec-2e6e-8422f6beadeb@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <00e79477-835e-1e24-97f8-c62cfd31e306@redhat.com>
Date: Thu, 18 May 2017 15:51:59 +0200
MIME-Version: 1.0
In-Reply-To: <a5bb9edc-700f-76ec-2e6e-8422f6beadeb@gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Xiao Guangrong <guangrong.xiao@gmail.com>
Cc: mst@redhat.com, mtosatti@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, yunfangtai@tencent.com, qemu-devel@nongnu.org, kvm@vger.kernel.org



On 18/05/2017 15:38, Xiao Guangrong wrote:
>>>
>>
>> Yes, I've already queued it, but I don't have many patches so I am
>> delaying the pull request a bit (until at least I have time to test
>> vhost-user-scsi...).
>>
> 
> Very glad to know it. I should check your git tree before raise this
> kind of request next time. :)

Well, I don't have a public staging git tree. :)

Paolo
