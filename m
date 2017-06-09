Received: from eggs.gnu.org ([2001:4830:134:3::10]:58637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dJASo-0004nR-36
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dJASk-0006sf-TT
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:19:54 -0400
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:36811)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dJASk-0006sI-MF
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 23:19:50 -0400
Received: by mail-pg0-x242.google.com with SMTP id v18so6392990pgb.3
	for <qemu-devel@nongnu.org>; Thu, 08 Jun 2017 20:19:49 -0700 (PDT)
References: <20170503105224.19049-1-xiaoguangrong@tencent.com>
	<e186ce8d-52fc-3eca-1343-1a2f18331a76@redhat.com>
	<ff732c49-de24-eebd-ae8e-2de00281f211@gmail.com>
	<878cbc47-316c-d508-a5a3-22029dee2203@redhat.com>
	<9af959d5-23c2-abd4-6100-577755239d2f@gmail.com>
	<71ca0408-4ec3-938c-2899-a4aa02ed3ab5@redhat.com>
	<66307755-c542-32fe-f88d-82cd4402353b@gmail.com>
	<06b050f5-f8f1-4313-3fd9-771413a6bc00@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <972ff276-0ece-3f7e-e38c-b3775a1217eb@gmail.com>
Date: Fri, 9 Jun 2017 11:19:56 +0800
MIME-Version: 1.0
In-Reply-To: <06b050f5-f8f1-4313-3fd9-771413a6bc00@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/7] KVM: MMU: fast write protect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, mtosatti@redhat.com, avi.kivity@gmail.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>



On 05/30/2017 12:48 AM, Paolo Bonzini wrote:
> 
> 
> On 23/05/2017 04:23, Xiao Guangrong wrote:
>>
>> Ping...
>>
>> Sorry to disturb, just make this patchset not be missed. :)
> 
> It won't. :)  I'm going to look at it and the dirty page ring buffer
> this week.

Ping.. :)
