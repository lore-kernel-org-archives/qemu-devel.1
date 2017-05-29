Received: from eggs.gnu.org ([2001:4830:134:3::10]:39335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFNqN-000229-To
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:48:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dFNqJ-0005V4-2j
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:48:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dFNqI-0005Ua-SD
	for qemu-devel@nongnu.org; Mon, 29 May 2017 12:48:31 -0400
References: <20170503105224.19049-1-xiaoguangrong@tencent.com>
	<e186ce8d-52fc-3eca-1343-1a2f18331a76@redhat.com>
	<ff732c49-de24-eebd-ae8e-2de00281f211@gmail.com>
	<878cbc47-316c-d508-a5a3-22029dee2203@redhat.com>
	<9af959d5-23c2-abd4-6100-577755239d2f@gmail.com>
	<71ca0408-4ec3-938c-2899-a4aa02ed3ab5@redhat.com>
	<66307755-c542-32fe-f88d-82cd4402353b@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <06b050f5-f8f1-4313-3fd9-771413a6bc00@redhat.com>
Date: Mon, 29 May 2017 18:48:25 +0200
MIME-Version: 1.0
In-Reply-To: <66307755-c542-32fe-f88d-82cd4402353b@gmail.com>
Content-Type: text/plain; charset=utf-8
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
To: Xiao Guangrong <guangrong.xiao@gmail.com>, mtosatti@redhat.com, avi.kivity@gmail.com, rkrcmar@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, Xiao Guangrong <xiaoguangrong@tencent.com>



On 23/05/2017 04:23, Xiao Guangrong wrote:
> 
> Ping...
> 
> Sorry to disturb, just make this patchset not be missed. :)

It won't. :)  I'm going to look at it and the dirty page ring buffer
this week.

Paolo
