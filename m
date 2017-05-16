Received: from eggs.gnu.org ([2001:4830:134:3::10]:44652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAdIU-0007Sc-95
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dAdIP-0005yO-Ia
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:17:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dAdIP-0005wT-CP
	for qemu-devel@nongnu.org; Tue, 16 May 2017 10:17:53 -0400
References: <1494897683-16395-1-git-send-email-anthony.xu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9fa04242-c144-d5d1-f49b-1bce1df10053@redhat.com>
Date: Tue, 16 May 2017 16:17:38 +0200
MIME-Version: 1.0
In-Reply-To: <1494897683-16395-1-git-send-email-anthony.xu@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] SMM: disable smram region if smm is
 disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Anthony Xu <anthony.xu@intel.com>, qemu-devel@nongnu.org



On 16/05/2017 03:21, Anthony Xu wrote:
> when smm is disabled, smram is not used, so disable it
> 
> Signed-off-by: Anthony Xu <anthony.xu@intel.com>

What is the benefit?

Paolo
