Received: from eggs.gnu.org ([209.51.188.92]:47428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGOTv-0004tW-IT
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hGOTu-00041W-6w
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:50:39 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hGOTt-0003zz-Jk
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:50:37 -0400
Received: by mail-wm1-f66.google.com with SMTP id r186so2399549wmf.1
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 06:50:37 -0700 (PDT)
References: <20190415135746.7571-1-mlevitsk@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c239eeac-8bf1-6af4-8a2a-370be84bfcdb@redhat.com>
Date: Tue, 16 Apr 2019 15:50:35 +0200
MIME-Version: 1.0
In-Reply-To: <20190415135746.7571-1-mlevitsk@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/5] Few fixes for userspace
 NVME driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org

On 15/04/19 15:57, Maxim Levitsky wrote:
> 
> 
> Hi!
> These are few assorted fixes and features for the userspace
> nvme driver.
> 
> Tested that on my laptop with my Samsung X5 thunderbolt drive, which
> happens to have 4K sectors, support for discard and write zeros.
> 
> Also bunch of fixes sitting in my queue from the period when I developed
> the nvme-mdev driver.
> 
> Best regards,
> 	Maxim Levitsky

I only pointed out just two cosmetic changes.  Thanks very much!

Paolo
