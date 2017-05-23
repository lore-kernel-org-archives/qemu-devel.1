Received: from eggs.gnu.org ([2001:4830:134:3::10]:46025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dCzUA-0002FY-PZ
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dCzU4-0006S3-P9
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:23:46 -0400
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:36283)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dCzU4-0006QD-JI
	for qemu-devel@nongnu.org; Mon, 22 May 2017 22:23:40 -0400
Received: by mail-pf0-x241.google.com with SMTP id n23so23917260pfb.3
	for <qemu-devel@nongnu.org>; Mon, 22 May 2017 19:23:40 -0700 (PDT)
References: <20170503105224.19049-1-xiaoguangrong@tencent.com>
	<e186ce8d-52fc-3eca-1343-1a2f18331a76@redhat.com>
	<ff732c49-de24-eebd-ae8e-2de00281f211@gmail.com>
	<878cbc47-316c-d508-a5a3-22029dee2203@redhat.com>
	<9af959d5-23c2-abd4-6100-577755239d2f@gmail.com>
	<71ca0408-4ec3-938c-2899-a4aa02ed3ab5@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <66307755-c542-32fe-f88d-82cd4402353b@gmail.com>
Date: Tue, 23 May 2017 10:23:42 +0800
MIME-Version: 1.0
In-Reply-To: <71ca0408-4ec3-938c-2899-a4aa02ed3ab5@redhat.com>
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


Ping...

Sorry to disturb, just make this patchset not be missed. :)

On 05/04/2017 03:06 PM, Paolo Bonzini wrote:
> 
> 
> On 04/05/2017 05:36, Xiao Guangrong wrote:
>> Great.
>>
>> As there is no conflict between these two patchsets except dirty
>> ring pages takes benefit from write-protect-all, i think they
>> can be developed and iterated independently, right?
> 
> I can certainly start reviewing this one.
> 
> Paolo
> 
>> Or you prefer to merge dirty ring pages first then review the
>> new version of this patchset later?
